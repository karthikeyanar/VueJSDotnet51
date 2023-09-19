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
