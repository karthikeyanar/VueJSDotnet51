using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Pepper.Models.CodeFirst;
using System.Data.Objects;
using Pepper.Framework.Validation;
using System.IO;
using System.Reflection;
using System.Configuration;

namespace PepperExcelImport {
    class UpdateUnderlyingFundInstrument {
        public static void Import() {

            PagingDataTable underlyingFunds = (PagingDataTable)Globals.GetExcelDataTable("Table_1");
            PagingDataTable companies = (PagingDataTable)Globals.GetExcelDataTable("Table_2");
            PagingDataTable instrumentDatas = (PagingDataTable)Globals.GetExcelDataTable("Table_3");

            string underlyingFund = string.Empty;
            foreach(DataRow row in underlyingFunds.Rows) {
                underlyingFund = row["Fund Name"].ToString();
                using(PepperContext context = new PepperContext()) {
                    UnderlyingFund uf = context.UnderlyingFunds.Where(q => q.EntityID == Globals.DefaultEntityID && q.FundName == underlyingFund).FirstOrDefault();
                    if(uf == null) {
                        context.UnderlyingFunds.Add(new UnderlyingFund {
                            FundName = underlyingFund,
                            EntityID = Globals.DefaultEntityID,
                        });
                    }
                    Util.WriteNewEntry("Underlying Fund=" + underlyingFund);
                    context.SaveChanges();
                }
            }
            string companyName = string.Empty;
            int? industryID = 0;
            int? geographyID = 0;
            int? yearFounded = 0;
            int? taxStructureID = 0;
            string notes = string.Empty;
            foreach(DataRow row in companies.Rows) {
                companyName = row["Portfolio Company Name"].ToString();
                industryID = Globals.GetIndustryID(row["Industry"].ToString());
                geographyID = Globals.GetGeographyID(row["Geography"].ToString());
                yearFounded = DataTypeHelper.ToInt32(row["Year Founded"].ToString());
                taxStructureID = Globals.GetTaxStructureID(row["Tax Structure of Company"].ToString());
                notes = row["Brief Description of Products and Services (2 or 3 brief sentences / bullet points)"].ToString();
                using(PepperContext context = new PepperContext()) {
                    Company comp = context.Companies.Where(q => q.EntityID == Globals.DefaultEntityID && q.CompanyName == companyName).FirstOrDefault();
                    if(comp == null) {
                        context.Companies.Add(new Company {
                            CompanyName = companyName,
                            IndustryID = ((industryID ?? 0) > 0 ? industryID : null),
                            GeographyID = ((geographyID ?? 0) > 0 ? geographyID : null),
                            TaxStructureID = ((taxStructureID ?? 0) > 0 ? taxStructureID : null),
                            YearFounded = yearFounded,
                            Notes = notes,
                            EntityID = Globals.DefaultEntityID,
                            CreatedBy = Globals.CurrentUser.UserID,
                            CreatedDate = DateTime.Now
                        });
                    } else {
                        comp.CompanyName = companyName;
                        comp.IndustryID = ((industryID ?? 0) > 0 ? industryID : null);
                        comp.GeographyID = ((geographyID ?? 0) > 0 ? geographyID : null);
                        comp.TaxStructureID = ((taxStructureID ?? 0) > 0 ? taxStructureID : null);
                        comp.YearFounded = yearFounded;
                        comp.Notes = notes;
                        comp.LastUpdatedBy = Globals.CurrentUser.UserID;
                        comp.LastUpdatedDate = DateTime.Now;
                        context.Entry(comp).State = EntityState.Modified;
                    }
                    Util.WriteNewEntry("Company=" + companyName);
                    context.SaveChanges();
                }
            }

            int rowIndex = 1;
            DateTime investmentDate;
            DateTime exitDate;
            DateTime maturityDate;
            DateTime exceptionDate;
            DateTime financialDate;
            DateTime seniorLoanMaturityDate;
            decimal totalDebtSeniorFundPosition;
            decimal totalDebtSeniorFundPositionCurrent;
            decimal cashEquivalents;
            decimal cashEquivalentsCurrent;
            decimal LTMRevenue;
            decimal LTMRevenueCurrent;
            decimal LTMEBITDA;
            decimal LTMEBITDACurrent;
            decimal TotalDebt;
            decimal TotalDebtCurrent;
            decimal EnterpriseValue;
            decimal EnterpriseValueCurrent;
            decimal ProjectedIRRMaturity;
            decimal ProjectedTotalAnnualInterest;
            decimal ProjectedOneYearEBITDA;
            decimal AssumedMultiple;
            decimal AssumedMultipleCurrent;

            string columns = string.Empty;
            foreach(DataColumn col in instrumentDatas.Columns) {
                columns += col.ColumnName + Environment.NewLine;
            }

            foreach(DataRow row in instrumentDatas.Rows) {
                rowIndex += 1;
                underlyingFund = row["Investment Vehicle Name (Name of Fund Invested From)"].ToString();
                companyName = row["Portfolio Company Name"].ToString();

                investmentDate = DataTypeHelper.ToFromOADate(row["Date of Investment (MM/DD/YYYY)"].ToString());
                exitDate = DataTypeHelper.ToFromOADate(row["Exit Date (MM/DD/YYYY)"].ToString());
                maturityDate = DataTypeHelper.ToFromOADate(row["Maturity Date (MM-DD-YYYY)"].ToString());
                exceptionDate = DataTypeHelper.ToFromOADate(row["Expected Time of Repayment (MM/DD/YYYY)"].ToString());
                financialDate = DataTypeHelper.ToFromOADate(row["Financial Data As Of (MM/DD/YYYY)"].ToString());
                seniorLoanMaturityDate = DataTypeHelper.ToFromOADate(row["Senior Loan Maturity Date (MM/DD/YYYY)"].ToString());

                totalDebtSeniorFundPosition = DataTypeHelper.ToDecimal(row["Total Debt Senior to Fund Position (Entry)"].ToString());
                totalDebtSeniorFundPositionCurrent = DataTypeHelper.ToDecimal(row["Total Debt Senior to Fund Position (Current/Exit)"].ToString());
                cashEquivalents = DataTypeHelper.ToDecimal(row["Cash and Cash Equivalents (Entry)"].ToString());
                cashEquivalentsCurrent = DataTypeHelper.ToDecimal(row["Cash and Cash Equivalents (Current/Exit)"].ToString());
                LTMRevenue = DataTypeHelper.ToDecimal(row["LTM Revenue (Entry)"].ToString());
                LTMRevenueCurrent = DataTypeHelper.ToDecimal(row["LTM Revenue (Current/Exit)"].ToString());
                LTMEBITDA = DataTypeHelper.ToDecimal(row["LTM EBITDA (Entry)"].ToString());
                LTMEBITDACurrent = DataTypeHelper.ToDecimal(row["LTM EBITDA (Current/Exit)"].ToString());
                TotalDebt = DataTypeHelper.ToDecimal(row["Total Debt (Entry)"].ToString());
                TotalDebtCurrent = DataTypeHelper.ToDecimal(row["Total Debt (Current/Exit)"].ToString());
                EnterpriseValue = DataTypeHelper.ToDecimal(row["Enterprise Value (Entry)"].ToString());
                EnterpriseValueCurrent = DataTypeHelper.ToDecimal(row["Enterprise Value (Current/ Exit)"].ToString());
                ProjectedIRRMaturity = DataTypeHelper.ToDecimal(row["Projected IRR to Maturity"].ToString());
                ProjectedTotalAnnualInterest = DataTypeHelper.ToDecimal(row["Projected Total Annual Interest Expense (at Entry)"].ToString());
                ProjectedOneYearEBITDA = DataTypeHelper.ToDecimal(row["Projected 1 yr EBITDA (at Entry)"].ToString());
                AssumedMultiple = DataTypeHelper.ToDecimal(row["Assumed Multiple for Valuation (Entry)"].ToString());
                AssumedMultipleCurrent = DataTypeHelper.ToDecimal(row["Assumed Multiple for Valuation (Current/Exit)"].ToString());

                using(PepperContext context = new PepperContext()) {
                    Company comp = context.Companies.Where(q => q.EntityID == Globals.DefaultEntityID && q.CompanyName == companyName).FirstOrDefault();
                    UnderlyingFund uf = context.UnderlyingFunds.Where(q => q.EntityID == Globals.DefaultEntityID && q.FundName == underlyingFund).FirstOrDefault();
                    if(uf == null) {
                        context.UnderlyingFunds.Add(new UnderlyingFund {
                            FundName = underlyingFund,
                            EntityID = Globals.DefaultEntityID,
                        });
                        Util.WriteNewEntry("Underlying Fund=" + underlyingFund);
                        context.SaveChanges();
                        uf = context.UnderlyingFunds.Where(q => q.EntityID == Globals.DefaultEntityID && q.FundName == underlyingFund).FirstOrDefault();
                    }
                    if(comp != null && uf != null) {
                        UnderlyingFundCompany ufcompany = context.UnderlyingFundCompanies.Where(q => q.UnderlyingFundID == uf.UnderlyingFundID && q.CompanyID == comp.CompanyID).FirstOrDefault();
                        if(ufcompany == null) {
                            context.UnderlyingFundCompanies.Add(new UnderlyingFundCompany {
                                CompanyID = comp.CompanyID,
                                UnderlyingFundID = uf.UnderlyingFundID,
                                CreatedBy = Globals.CurrentUser.UserID,
                                CreatedDate = DateTime.Now
                            });
                            context.SaveChanges();
                        }
                        ufcompany = context.UnderlyingFundCompanies.Where(q => q.UnderlyingFundID == uf.UnderlyingFundID && q.CompanyID == comp.CompanyID).FirstOrDefault();

                        UnderlyingFundCompanyInstrument ufci = (from q in context.UnderlyingFundCompanyInstruments
                                                                where q.UnderlyingFundCompanyID == ufcompany.UnderlyingFundCompanyID
                                                                && EntityFunctions.TruncateTime(q.InvestmentDate) == investmentDate
                                                                && EntityFunctions.TruncateTime(q.ExitDate) == exitDate
                                                                && EntityFunctions.TruncateTime(q.MaturityDate) == maturityDate
                                                                && EntityFunctions.TruncateTime(q.ExceptionDate) == exceptionDate
                                                                && EntityFunctions.TruncateTime(q.FinancialDate) == financialDate
                                                                && EntityFunctions.TruncateTime(q.SeniorLoanMaturityDate) == seniorLoanMaturityDate
                                                                select q).FirstOrDefault();

                        if(ufci == null) {
                            ufci = new UnderlyingFundCompanyInstrument();
                            ufci.CreatedBy = Globals.CurrentUser.UserID;
                            ufci.CreatedDate = DateTime.Now;
                        }
                        ufci.UnderlyingFundCompanyID = ufcompany.UnderlyingFundCompanyID;
                        ufci.InvestmentDate = investmentDate;
                        ufci.ExitDate = exitDate;
                        ufci.MaturityDate = maturityDate;
                        ufci.ExceptionDate = exceptionDate;
                        ufci.FinancialDate = financialDate;
                        ufci.SeniorLoanMaturityDate = seniorLoanMaturityDate;
                        ufci.TotalDebtSeniorFundPosition = totalDebtSeniorFundPosition;
                        ufci.TotalDebtSeniorFundPositionCurrent = totalDebtSeniorFundPositionCurrent;
                        ufci.CashEquivalents = cashEquivalents;
                        ufci.CashEquivalentsCurrent = cashEquivalentsCurrent;
                        ufci.LTMRevenue = LTMRevenue;
                        ufci.LTMRevenueCurrent = LTMRevenueCurrent;
                        ufci.LTMEBITDA = LTMEBITDA;
                        ufci.LTMEBITDACurrent = LTMEBITDACurrent;
                        ufci.TotalDebt = TotalDebt;
                        ufci.TotalDebtCurrent = TotalDebtCurrent;
                        ufci.EnterpriseValue = EnterpriseValue;
                        ufci.EnterpriseValueCurrent = EnterpriseValueCurrent;
                        ufci.ProjectedIRRMaturity = ProjectedIRRMaturity;
                        ufci.ProjectedTotalAnnualInterest = ProjectedTotalAnnualInterest;
                        ufci.ProjectedOneYearEBITDA = ProjectedOneYearEBITDA;
                        ufci.AssumedMultiple = AssumedMultiple;
                        ufci.AssumedMultipleCurrent = AssumedMultipleCurrent;

                        if(ufci.UnderlyingFundCompanyInstrumentID <= 0) {
                            context.UnderlyingFundCompanyInstruments.Add(ufci);
                        } else {
                            ufci.LastUpdatedBy = Globals.CurrentUser.UserID;
                            ufci.LastUpdatedDate = DateTime.Now;
                            context.Entry(ufci).State = EntityState.Modified;
                        }
                        context.SaveChanges();
                        Util.WriteNewEntry("Underlying Fund Instrument rowIndex=" + rowIndex);
                    } else {
                        Util.WriteError("Company or underlying fund not exist");
                        Util.WriteError("Underlying Fund Instrument rowIndex=" + rowIndex);
                    }
                    context.SaveChanges();
                }
            }
        }
    }
}

