
import axios from 'axios'
export default {
    ajax: async (options) => {
        var token = localStorage.getItem('token');
        var type = localStorage.getItem('type');
        if (options.method !== 'POST') {
            if (options.data) {
                var esc = encodeURIComponent;
                options.url = options.url + '?' + Object.keys(options.data).map(key => esc(key) + '=' + esc(options.data[key])).join('&');
            }
        }
        console.log('options.headers1=', options.headers);
        if (!options.headers) {
            console.log(1);
            options.headers = {};
        }
        console.log('ajax token=', token);
        if (token !== '') {
            options.headers.Authorization = type + ' ' + token;
        }
        console.log('options.headers=', options.headers);
        axios({
            url: options.url,
            method: (options.method ? options.method : 'GET'),
            data: (options.data ? options.data : null),
            headers: (options.headers ? options.headers : null)
        })
            .then(function (response) {
                //console.log('ajax response=', response)
                if (options.onSuccess) {
                    options.onSuccess(response.data);
                }
            })
            .catch(function (error) {
                if (error.response) {
                    // The request was made and the server responded with a status code
                    // that falls out of the range of 2xx
                    console.log('error.response.data=', error.response.data);
                    console.log('error.response.status=', error.response.status);
                    console.log('error.response.headers=', error.response.headers);
                    if (error.response.status === 401) {
                        if (options.onUnAuthorized) {
                            options.onUnAuthorized();
                        } else {
                            // window.location.href = '/authentication/login';
                        }
                    } else if (error.response.status === 400) {
                        if (options.onBadRequest) {
                            options.onBadRequest(error);
                        }
                    }
                } else if (error.request) {
                    // The request was made but no response was received
                    // `error.request` is an instance of XMLHttpRequest in the browser and an instance of
                    // http.ClientRequest in node.js
                    console.log('error.request=', error.request);
                } else {
                    // Something happened in setting up the request that triggered an Error
                    console.log('catch error=', error.message);
                }
                if (options.onError) {
                    options.onError(error);
                }
                console.log('error.config=', error.config);
            })
            .then(function () {
                if (options.onFinally) {
                    options.onFinally();
                }
            });
    }
}