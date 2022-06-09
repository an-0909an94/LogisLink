/**
 * 자바스크립트 공통 함수 정의
 */
var menuList = "";
var currMenuName = "";
var sNavi	 = "";
var currMenuId	 = "";

//form 태그 내의 요소(키+값)들을 json 형식으로 파싱한다.
jQuery.fn.serializeObject = function() { 
	var obj = null; 
	try { 
	    if(this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) { 
	        var arr = this.serializeArray(); 
	        if(arr){ obj = {}; 
	        jQuery.each(arr, function() { 
	            obj[this.name] = this.value; }); 
	        } 
	    } 
	}catch(e) { 
	    alert(e.message); 
	}finally {} 

	return obj; 
}

//jquery chrome 대응
jQuery.event.special.touchstart = {
		  setup: function( _, ns, handle ){
		    if ( ns.includes("noPreventDefault") ) {
		      this.addEventListener("touchstart", handle, { passive: false });
		    } else {
		      this.addEventListener("touchstart", handle, { passive: true });
		    }
		  }
		};
jQuery.event.special.wheel = {
	    setup: function( _, ns, handle ){
		    if ( ns.includes("noPreventDefault") ) {
		    	this.addEventListener("wheel", handle, { passive: false });
		    } else {
		    	this.addEventListener("wheel", handle, { passive: true });
		    }
	    }
	};
jQuery.event.special.mousewheel = {
	    setup: function( _, ns, handle ){
		    if ( ns.includes("noPreventDefault") ) {
		    	this.addEventListener("mousewheel", handle, { passive: false });
		    } else {	
		    	this.addEventListener("mousewheel", handle, { passive: true });
		    }	
	    }
	};
jQuery.event.special.scroll = {
	    setup: function( _, ns, handle ){
		    if ( ns.includes("noPreventDefault") ) {
		    	this.addEventListener("scroll", handle, { passive: false });
		    } else {
		    	this.addEventListener("scroll", handle, { passive: true });
		    }
	    }
	};

$.ajaxSetup({
	beforeSend: function(xhr) {
		xhr.setRequestHeader("AJAX", true);
	},
	error: function(xhr, status, err) {
		if(xhr.status == 400) {
			alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
			location.href = "/";
		} else {
			alert("오류가 발생했습니다. 관리자에게 문의하세요.");
		}
	}
})

//날짜값을 yyyy-mm 형식으로 변환
Date.prototype.yyyymm = function(){
	var yyyy	= this.getFullYear().toString();
	var mm		= (this.getMonth() + 1).toString();
	
	return yyyy + "-" +  (mm[1] ? mm : "0" + mm[0]);
}


//날짜값을 yyyy-mm-dd 형식으로 변환
Date.prototype.yyyymmdd = function(){
	var yyyy	= this.getFullYear().toString();
	var mm		= (this.getMonth() + 1).toString();
	var dd		= this.getDate().toString();
	
	return yyyy + "-" +  (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]);
}

//날짜값을 yyyy-mm-dd hh:mi 형식으로 변환
Date.prototype.yyyymmddhhmi = function(){
	var yyyy	= this.getFullYear().toString();
	var mm		= (this.getMonth() + 1).toString();
	var dd		= this.getDate().toString();
	var hh		= this.getHours().toString();
	var mi		= this.getMinutes().toString();
	
	return yyyy + "-" +  (mm[1] ? mm : "0" + mm[0]) + "-" + (dd[1] ? dd : "0" + dd[0]) + " " 
			+ (hh[1] ? hh : "0" + hh[0]) + ":" + (mi[1] ? mi : "0" + mi[0]);
}

//kendo datepicer focus 이동
function changeDatePickerFocus(id) {
    setTimeout(function() {
        var ev = $.Event("keydown");
        ev.keyCode = 39;
        $("#" + id).trigger(ev);
    }, 100)
};

