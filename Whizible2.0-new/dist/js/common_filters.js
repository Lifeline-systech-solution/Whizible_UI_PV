
function ClearBasicFilter(module) {
    $("[id*=cbo" + module + "Filter]").each(function (obj) {
        var cbo = this.id;
        $("#" + cbo + " option:first").prop('selected', 'selected');
    });

    $("[id*=txt" + module + "Filter]").each(function (obj) {
        var txt = this.id;
        $("#" + txt).val('').change();
    });      
}

function GenerateBasicFilterQuery(module, AllFields) {
    
    var strqtext = "";
    for (var i = 0; i < AllFields.length; i++) {
        var strvalue = '';
        var strOp = $('select#cbo' + module + 'Filter' + AllFields[i] + ' option:selected').val();

        strvalue = $("#txt" + module + "Filter" + AllFields[i]).val();
        if (strvalue != "" && strvalue != null && strOp != "" && strvalue != null && strOp != undefined && strvalue != undefined) {
            if (strqtext != "") strqtext += " AND ";
            if (strOp == "Contains") {
                strqtext += AllFields[i] + " LIKE ";
                strqtext += " ''%" + strvalue + "%''";
            }
            else if (strOp == "Ends With") {
                strqtext += AllFields[i] + " LIKE ";
                strqtext += " ''%" + strvalue + "''";
            }
            else if (strOp == "Exact Word") {
                strqtext += AllFields[i] + " = ";
                strqtext += " ''" + strvalue + "''";
            }
            else if (strOp == "Not Contains") {
                strqtext += AllFields[i] + " ";
                strqtext += " NOT LIKE ''%" + strvalue + "%''";
            }
            else if (strOp == "Starts With") {
                strqtext += AllFields[i] + " LIKE ";
                strqtext += " ''" + strvalue + "%''";
            }
            else {
                strqtext += AllFields[i] + " ";
                strqtext += strOp + " ''" + strvalue + "''";
            }
        }
    }
    strqtext = strqtext.replace('Over', '[Over]');
    //alert(strqtext);
    return strqtext;
}

function BindBasicFilters(qtext, module) {
    ClearBasicFilter(module);
    var isAnd = qtext.indexOf(' AND ');
    if (isAnd > 0) {
        var rowsAnd = qtext.split(' AND ');
        for (i = 0; i < rowsAnd.length; i++) {
            BindBasicFilterValues(rowsAnd[i], module);
        }
    }
    else {
        BindBasicFilterValues(qtext, module);
    }
}  

function BindBasicFilterValues(qtext, module) {
    var field = qtext.substr(0, qtext.indexOf(' '));
    var op = orgop = "";
    var val = valstr = "";

    var opstr = qtext.substr(qtext.indexOf(' '), qtext.length).trim();
    var opchar = opstr.substr(0, 1);
    if (opchar == "N" || opchar == "L") {
        if (opchar == "N") {
            op = "Not Contains";
            orgop = "NOT LIKE";
            valstr = opstr.substr(orgop.length, opstr.length).trim();
            val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
        }
        if (opchar == "L") {
            orgop = "LIKE";
            valstr = opstr.substr(orgop.length, opstr.length).trim();
            if (valstr.indexOf('%') == 1) {
                if (valstr.substr(2, valstr.length).indexOf('%') > 0) {
                    op = "Contains";
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 4);
                }
                else {
                    op = "Ends With";
                    val = valstr.substr(valstr.indexOf('%') + 1, valstr.length - 3);
                }
            }
            else {
                op = "Starts With";
                val = valstr.substr(1, valstr.length - 3);
            }
        }
    }
    else {
        op = opstr.substr(0, opstr.indexOf(' '));
        valstr = opstr.substr(op.length, opstr.length).trim();
        val = valstr.substr(1, valstr.length - 2);
    }
    if (op == '=') {
        var cbo = "cbo" + module + "Filter" + field;
        if ($("#" + cbo + " option[value='" + op + "']").length == 0) {
            op = "Exact Word"
        }
    }
    $('#cbo' + module + 'Filter' + field).val(op).change();
    $('#txt' + module + 'Filter' + field).val(val).change();
}