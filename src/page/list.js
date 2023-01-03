import helper from "../common/helper";
export default {
    name: 'List',
    data() {
        return {
            search: {
                'pageIndex': 1,
                'pageSize': 100,
                'sortName': 'lot.RecordDate desc,lot.dm_asset_core_lot_id desc',
                'sortOrder': '',
                'total': 0,
                'pageSizeOptions': [20, 50, 100, 500],
                'symbol': '',
                'fromDate': '01/Jan/2020',
                'toDate': '',
                'isIgnore': false
            },
            newjson: null,
            rows: [],
            xirr: 0,
            totalCapitalCall: 0,
            totalDividendCall: 0,
            totalInvestmentCall: 0,
            totalOptionsCall: 0,
            totalDebtCall: 0
        }
    },
    methods: {
        init: function () {
            var self = this;
            self.getNew(function () {
                self.load();
            });
        },
        getNew: function (callback) {
            var self = this;
            helper.ajax({
                url: "api/Home/New",
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    self.newjson = result;
                    if (callback)
                        callback();
                },
                onError: function (error) {
                    console.log("error=", error);
                },
            });
        },
        load: function () {
            var self = this;
            var json = JSON.parse(JSON.stringify(self.search));
            json.pageSizeOptions = null;
            helper.ajax({
                url: "api/Home/List",
                data: json,
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    self.rows = result.rows;
                    self.xirr = result.xirr;
                    self.totalCapitalCall = result.TotalCapitalCall;
                    self.totalDividendCall = result.TotalDividendCall;
                    self.totalInvestmentCall = result.TotalInvestmentCall;
                    self.totalOptionsCall = result.TotalOptionsCall;
                    self.totalDebtCall = result.TotalDebtCall;
                    self.search.total = result.total;
                    self.$refs.pagination.refresh();
                },
                onError: function (error) {
                    console.log("error=", error);
                },
            });
        },
        addNew: function () {
            var self = this;
            var d = JSON.parse(JSON.stringify(self.newjson));
            d.IsEdit = true;
            self.rows.splice(0, 0, d);
        },
        editRow: function (row) {
            if (row.LotType != 'B' && row.LotType != 'S') {
                row.cloneJSON = JSON.stringify(row);
                row.IsEdit = true;
            }
        },
        cancelRow: function (row) {
            var jsonTEXT = row.cloneJSON;
            row = JSON.parse(jsonTEXT);
            row.IsEdit = false;
        },
        deleteRow: function (row, index) {
            if (confirm('Are you sure?')) {
                var self = this;
                var data = { 'id': row.dm_asset_core_lot_id };
                row.IsSaving = true;
                helper.ajax({
                    url: "api/Home/Delete",
                    method: "DELETE",
                    data: data,
                    onUnAuthorized: function () {
                        console.log("onUnAuthorized");
                        //window.location.href = '/login';
                    },
                    onSuccess: function () {
                        self.rows.splice(index, 1);
                    },
                    onError: function (error) {
                        console.log("error=", error);
                    },
                    onFinally: function () {
                    }
                });
            }
        },
        save: function (row) {
            row.IsSaving = true;
            //row.RecordDate = new Date(row.RecordDate).toISOString();
            helper.ajax({
                url: "api/Home/Create",
                method: "POST",
                data: row,
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    row.IsEdit = false;
                    row.dm_asset_core_lot_id = result.dm_asset_core_lot_id;
                },
                onError: function (error) {
                    console.log("error=", error);
                },
                onFinally: function () {
                    row.IsSaving = false;
                }
            });
        },
        searchSymbol: function (query) {
            helper.ajax({
                url: 'api/Home/SearchSymbol?term=' + query.term,
                onUnAuthorized: function () {
                    //console.log('onUnAuthorized');
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    function resultsCallBack(data) {
                        var s2data = [];
                        data.forEach(d => {
                            s2data.push({
                                "id": d.id,
                                "text": d.label,
                                "source": d
                            });
                        });
                        return {
                            results: s2data
                        };
                    }
                    query.callback(resultsCallBack(result));
                },
                onError: function (error) {
                    console.log('error=', error);
                }
            });
        },
        rowData: function (row) {
            var arr = [];
            if (row) {
                if (helper.cString(row.Symbol) != '') {
                    arr.push({ "id": row.Symbol, "text": row.Symbol, "source": row });
                }
            }
            return arr;
        }
    },
    mounted() {
        let self = this;
        self.init();
    }
}