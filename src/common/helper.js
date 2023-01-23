
import axios from 'axios';
import accounting from 'accounting-js';
import moment from "moment";
import $ from "jquery";
export default {
    ajax: async (options) => {
        const token = '';
        if (options.method !== 'POST') {
            if (options.data) {
                var esc = encodeURIComponent;
                options.url = options.url + '?' + Object.keys(options.data).map(key => esc(key) + '=' + esc(options.data[key])).join('&');
            }
        }
        //console.log('options.headers1=', options.headers);
        if (!options.headers) {
            //console.log(1);
            options.headers = {};
        }
        //console.log('ajax token=', token);
        if (token !== '') {
            options.headers.Authorization = 'Bearer ' + token;
        }
        //console.log('options.headers=', options.headers);
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
    },
    formatNumber: function (d, precision, isAcceptZero) {
        if (precision == undefined || precision == null || precision <= 0) {
            precision = 2;
        }
        if (d == 0 && isAcceptZero == true) {
            return 0;
        } else {
            if (d == 0) {
                return "";
            } else {
                var v = accounting.formatNumber(d, { precision: precision });
                return v;
            }
        }
    },
    formatDate: function (d, f) {
        if (d == "") {
            return "";
        }
        if (f == "" || f == undefined || f == null) {
            f = "DD/MMM/YYYY";
        }
        var ty = $.type(d);
        if (ty == "object")
            return "";
        var m = moment(d);
        console.log('formatDate d=', d, ',f=', f);
        if (m.get('year') <= 1901)
            return "";
        else
            return m.format(f);
    },
    cString: function (value) {
        if (value == "undefined" || value == "null" || value == null || value == undefined)
            return '';
        else
            return value.toString();
    },
    cBool: function (value) {
        if (value == "undefined" || value == "null" || value == null || value == undefined)
            return false;
        else if (value == true || value.toString().toLowerCase() == "true" || value.toString() == "1")
            return true;
        else
            return false;
    },
    convertParams: function (item, listKeys) {
        var self = this;
        var arr = [];
        var keys = Object.keys(item);
        if (!listKeys) {
            listKeys = [];
        }
        listKeys.push('Errors');
        $.each(keys, function (i, key) {
            var v = self.cString(item[key]);
            //console.log('key=' + key + ',v=' + v);
            var isExist = false;
            $.each(listKeys, function (z, lk) {
                if (lk == key) {
                    isExist = true;
                    return false;
                }
            });
            if (isExist == false) {
                arr = self.appendParams(arr, key, v);
            }
        });
        return arr;
    },
    appendParams: function (params, name, value) {
        var param = null;
        if (params != null) {
            var cnt = 0;
            $.each(params, function (i, p) {
                if (p.name == name) {
                    cnt = cnt + 1;
                }
            });
            if (cnt > 1) {
                var i;
                for (i = 0; i < params.length; i++) {
                    if (params[i].name == name && cnt > 1) {
                        params.splice(i, 1);
                        cnt = cnt - 1;
                    }
                }
            }
            $.each(params, function (i, p) {
                if (p.name == name) {
                    param = p;
                }
            });
        }
        if (param == null) {
            param = { "name": name, "value": value };
            params.push(param);
        }
        param.value = value;
        return params;
    }
}