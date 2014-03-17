webService = {
    version: '1.0'
    ,
    Web: {
        version: '1.0.0.0'
        ,
        ComnService: function () {
            this.fnPageMove = function (URL) {
            	location.href=URL;
            };
            
            this.fnOpenLoginPanel = function() {
            	$("#lnklogin").trigger("click");
            };
            
            this.fnMarkingLeftMenu = function(obj) {
            	$(obj).css("background-color", "#38c");
            };

            this.SetDatePickter = function (id) {
                $(".datePicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                    weekHeader: 'Wk',
                    changeMonth: true, //월변경가능
                    changeYear: true, //년변경가능
                    yearRange: '1988:+10', // 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
                    showMonthAfterYear: true, //년 뒤에 월 표시
                    onSelect: function(dateValue, inst) {
                    	var date = new Date();
                    	
                    	var arrDate = dateValue.split('-');
                    	var selDate = new Date(arrDate[0],arrDate[1],arrDate[2]).valueOf();
                    	var today = new Date(date.getFullYear(), date.getMonth()+1, date.getDate()).valueOf();
                    	
                    	if(selDate < today) {
                    		alert('오늘 이후의 날짜를 선택하세요');
                    		$(".datePicker").val('');
                    	}
                    }
//                    buttonImageOnly: true, //이미지표시  
//                    buttonText: '',
//                    autoSize: false, //오토리사이즈(body등 상위태그의 설정에 따른다)
//                    buttonImage: '/resources/img/button/icon_calendar.gif',
//                    showOn: "both" //엘리먼트와 이미지 동시 사용         
                });
            };

            this.ConvertDate = function (date, delim) {
                var year = date.getFullYear();
                var month = (date.getMonth() + 1) > 9 ? '' + (date.getMonth() + 1) : '0' + (date.getMonth() + 1);
                var day = date.getDate() > 9 ? '' + date.getDate() : '0' + date.getDate();
                today = year + delim + month + delim + day;

                return today;
            };
            
            // 숫자여부 판별
            this.IsNumeric = function (input) {
                var RE = /^-{0,1}\d*\.{0,1}\d+$/;
                return (RE.test(input));
            };            
        }
        ,
        AsyncService: function (before, after) {
            var beforeProcess = before;
            var afterProcess = after;

            this.get = function (url, params, success, error) {
                this.ajax("GET", url, params, success, error);
            };

            this.post = function (url, params, success, error) {
                this.ajax("POST", url, params, success, error);
            };

            this.put = function (url, params, success, error) {
                this.ajax("PUT", url, params, success, error);
            };

            this.del = function (url, params, success, error) {
                this.ajax("DELETE", url, params, success, error);
            };

            this.ajax = function (method, url, params, success, error) {

                if (beforeProcess) beforeProcess();

                if ($) {                	
                    if ($.ajax) {                    	
                        $.ajax({
                            type: method,
                            url: url,
                            contentType: "application/json",
                            data: params,
                            dataType: "json",
                            cache: false,
                            contentType: "application/json; charset=utf-8",
                            success: function (data, status, request) {                            	
                                success(data);

                                if (afterProcess)
                                    afterProcess();
                            },
                            error: function (request, status, errorThrown) {
                            	                            	
                                if (request.status == 400) {
                                    alert('404 Bad Request');
                                } else if (request.status == 403) {
                                    alert('403 Forbidden Error');
                                } else if (request.status == 404) {
                                    alert('404 Page Not Found');
                                } else if (request.status == 500) {
                                    var errorHandled = false;

                                    var exception = JSON.parse(request.responseText);
                                    if (error) errorHandled = error(exception);
                                    if (errorHandled != true) alert(request.responseText);
                                }
                                else {
                                    //alert(request.responseText);
                                	alert('오류가 반환되었습니다');
                                }

                                if (afterProcess) afterProcess();
                            }                                                       
                        });
                        
                        return;
                    }
                }
            };
        }
    }
};