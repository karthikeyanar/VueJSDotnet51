import helper from "../common/helper";
export default {
    created() {
        //  this.hello()
    },
    data() {
        return {
            colors: [
                '#5A8770', '#0088B9', '#A50A98', '#F12765', '#0677B3',
                '#A6B12E', '#BD7B16', '#D93A37', '#5D3372', '#82024A',
                '#424101', '#4B1B38', '#F44336', '#E91E63', '#9C27B0',
                '#673AB7', '#3F51B5', '#004D45', '#214D22', '#5E661B',
                '#4D2C18', '#4D362E', '#4D4D4D', '#35454D',
            ]
        }
    },
    methods: {
        formatNumber(v, decimalPlace, isAcceptZero) {
            return helper.formatNumber(v, decimalPlace, isAcceptZero);
        },
        formatDate(d, f) {
            return helper.formatDate(d, f);
        },
        cBool: function (value) {
            return helper.cBool(value);
        }
    }
}