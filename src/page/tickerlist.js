import helper from "../common/helper";
export default {
    name: 'TickerList',
    data() {
        return {
            search: {
                'periodDate': '2023-06-30'
            },
            listSearch: {
                'sortName': 'PL',
                'sortOrder': 'asc',
            },
            rows: []
        }
    },
    methods: {
        init: function () {
            var self = this;
            self.load(function () {
            });
        },
        load: function (callback) {
            var self = this;
            var json = JSON.parse(JSON.stringify(self.search));
            json.pageSizeOptions = null;
            helper.ajax({
                url: "api/Home/TickerList",
                data: json,
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    self.rows = result;
                    try {
                        if (callback)
                            callback();
                    } catch (ex) { console.log(ex); }
                },
                onError: function (error) {
                    console.log("error=", error);
                },
            });
        }
    },
    mounted() {
        let self = this;
        self.init();
    }
}