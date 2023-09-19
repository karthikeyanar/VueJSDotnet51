// This script gets injected into any opened page
// whose URL matches the pattern defined in the manifest
// (see "content_script" key).
// Several foreground scripts can be declared
// and injected into the same or different pages.

console.log("This prints to the console of the page (injected only if the page url matched)")

function tableStructure() {
    this.cols = [];
    this.rows = [];
}

function removeHTML(html) {
    var regex = /(<([^>]+)>)/ig,
        body = html,
        result = body.replace(regex, "");

    return $.trim(result); //.replace(/\s+$/g, "").replace(/(\r\n|\n|\r)/gm, "").replace(/\s+/g, "");
}

// The download function takes a CSV string, the filename and mimeType as parameters
// Scroll/look down at the bottom of this snippet to see how download is called
var download = function (content, fileName, mimeType) {
    var a = document.createElement('a');
    mimeType = mimeType || 'application/octet-stream';

    if (navigator.msSaveBlob) { // IE10
        navigator.msSaveBlob(new Blob([content], {
            type: mimeType
        }), fileName);
    } else if (URL && 'download' in a) { //html5 A[download]
        a.href = URL.createObjectURL(new Blob([content], {
            type: mimeType
        }));
        a.setAttribute('download', fileName);
        document.body.appendChild(a);
        a.click();
        document.body.removeChild(a);
    } else {
        location.href = 'data:application/octet-stream,' + encodeURIComponent(content); // only this mime type is supported
    }
}

function exportTable(tabid, openerId) {
    window.alert = function () { };
    var colRowIndex = 0;
    var cols = '';
    var struct = new tableStructure();
    var isStop = false;


    var cmd = 'list';
    if (cmd == 'list') {
        struct.cols.push('Symbol');
        struct.cols.push('URL');
        $(".constituent-data-row-holder").each(function () {
            var $this = $(this);
            var $h5 = $("h5.w-full.ellipsis.mb2");
            var $lnk = $("a", $h5);
            var $span = $("span.typography-caption-medium.ticker.text-uppercase.mr4");
            console.log('$this=', $this[0]);
            console.log('$h5=', $h5[0]);
            console.log('$lnk=', $lnk[0]);
            console.log('$span=', $span[0]);
            var row = [];
            if ($span[0] && $lnk[0]) {
                row.push($span.html());
                row.push($lnk.attr('href'));
            }
            if (row.length > 0) {
                struct.rows.push(row);
            }
        });
    }
    //////console.log(struct);
    var csvContent = convertCSVContent(struct, '\n');
    var fileName = '';
    if (struct.cols.length > 0) {
        fileName += struct.cols[0] + '-' + struct.cols[1] + '-' + struct.cols[struct.cols.length - 1] + '.csv';
    }
    ////console.log('fileName=', fileName);
    download(csvContent, fileName, 'text/csv;encoding:utf-8');
    setTimeout(function () {
        //chrome.runtime.sendMessage({ cmd: 'mc-quaterly-downloaded','tabid':openerId  });
        chrome.runtime.sendMessage({ cmd: 'close_tab', 'tabid': tabid, 'openerid': openerId });
    }, 1000);
}

function getCells($tbl, key, name) {
    var values = '';
    $("tbody > tr", $tbl).each(function () {
        var $tr = $(this);
        var $tdFirst = $("td:eq(0)", $tr);
        var profits = '';
        console.log('tdFirst', $tdFirst[0]);
        if ($tdFirst[0]) {
            if ($tdFirst.html().indexOf(key) > -1) {
                $("td", $tr).each(function (i) {
                    console.log('i=', i);
                    if (i > 0) {
                        profits += $(this).text() + ';';
                    }
                });
            }
            if (profits != '') {
                profits = profits.substring(0, profits.length - 1);
            }
            if (profits != '') {
                values += name + '~' + profits + '~' + '' + '|';
            }
        }
    });
    console.log('values=', values);
    return values;
}

function removeHTMLTags(content) {
    var cleanText = '';
    cleanText = $.trim(content.replace(/>\s*</g, "> <").toString());
    //console.log('cleanText 1=', cleanText);
    cleanText = $.trim(cleanText.replace(/<\/?[^>]+(>|$)/g, '').toString());
    //cleanText = $.trim(cleanText.replace(/\n/g, "").toString());
    //console.log('cleanText 2=', cleanText);
    return cleanText;
}

function simulateClick(element) {
    // DOM 2 Events
    var dispatchMouseEvent = function (target, var_args) {
        try {
            var e = document.createEvent("MouseEvents");
            // If you need clientX, clientY, etc., you can call
            // initMouseEvent instead of initEvent
            e.initEvent.apply(e, Array.prototype.slice.call(arguments, 1));
            target.dispatchEvent(e);
        } catch (exc) {
            console.log('simulateClick exc=', exc);
        }
    };
    dispatchMouseEvent(element, 'mouseover', true, true);
    dispatchMouseEvent(element, 'mousedown', true, true);
    dispatchMouseEvent(element, 'click', true, true);
    dispatchMouseEvent(element, 'mouseup', true, true);
}

function sendKeys($txt, value, isfocus) {
    //console.log('$txt=', $txt[0], 'value=', value);
    if (isfocus == true) {
        $txt.focus();
    }
    $txt.sendkeys(value);
}

function pageLoad(pageUrl, tabId, openerId, symbol) {
    ////console.log('pageLoad pageUrl=',pageUrl,'tabId=',pageUrl,'openerId=',openerId);
    nseStart(pageUrl, tabId, openerId, symbol);
}

function convertCSVContent(struct, newlinechar) {
    var content = '';
    var cols = '';
    var rows = '';
    for (var i = 0; i < struct.cols.length; i++) {
        cols += '"' + struct.cols[i] + '",';
    }
    if (cols != '') {
        cols = cols.substring(0, cols.length - 1);
    }
    cols = cols + newlinechar;

    for (var i = 0; i < struct.rows.length; i++) {
        var row = '';
        for (var j = 0; j < struct.rows[i].length; j++) {
            row += '"' + struct.rows[i][j] + '",';
        }
        if (row != '') {
            row = row.substring(0, row.length - 1);
        }
        rows += row + newlinechar;
    }

    content = cols + rows;
    //////console.log(content);
    return content;
}

// foreground.js
$(document).ready(function () {
    var url = window.location.href; //console.log("Current URL:", window.location.href);
    if (url.indexOf('tickertape.in/stocks/') > 0) {
        // Your jQuery code here
        // For example:
        var $bdy = $("body");
        console.log($bdy[0]);
        setTimeout(function () {
            var symbol = $(".sidebar > .sidebar-security-ticker > .ticker.text-teritiary.font-medium", $bdy).html();
            console.log('symbol=' + symbol);
            if (symbol != '') {
                var $root = $(".financials-tab-root", $bdy);
                var $income = $("div[data-section-tag='income']", $root);
                var $heading = $(".typography-h5.text-primary", $income);
                var $h2 = $("h2", $heading);
                console.log('$root=', $root[0]);
                console.log('$heading=', $heading[0]);
                console.log('$income=', $income[0]);
                console.log('$h2=', $h2[0]);
                if ($h2.html() == 'Income Statement') {
                    var $tbl = $("table[data-statement-type='income']", $root);
                    var $thead = $("thead", $tbl);
                    console.log('$tbl=', $tbl[0]);
                    console.log('$thead=', $thead[0]);
                    var colRowIndex = 0;
                    var cols = '';
                    var struct = new tableStructure();
                    var isStop = false;
                    $("tr", $thead).each(function () {
                        var $tr = $(this);
                        var $first = $(".first-head.cell", $tr);
                        if ($first.html() == 'Quarter') {
                            $("th", $tr).each(function (i) {
                                var $th = $(this);
                                var text = removeHTML($th.html());
                                console.log('i=' + i + ',text=' + text);
                                struct.cols.push(text);
                            });
                        }
                    });
                    var $tbody = $("tbody", $tbl);
                    $("tr", $tbody).each(function () {
                        var $tr = $(this);
                        var row = [];
                        $("td", $tr).each(function (i) {
                            var $td = $(this);
                            var text = removeHTML($td.html());
                            console.log('i=' + i + ',text=' + text);
                            row.push(text);
                        });
                        if (row.length > 0) {
                            struct.rows.push(row);
                        }
                    });
                    var csvContent = convertCSVContent(struct, '\n');
                    var fileName = symbol + '.csv';
                    ////console.log('fileName=', fileName);
                    download(csvContent, fileName, 'text/csv;encoding:utf-8');
                }
            }
        }, 2000);
    }
});