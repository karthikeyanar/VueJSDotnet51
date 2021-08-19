using System;
using System.ComponentModel.DataAnnotations;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.Extensions.Options;
using Microsoft.IdentityModel.Tokens;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication;
using System.Collections;
using System.Collections.Generic;

namespace VueJSDotnet51.Controllers {
    
    public class JwtBearerTokenSettings {
        public string SecretKey { get; set; }
        public string Audience { get; set; }
        public string Issuer { get; set; }
        public int ExpiryTimeInDays { get; set; }
    }

    public class UserDetails {
        [Required]
        public string UserName { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        public string Email { get; set; }

        
        [Required]
        public string Role { get; set; }
    }
    public class LoginCredentials {
        public string Username { get; set; }

        public string Password { get; set; }

        public bool RememberMe {get; set;}
    }

    [Authorize]
    [Route("api/[controller]")]
    [ApiController]
    public class AccountController : ControllerBase {
        
        private readonly UserManager<IdentityUser> userManager;

        public AccountController(UserManager<IdentityUser> userManager) {
            this.userManager = userManager;
        }

        [HttpGet]
        [Route("User")]
        public async Task<IActionResult> GetUser() {
            if(HttpContext.User.Identity.IsAuthenticated){
                var user = await this.userManager.FindByNameAsync(HttpContext.User.Identity.Name);    
                var roles = await this.userManager.GetRolesAsync(user);
                return Ok(new {
                    Email = user.Email,Role = roles[0]
                });
            } else {
                return new BadRequestObjectResult(new { Message = "User does not exist" });
            }
        }
    }

    [Route("api/[controller]")]
    [ApiController]
    public class AuthController : ControllerBase {
        private readonly JwtBearerTokenSettings jwtBearerTokenSettings;
        private readonly UserManager<IdentityUser> userManager;
        private readonly RoleManager<IdentityRole> roleManager;

        public AuthController(IOptions<JwtBearerTokenSettings> jwtTokenOptions, UserManager<IdentityUser> userManager
        , RoleManager<IdentityRole> roleManager) {
            this.jwtBearerTokenSettings = jwtTokenOptions.Value;
            this.userManager = userManager;
            this.roleManager = roleManager;
        }

        [HttpPost]
        [Route("Register")]
        public async Task<IActionResult> Register([FromForm] UserDetails userDetails) {
            List<string> errors = new List<string>();
            if (!ModelState.IsValid || userDetails == null) {
                //var dictionary = new ModelStateDictionary();
                foreach(var values in ModelState.Values) {
                    foreach(var error in values.Errors) {
                        if(string.IsNullOrEmpty(error.ErrorMessage) == false) {
                            //dictionary.AddModelError("", error.ErrorMessage);
                            errors.Add(error.ErrorMessage);
                        }
                    }
                }
                return new BadRequestObjectResult(new { Message = "User Registration Failed", Errors = errors });
            }
            //await this.roleManager.CreateAsync(new IdentityRole { Name = "A",NormalizedName = "A" });
            //await this.roleManager.CreateAsync(new IdentityRole { Name = "M",NormalizedName = "M" });

            var identityUser = new IdentityUser() { UserName = userDetails.UserName, Email = userDetails.Email };
            var result = await userManager.CreateAsync(identityUser, userDetails.Password);
            if (!result.Succeeded) {
                //var dictionary = new ModelStateDictionary();
                foreach (IdentityError error in result.Errors) {
                   // dictionary.AddModelError(error.Code, error.Description);
                   errors.Add(error.Description);
                }

                return new BadRequestObjectResult(new { Message = "User Registration Failed", Errors = errors });
            } else {
                await userManager.AddToRoleAsync(identityUser,userDetails.Role);
            }
            return Ok(new { User = identityUser, Message = "User Reigstration Successful" });
        }

        /*
        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromForm] LoginCredentials credentials) {
            IdentityUser identityUser = null;
            if (!ModelState.IsValid ||
                credentials == null ||
                (identityUser = await ValidateUser(credentials)) == null) {
                return new BadRequestObjectResult(new { Message = "Login failed" });
            }  
            if (identityUser != null) {
                PasswordVerificationResult resultEnum = this.userManager.PasswordHasher.VerifyHashedPassword(identityUser, identityUser.PasswordHash, credentials.Password);
                if (resultEnum == PasswordVerificationResult.Success) {
                    var identity = new ClaimsIdentity(CookieAuthenticationDefaults.AuthenticationScheme);
                    identity.AddClaim(new Claim(ClaimTypes.Email, identityUser.Email));
                    identity.AddClaim(new Claim(ClaimTypes.Name, identityUser.UserName));

                    var principal = new ClaimsPrincipal(identity);
                    var props = new AuthenticationProperties();
                    props.IsPersistent = credentials.RememberMe;

                    await HttpContext.SignInAsync(CookieAuthenticationDefaults.AuthenticationScheme, principal, props);
                    return Ok(new { IsSuccess = true });
                }  else {
                    return new BadRequestObjectResult(new { Message = "Login failed" });
                }
            }  else {
                return new BadRequestObjectResult(new { Message = "Login failed" });
            }
        }
        */

        [HttpPost]
        [Route("Login")]
        public async Task<IActionResult> Login([FromForm] LoginCredentials credentials) {
            IdentityUser identityUser = null;
            if (!ModelState.IsValid ||
                credentials == null ||
                (identityUser = await ValidateUser(credentials)) == null) {
                return new BadRequestObjectResult(new { Message = "Login failed" });
            }  
            return Ok(new { type = "Bearer", token = GenerateToken(identityUser,credentials.RememberMe) });
        }

        [HttpPost]
        [Route("Logout")]
        public IActionResult Logout() {
            // Well, What do you want to do here ?
            // Wait for token to get expired OR 
            // Maintain token cache and invalidate the tokens after logout method is called
            return Ok(new { Token = "", Message = "Logged Out" });
        }

        private async Task<IdentityUser> ValidateUser(LoginCredentials credentials) {
            var identityUser = await userManager.FindByNameAsync(credentials.Username);
            if (identityUser != null) {
                var result = userManager.PasswordHasher.VerifyHashedPassword(identityUser, identityUser.PasswordHash, credentials.Password);
                return result == PasswordVerificationResult.Failed ? null : identityUser;
            }

            return null;
        }

        private object GenerateToken(IdentityUser identityUser,bool isRememberMe) {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(jwtBearerTokenSettings.SecretKey);

            DateTime expireDate = DateTime.UtcNow.AddSeconds(1800); //30 min
            if(isRememberMe){
                expireDate = DateTime.UtcNow.AddSeconds(jwtBearerTokenSettings.ExpiryTimeInDays); //30 min
            }

            var tokenDescriptor = new SecurityTokenDescriptor {
                Subject = new ClaimsIdentity(new Claim[] {
                new Claim(ClaimTypes.Name, identityUser.UserName.ToString()),
                new Claim(ClaimTypes.Email, identityUser.Email)
                }),

                Expires = expireDate,
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature),
                Audience = jwtBearerTokenSettings.Audience,
                Issuer = jwtBearerTokenSettings.Issuer
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
    }
}
