webService = {
    version: '1.0'
    ,
    Web: {
        version: '1.0.0.0'
        ,
        ComnService: function () {
            this.fnBeforRun = function () {
                //$('#waiting').show();
            };

            this.fnAfterRun = function () {
                //$('#waiting').hide();
            };

            this.open = function (URL, width, height) {
                window.open(URL, '', 'width=' + width + ',height=' + height + ',status=yes,toolbar=no,menubar=no,location=no,scrollbars=no');
            };

            this.fnPageMove = function (URL) {
            	location.href=URL;
            };
            
            /// <summary>
            /// 테이블 ROW 데이터를 배열에 담는다
            /// <summary>
            /// <param name="tdodyObj">테이블의 TBODY Object</param>
            /// <param name="cbxYn">Row내 체크박스 선택여부(true/false)</param>
            this.GetTbRowData = function (tdodyObj, cbxYn) {
                var arrRow = new Array();
                var arrList = new Array();

                $(tdodyObj).find("tr").each(function () {
                    if ($("input:checkbox", this).is(":checked") == cbxYn) {
                        arrRow = new Array();
                        $(this).find("td").each(function (iCell) {
                            arrRow[iCell] = $(this).text();
                        });
                        arrList.push(arrRow);
                    }
                });
                return arrList;
            };

            /// <summary>
            /// 테이블 Row 내 존재하는 Object 값을 추출한다
            /// <summary>
            /// <param name="rowObj">테이블 Row 내 존재하는 Object</param>
            this.GetTbRowObjectData = function (rowObj) {

                var iCell = 0;
                var arrRow = new Array();

                $(rowObj).find('td').each(function () {
                    $(this).find('input:text').each(function () {
                        arrRow[iCell] = $(this).val();
                        iCell++;
                    });

                    $(this).find('select[name=select]').each(function () {
                        arrRow[iCell] = $(this).val();
                        iCell++;
                    });
                });

                return arrRow;
            };

            this.SetDatePickter = function () {
                $(".datePicker").datepicker({
                    dateFormat: 'yy-mm-dd',
                    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
                    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
                    weekHeader: 'Wk',
                    changeMonth: true, //월변경가능
                    changeYear: true, //년변경가능
                    yearRange: '1988:+10', // 연도 셀렉트 박스 범위(현재와 같으면 1988~현재년)
                    showMonthAfterYear: true, //년 뒤에 월 표시
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
            
            /*클라이언트 브라우져 버젼 알아오기*/
            this.GetUserBrowserVersion = function () {
                var clientAgent = navigator.userAgent;
                //var clientName = navigator.appName;
                var ver = 6;

                if (clientAgent.indexOf("MSIE 7.0") != -1) ver = 7;

                return ver;
            };

            /* 문자열 Byte 길이 추출 */
            this.GetByteLength = function (str) {
                var len = 0;
                if (str == null) return 0;

                for (var i = 0; i < str.length; i++) {
                    var c = escape(str.charAt(i));
                    if (c.length == 1) len++;
                    else if (c.indexOf("%u") != -1) len += 2;
                    else if (c.indexOf("%") != -1) len += c.length / 3;
                }
                return len;
            };

            // 숫자여부 판별
            this.IsNumeric = function (input) {
                var RE = /^-{0,1}\d*\.{0,1}\d+$/;
                return (RE.test(input));
            };
            
            this.IsPassword = function (input) {
            	var pattern = /[^(a-zA-Z0-9)]/;
            	if(!pattern.test( input )) 
            		return true;
            	else 
            		return false;
            };

            this.SetInitFCKeditor = function(objID, height) {
                var editor = new FCKeditor(objID);
                editor.BasePath = "/Scripts/fckeditor/";
                editor.ToolbarSet = "CustomToolbar";
                editor.Height = height;
                editor.ReplaceTextarea();
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