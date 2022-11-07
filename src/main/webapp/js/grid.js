/**
 * GRID 공통 함수 정의
 * searchData : 전송 파라미터
 * columns : grid list 항목
 * excelFile : excel file name
 * sendUrl : 데이터 요청 url
 */

function gridObj() {
	this.searchData	= {};
	this.columns	= [];
	this.excelFile	= "download.xlsx";
	this.sendUrl	= "";
	this.editable	= false;
	this.pageable	= true;
	this.pageSize	= 20;
	this.selectable = false;
	this.sortable	= false;
	this.aggregate = [];
	this.dataSource = [];
}

function gridData(id) {
	this.id				= id;
	this.gridOption 	= null;
	this.initGrid		= function () {
							this.gridOption = new gridObj();
						  };
	this.setSearchData 	= function (searchData) {
							this.gridOption.searchData = searchData;
							this.gridOption.dataSource = new kendo.data.DataSource({
								transport : {
									read : {
										url : this.gridOption.sendUrl,
										type : "post",
										dataType : "json",
										data : this.gridOption.searchData,
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
								},
								aggregate: this.gridOption.aggregate,
								serverPaging : this.gridOption.pageable,
								serverFiltering : true,
								error : function(e) {
									if(e.xhr.status == "400") {
										alert("세션값이 존재하지 않습니다. 로그인 페이지로 이동합니다.");
										location.href = "/";
									}
								}
							});
							
							//pageable 속성이 true일 경우에만 10개씩 보여준다. false이면 전체 데이터.
							if(this.gridOption.pageable) {
								//this.gridOption.dataSource.pageSize(10);
								this.gridOption.dataSource.pageSize(this.gridOption.pageSize);
							}
						  }
	this.setExcelFile	= function (excelFile) {
							this.gridOption.excelFile = excelFile;
						  }
	this.setSendUrl		= function (sendUrl) {
							this.gridOption.sendUrl = sendUrl;
	  					  }
	this.setEditable	= function (editable) {
							this.gridOption.editable = editable;
						  }
	this.setPageable	= function (pageable) {
							this.gridOption.pageable = pageable;							
	  					  }
	this.setPageSize	= function (pageSize) {
							this.gridOption.pageSize = pageSize;							
						  }
	this.setSelectable	= function (selectable) {
							this.gridOption.selectable = selectable;
		  				  }
	this.setSortable	= function (sortable) {
							this.gridOption.sortable = sortable;
						  }
	this.setAggregate	= function (aggregate){
							this.gridOption.aggregate = aggregate;
						  }
	this.setGrid		= function (columns) {
												this.gridOption.columns = columns;
												
												$("#" + this.id).kendoGrid({
													dataSource : this.gridOption.dataSource,
													excel: {
														fileName: this.gridOption.excelFile,
														proxyURL: "/cmm/saveGrid.do",
														filterable: false,
														allPages: true
													},
													excelExport: function(e) {
														if($("#loading").length > 0) $("#loading").hide();
													},
													navigatable: true,
										            selectable: this.gridOption.selectable,
													sortable : this.gridOption.sortable,
													pageable : this.gridOption.pageable,
										            resizable: true,
										            scrollable: true,
										            editable : this.gridOption.editable,
													columns : this.gridOption.columns,
										        	noRecords: true,
										    	  	messages: {
										    			noRecords: "조회된 데이터가 없습니다."
										    	  	}
												});
											  }
}
