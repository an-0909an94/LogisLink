var AddrComboBox = {
    setAddrName: function(gbn,deptId,pageMode,paramName) {

        var addrName = $("#" + gbn).kendoMultiColumnComboBox({
            dataTextField: "fullAddr",
            dataValueField: "fullAddr",
            filter: "contains",
            //minLength: 2,
            //autoBind: false,
            dataSource: {
                pageSize : 10,
                serverPaging : true,
                serverFiltering: true,
                transport: {
                    read : {
                        url: "/cmm/jibunAddrList.do",
                        dataType: "json",
                        type: "post",
                        data: {
                            deptId : deptId
                        },
                        beforeSend: function(req) {
                            req.setRequestHeader("AJAX", true);
                        }
                    }
                },
                schema : {
                    data : function(response) {
                        return response.data;
                    },
                    total : function(response) {
                        return response.total;
                    }
                }
            },
            height: 200,
            columns: [
                {field: "sido", title: "시도", width:70},
                {field: "gugun", title: "구군", width:120},
                {field: "dong", title: "동", width:140},
                {field: "ri", title: "리", width:80}

            ],
            virtual: {
                itemHeight: 30
            },
            change: function(e){
                var dataItem = e.dataItem;
                var searchData = {
                    fullAddr: this.value(),
                    mode : gbn,
                    pageMode : pageMode
                }
                dummyCommonAddressInfo(searchData,paramName)
            }
        }).data("kendoMultiColumnComboBox");

        //	$("#multicolumncombobox").children().find(".k-select").hide();
        $("#" + gbn).parent().find(".k-select").hide();
        //alert($("#" + gbn + "Addr").parent().find(".k-select").html());
        return addrName;
    }
}

function dummyCommonAddressInfo(data,paramName) {

    $.ajax({
        url: "/contents/basic/data/getLatLon.do",
        type: "POST",
        dataType: "json",
        data: {
            searchAddress: data.fullAddr,
            size: 10
        },
        success: function(apiData){
            var localData = JSON.parse(apiData.data);
            var lat = '';
            var lon = '';
            if(apiData.result && localData.meta.total_count >0){
                lon = localData.documents[0].x;
                lat = localData.documents[0].y;
                var addressData = localData.documents[0].address_type =="REGION" ? localData.documents[0].address : localData.documents[0].road_address;

                if(data.mode == "sAddr") {
                    $("#" + paramName.sAddress).val(data.fullAddr);
                    $("#" + paramName.sSido).val(addressData.region_1depth_name);
                    $("#" + paramName.sGungu).val(addressData.region_2depth_name);
                    $("#" + paramName.sDong).val("");
                    $("#" + paramName.sLon).val(lon);
                    $("#" + paramName.sLat).val(lat);

                    if(data.pageMode =="orderList") {
                        if($('#sComName').val().trim()!="") {
                            $("input:checkbox[id='sAreaSave']").prop("checked", true);
                            $("input:checkbox[id='sAreaSave']").val("Y")
                            $("#sAreaSave").parent(".radio-or-checkBox").css("display", "contents");
                            $("#sAddrDetail").focus();
                        }
                    }
                }else{
                    $("#" + paramName.eAddress).val(data.fullAddr);
                    $("#" + paramName.eSido).val(addressData.region_1depth_name);
                    $("#" + paramName.eGungu).val(addressData.region_2depth_name);
                    $("#" + paramName.eDong).val("");
                    $("#" + paramName.eLon).val(lon);
                    $("#" + paramName.eLat).val(lat);

                    if(data.pageMode =="orderList") {
                        if($('#eComName').val().trim()!=""){
                            $("input:checkbox[id='eAreaSave']").prop("checked", true);
                            $("input:checkbox[id='eAreaSave']").val("Y")
                            $("#eAreaSave").parent(".radio-or-checkBox").css("display", "contents");
                            $("#eAddrDetail").focus();
                        }
                    }
                }
                if(data.pageMode =="orderList" && ($("#" + paramName.sAddr).val() !="" && $("#" + paramName.eAddr).val() !="")) {
                    getCommonRoute(paramName);
                }
            }else{
                if(data.mode == "sAddr") {
                    // $("#"+ paramName.sAddress).val("");
                    $("#"+ paramName.sSido).val("");
                    $("#"+ paramName.sGungu).val("");
                    $("#"+ paramName.sDong).val("");
                    if(data.pageMode =="orderList") {
                        $("#distance").val("");
                        $("#time").val("");
                        $("#timeTxt").val("");
                    }
                    $("#" + data.mode).focus();

                }else{
                    // $("#"+ paramName.eAddress).val("");
                    $("#"+ paramName.eSido).val("");
                    $("#"+ paramName.eGungu).val("");
                    $("#"+ paramName.eDong).val("");
                    if(data.pageMode =="orderList") {
                        $("#distance").val("");
                        $("#time").val("");
                        $("#timeTxt").val("");
                        $("#" + data.mode).focus();
                    }
                }
                if($("#" + data.mode).val().trim() !=""){
                    alert("유효한 주소가 아닙니다");
                }
                return;
            }
        }
    });
    /*
    $("#distance").val("");
    $("#time").val("");
    $("#timeTxt").val(""); */
}


function getCommonRoute(paramName){
    var sLat = $("#" + paramName.sLat).val();
    var sLng = $("#" + paramName.sLon).val();
    var eLat = $("#" + paramName.sLat).val();
    var eLng = $("#" + paramName.eLon).val();
    if(sLat && sLng && eLat && eLng) {
        var param = "sLat=" + sLat + "&sLng=" + sLng + "&eLat=" + eLat + "&eLng=" + eLng;

        $.ajax({
            url: "/cmm/getRoute.do",
            type: "POST",
            dataType: "json",
            data: param,
            success: function(data){
                if(data.result){
                    var time = data.data.Time;
                    var timeTxt = "";
                    $("#distance").val(data.data.Distance);
                    $("#time").val(time);

                    if(time > 60) {
                        timeTxt = parseInt(time / 60) + "시간 " + (time%60) + "분";
                    }else {
                        timeTxt = time + "분";
                    }
                    $("#timeTxt").val(timeTxt);
                }
            }
        })
    }
}