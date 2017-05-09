
$('.form_Year').datetimepicker({
    format: 'yyyy',
    weekStart: 1,
    autoclose: true,
    startView: 4,
    minView: 4,
    forceParse: false,
    language: 'zh-CN'
}),

    $('.form_Month').datetimepicker({
        language: 'zh-CN',
        format: 'yyyy-mm',
        autoclose: true,
        todayBtn: true,
        startView: 'year',
        minView: 'year',
        maxView: 'decade'
    }),

    $('.form_Day').datetimepicker({
        minView: "month", //选择日期后，不会再跳转去选择时分秒
        format: "yyyy-mm-dd", //选择日期后，文本框显示的日期格式
        language: 'zh-CN', //汉化
        autoclose: true //选择日期后自动关闭
    })

var inMoney=[];		//湿度数组
var outMoney=[];		//湿度数组
var Datas=[];		//时间数组

function selectYears() {
    var start = $("#startYearInput").val() + "-01-01";
    var end = $("#endYearInput").val() + "-12-31";
    $.ajax({	//使用JQuery内置的Ajax方法
        type: "post",		//post请求方式
        async: true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "/incomingOutgoing/queryByCondition",	//请求发送到ShowInfoIndexServlet处
        data: {"start": start, "end": end, "type":"year"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
        dataType: "json",		//返回数据形式为json
        success: function (result) {
            //请求成功时执行该函数内容，result即为服务器返回的json对象
            if (result !== null && result.length > 0) {
                for (var i = 0; i < result.length; i++) {

                    inMoney.push(result[i].inMoney);
                    outMoney.push(result[i].outMoney);

                    alert(result[i].inMoney)
                    alert(result[i].outMoney)
                    Datas.push(result[i].date);

                }

                myChart.hideLoading();	//隐藏加载动画

                myChart.setOption({		//载入数据
                    xAxis: {
                        data: Datas,	//填入X轴数据
                    },
                    series: [	//填入系列（内容）数据
                        {
                            // 根据名字对应到相应的系列
                            name: '收入',
                            data: inMoney
                        },
                        {
                            // 根据名字对应到相应的系列
                            name: '支出',
                            data: outMoney
                        }

                    ]
                });


            }
            else {
                //返回的数据为空时显示提示信息
                alert("图表请求数据为空,没有当前时间段的数据");
                myChart.hideLoading();
            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败，可能是服务器开小差了");
            myChart.hideLoading();
        }
    })


}


function selectMonth() {
    var start = $("#startMonthInput").val() + "-01";
    var end = $("#endMonthInput").val() + "-31";
    $.ajax({	//使用JQuery内置的Ajax方法
        type: "post",		//post请求方式
        async: true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "/incomingOutgoing/queryByCondition",	//请求发送到ShowInfoIndexServlet处
        data: {"start": start, "end": end, "type":"month"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
        dataType: "json",		//返回数据形式为json
        success: function (result) {
            //请求成功时执行该函数内容，result即为服务器返回的json对象


            if (result !== null && result.length > 0) {
                for (var i = 0; i < result.length; i++) {

                    inMoney.push(result[i].inMoney);
                    outMoney.push(result[i].outMoney);
                    alert(result[i].inMoney)
                    alert(result[i].outMoney)
                    Datas.push(result[i].date);

                }

                myChart.hideLoading();	//隐藏加载动画

                myChart.setOption({		//载入数据
                    xAxis: {
                        data: Datas,	//填入X轴数据
                    },
                    series: [	//填入系列（内容）数据
                        {
                            // 根据名字对应到相应的系列
                            name: '收入',
                            data: inMoney
                        },
                        {
                            // 根据名字对应到相应的系列
                            name: '支出',
                            data: outMoney
                        }

                    ]
                });


            }
            else {
                //返回的数据为空时显示提示信息
                alert("图表请求数据为空,没有当前时间段的数据");
                myChart.hideLoading();
            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败，可能是服务器开小差了");
            myChart.hideLoading();
        }
    })

}

function selectDay() {
    var start = $("#startDayInput").val();
    var end = $("#endDayInput").val();
    $.ajax({	//使用JQuery内置的Ajax方法
        type: "post",		//post请求方式
        async: true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "/incomingOutgoing/queryByCondition",	//请求发送到ShowInfoIndexServlet处
        data: {"start": start, "end": end, "type":"day"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
        dataType: "json",		//返回数据形式为json
        success: function (result) {
            //请求成功时执行该函数内容，result即为服务器返回的json对象


            if (result !== null && result.length > 0) {
                for (var i = 0; i < result.length; i++) {

                    inMoney.push(result[i].inMoney);
                    outMoney.push(result[i].outMoney);
                    alert(result[i].inMoney)
                    alert(result[i].outMoney)
                    Datas.push(result[i].date);

                }

                myChart.hideLoading();	//隐藏加载动画

                myChart.setOption({		//载入数据
                    xAxis: {
                        data: Datas,	//填入X轴数据
                    },
                    series: [	//填入系列（内容）数据
                        {
                            // 根据名字对应到相应的系列
                            name: '收入',
                            data: inMoney
                        },
                        {
                            // 根据名字对应到相应的系列
                            name: '支出',
                            data: outMoney
                        }

                    ]
                });


            }
            else {
                //返回的数据为空时显示提示信息
                alert("图表请求数据为空,没有当前时间段的数据");
                myChart.hideLoading();
            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败，可能是服务器开小差了");
            myChart.hideLoading();
        }
    })

}

function selectQuarter() {
    var start = $("#startQuarterInput").val();
    var end = $("#endQuarterInput").val();
    $.ajax({	//使用JQuery内置的Ajax方法
        type: "post",		//post请求方式
        async: true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "/incomingOutgoing/queryByCondition",	//请求发送到ShowInfoIndexServlet处
        data: {"start": start, "end": end, "type":"quarter"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
        dataType: "json",		//返回数据形式为json
        success: function (result) {
            //请求成功时执行该函数内容，result即为服务器返回的json对象


            if (result !== null && result.length > 0) {
                for (var i = 0; i < result.length; i++) {

                    inMoney.push(result[i].inMoney);
                    outMoney.push(result[i].outMoney);
                    alert(result[i].inMoney)
                    alert(result[i].outMoney)
                    Datas.push(formatterQuarter(result[i].dateTime));

                }

                myChart.hideLoading();	//隐藏加载动画

                myChart.setOption({		//载入数据
                    xAxis: {
                        data: Datas,	//填入X轴数据
                    },
                    series: [	//填入系列（内容）数据
                        {
                            // 根据名字对应到相应的系列
                            name: '收入',
                            data: inMoney
                        },
                        {
                            // 根据名字对应到相应的系列
                            name: '支出',
                            data: outMoney
                        }

                    ]
                });


            }
            else {
                //返回的数据为空时显示提示信息
                alert("图表请求数据为空,没有当前时间段的数据");
                myChart.hideLoading();
            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败，可能是服务器开小差了");
            myChart.hideLoading();
        }
    })

}


function selectWeek() {
    var start = $("#startWeekInput").val();
    var end = $("#endWeekInput").val();
    $.ajax({	//使用JQuery内置的Ajax方法
        type: "post",		//post请求方式
        async: true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "/incomingOutgoing/queryByCondition",	//请求发送到ShowInfoIndexServlet处
        data: {"start": start, "end": end, "type":"week"},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
        dataType: "json",		//返回数据形式为json
        success: function (result) {
            //请求成功时执行该函数内容，result即为服务器返回的json对象


            if (result !== null && result.length > 0) {
                for (var i = 0; i < result.length; i++) {

                    inMoney.push(result[i].inMoney);
                    outMoney.push(result[i].outMoney);
                    alert(result[i].inMoney)
                    alert(result[i].outMoney)
                    Datas.push(formatterWeek(result[i].dateTime));

                }

                myChart.hideLoading();	//隐藏加载动画

                myChart.setOption({		//载入数据
                    xAxis: {
                        data: Datas,	//填入X轴数据
                    },
                    series: [	//填入系列（内容）数据
                        {
                            // 根据名字对应到相应的系列
                            name: '收入',
                            data: inMoney
                        },
                        {
                            // 根据名字对应到相应的系列
                            name: '支出',
                            data: outMoney
                        }

                    ]
                });


            }
            else {
                //返回的数据为空时显示提示信息
                alert("图表请求数据为空,没有当前时间段的数据");
                myChart.hideLoading();
            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败，可能是服务器开小差了");
            myChart.hideLoading();
        }
    })

}