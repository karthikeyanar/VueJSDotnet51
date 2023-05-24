import helper from "../common/helper";
export default {
    name: 'List',
    data() {
        return {
            search: {
                'pageIndex': 1,
                'pageSize': 20,
                'sortName': 'lot.RecordDate desc,lot.dm_asset_core_lot_id desc',
                'sortOrder': '',
                'total': 0,
                'pageSizeOptions': [20, 50, 100, 500],
                'symbol': '',
                'fromDate': '01/Jan/2020',
                'toDate': '',
                'isIgnore': false,
                'isOptions': false,
                'isGold': false,
                'tradeType':''
            },
            listSearch: {
                'sortName': 'PL',
                'sortOrder': 'asc',
            },
            isTransaction: false,
            newjson: null,
            rows: [],
            shares:[],
            xirr: 0,
            totalCapitalCall: 0,
            totalDividendCall: 0,
            totalInvestmentCall: 0,
            totalStrategyCall: 0,
            totalOptionsCall: 0,
            totalDebtCall: 0,
            totalGold:0,
            totalPL: 0,
            totalUnRealizedPL: 0,
            totalPLPercent: 0,
            totalUnRealizedPLPercent: 0,
            currentMarketValue:0,
            allocationAmount:0,
            allocationList: [],
            isShowAllocation: false,
            indexList:[]
        }
    },
    methods: {
        init: function () {
            var self = this;
            self.getNew(function () {
                self.load(function () {
                    self.allocationAmount = 0;//self.totalInvestmentCall;
                });
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
        load: function (callback) {
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
                    self.totalStrategyCall = result.TotalStrategyCall;
                    self.totalOptionsCall = result.TotalOptionsCall;
                    self.totalDebtCall = result.TotalDebtCall;
                    self.totalGold = result.TotalGold;
                    self.totalPL = result.TotalPL;
                    self.totalUnRealizedPL = result.TotalUnRealizedPL;
                    self.currentMarketValue = result.CurrentMarketValue;
                    self.totalPLPercent = (self.totalPL / self.totalCapitalCall) * 100;
                    self.totalUnRealizedPLPercent = (self.totalUnRealizedPL / self.totalCapitalCall) * 100;
                    self.search.total = result.total;
                    self.indexList = result.indexList;
                    self.$refs.pagination.refresh();
                    self.loadShares();
                    try {
                        if (callback)
                            callback();
                    } catch (ex) { console.log(ex); }
                },
                onError: function (error) {
                    console.log("error=", error);
                },
            });
        }, 
        loadShares: function () {
            var self = this;
            var json = JSON.parse(JSON.stringify(self.search));
            json.sortName = self.listSearch.sortName;
            json.sortOrder = self.listSearch.sortOrder;
            json.pageSizeOptions = null;
            json.isCurrent = true;
            helper.ajax({
                url: "api/Home/ListShare",
                data: json,
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                    self.shares = result;
                },
                onError: function (error) {
                    console.log("error=", error);
                },
            });
        },
        loadAllocation: function (callback) {
            var self = this;
            helper.ajax({
                url: "api/Home/AllocationList?totalAmount=" + self.allocationAmount,
                onUnAuthorized: function () {
                    console.log("onUnAuthorized");
                    //window.location.href = '/login';
                },
                onSuccess: function (result) {
                     self.allocationList = result;
                     if(callback)
                        callback();
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