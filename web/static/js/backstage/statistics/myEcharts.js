
// 基于准备好的dom，初始化echarts实例
var myChart = echarts.init(document.getElementById('main'));

// 指定图表的配置项和数据
var option = {
    tooltip: {
        trigger: 'axis', //坐标轴触发提示框，多用于柱状、折线图中
        /*
         控制提示框内容输出格式
         formatter: '{b0}<br/><font color=#FF3333>&nbsp;●&nbsp;</font>{a0} : {c0} ℃ ' +
         '<br/><font color=#53FF53>●&nbsp;</font>{a1} : {c1} % ' +
         '<br/><font color=#68CFE8>&nbsp;●&nbsp;</font>{a3} : {c3} mm ' +
         '<br/><font color=#FFDC35>&nbsp;●&nbsp;</font>{a4} : {c4} m/s ' +
         '<br/><font color=#B15BFF>&nbsp;&nbsp;&nbsp;&nbsp;●&nbsp;</font>{a2} : {c2} hPa '
         */
    },
    dataZoom: [
        {
            type: 'slider',	//支持鼠标滚轮缩放
            start: 0,			//默认数据初始缩放范围为10%到90%
            end: 100
        },
        {
            type: 'inside',	//支持单独的滑动条缩放
            start: 0,			//默认数据初始缩放范围为10%到90%
            end: 100
        }
    ],
    color:[
        '#FF3333',	//温度曲线颜色
    ],
    toolbox: {
        //显示策略，可选为：true（显示） | false（隐藏），默认值为false
        show: true,
        //启用功能，目前支持feature，工具箱自定义功能回调处理
        feature: {
            //辅助线标志
            mark: {show: true},
            //dataZoom，框选区域缩放，自动与存在的dataZoom控件同步，分别是启用，缩放后退
            //数据视图，打开数据视图，可设置更多属性,readOnly 默认数据视图为只读(即值为true)，可指定readOnly为false打开编辑功能
            dataView: {show: true, readOnly: true},
            //magicType，动态类型切换，支持直角系下的折线图、柱状图、堆积、平铺转换
            magicType: {show: true, type: ['line', 'bar']},
            //restore，还原，复位原始图表
            restore: {show: true},
            //saveAsImage，保存图片（IE8-不支持）,图片类型默认为'png'
            saveAsImage: {show: true}
        }
    },
    xAxis:  {	//X轴
        type : 'category',
        data : []	//先设置数据值为空，后面用Ajax获取动态数据填入
    },
    yAxis : [	//Y轴（这里我设置了两个Y轴，左右各一个）
        {
            //第一个（左边）Y轴，yAxisIndex为0
            type : 'value',
            name : '数量',
            /* max: 120,
             min: -40, */
            axisLabel : {
                formatter: '{value}'	//控制输出格式
            }
        },


    ],
    series : [	//系列（内容）列表
        {
            name:'数量',
            type:'line',	//折线图表示（生成温度曲线）
            symbol:'emptycircle',	//设置折线图中表示每个坐标点的符号；emptycircle：空心圆；emptyrect：空心矩形；circle：实心圆；emptydiamond：菱形
            data:[]		//数据值通过Ajax动态获取
        }
    ]
};

myChart.showLoading();	//数据加载完之前先显示一段简单的loading动画




$.ajax({	//使用JQuery内置的Ajax方法
    type : "post",		//post请求方式
    async : true,		//异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
    url : "/incomingOutgoing/queryByDay",	//请求发送到ShowInfoIndexServlet处
    data : {start:"", end:""},		//请求内包含一个key为name，value为A0001的参数；服务器接收到客户端请求时通过request.getParameter方法获取该参数值
    dataType : "json",		//返回数据形式为json
    success : function(result) {
        //请求成功时执行该函数内容，result即为服务器返回的json对象


        if (result != null && result.length > 0) {
            for(var i=0;i<result.length;i++){
                console.log(result[i].outTypeId + "aaaaa")

                if (result[i].outTypeId == null) {
                    inOutMoney.push(result[i].inOutMoney);
                } else {
                    inOutMoney.push(0);
                }
                //挨个取出温度、湿度、压强等值并填入前面声明的温度、湿度、压强等数组
                console.log(result[i].inOutCreatedTime)

                dates.push(formatterDay(result[i].inOutCreatedTime));
            }
            myChart.hideLoading();	//隐藏加载动画


            myChart.setOption({		//载入数据
                xAxis: {
                    data: dates	//填入X轴数据
                },
                series: [	//填入系列（内容）数据
                    {
                        // 根据名字对应到相应的系列
                        name: '收支金额',
                        data: inOutMoney
                    },
                ]
            });

        }
        else {
            //返回的数据为空时显示提示信息
            alert("图表请求数据为空,没有当前时间段的数据,请选择一个时间段的数据，可以根据年月日季度周查询");
            myChart.hideLoading();
        }

    },
    error : function(errorMsg) {
        //请求失败时执行该函数
        alert("图表请求数据失败，可能是服务器开小差了");
        myChart.hideLoading();
    }
})

myChart.setOption(option, true);	//载入图表

//年的格式化
function formatterYear(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year
    }


}

//年月的格式化
function formatterMonth(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year + "-" + month
    }
}

//年月日的格式化
function formatterDay(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year + "-" + month + "-" + day + ""
    }
}

//季度的格式化
function formatterQuarter(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        if  (month === "01"|| month === "02" || month === "03") {
            month = "1月－3月 ";
        } else  if  (month === "04"|| month === "05" || month === "06") {
            month = "4月－6月  ";
        } else  if  (month === "07"|| month === "08" || month === "09") {
            month = "7月－9月  ";
        } else  if  (month === 10|| month === 11 || month === 12) {
            month = "10月－12月  ";
        }

        alert(year + month + "aa")

        return year + "-" + month
    }


}

//周期的格式化
function formatterWeek(value) {
    if (value == undefined || value == null || value == '') {
        return "";
    } else {
        var date = new Date(value);
        var year = date.getFullYear().toString();
        var month = (date.getMonth() + 1);
        var day = date.getDate().toString();
        if (month < 10) {
            month = "0" + month;
        }
        if (day < 10) {
            day = "0" + day;
        }
        return year +  "第" + getYearWeek(year, month, day) + "周";
    }
}

/**
 * 判断年份是否为润年
 *
 * @param {Number} year
 */
function isLeapYear(year) {
    return (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0);
}
/**
 * 获取某一年份的某一月份的天数
 *
 * @param {Number} year
 * @param {Number} month
 */
function getMonthDays(year, month) {
    return [31, null, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31][month] || (isLeapYear(year) ? 29 : 28);
}26 /**
 * 获取某年的某天是第几周
 * @param {Number} y
 * @param {Number} m
 * @param {Number} d
 * @returns {Number}
 */
function getWeekNumber(y, m, d) {
    var now = new Date(y, m - 1, d),
        year = now.getFullYear(),
        month = now.getMonth(),
        days = now.getDate();
    //那一天是那一年中的第多少天
    for (var i = 0; i < month; i++) {
        days += getMonthDays(year, i);
    }

    //那一年第一天是星期几
    var yearFirstDay = new Date(year, 0, 1).getDay() || 7;

    var week = null;
    if (yearFirstDay == 1) {
        week = Math.ceil(days / yearFirstDay);
    } else {
        days -= (7 - yearFirstDay + 1);
        week = Math.ceil(days / 7) + 1;
    }
    return week;
}


var getYearWeek = function (a, b, c) {
    var d1 = new Date(a, b-1, c), d2 = new Date(a, 0, 1),
        d = Math.round((d1 - d2) / 86400000);
    return Math.ceil((d + ((d2.getDay() + 1) - 1)) / 7);
};
