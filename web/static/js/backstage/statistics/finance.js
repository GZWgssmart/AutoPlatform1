var echart = echarts.init(document.getElementById("echart"));

/**
 * 初始化表格
 */
$(function () {
    initTable("table", "/incomingOutgoing/queryByPager"); // 初始化表格
});

//格式化不带时分秒的时间值。
function formatterDate(value) {
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

/**
 * 收支类型状态判断显示
 * @param value
 * @param row
 * @param index
 * @returns {*}
 */
function ioTypeFormatter(value, row, index) {
    if (row.outgoingType != null) {
        return "支出类型:" +row.outgoingType.outTypeName
    } else {
        return "收入类型:" +row.incomingType.inTypeName
    }
}


// 随窗口变化,echart大小也变化
function pageChangeEchartsResize() {
    var propertys = arguments;
    $(window).resize(function(){
        var len = propertys.length;
        for(var i = 0; i< len; i++) {
            var curEchart = propertys[i];
            curEchart.resize();
        }
    });
}

// 模态显示后 框中的 echart 大小变化
function detailEchartResize(detailsEchart){
    setTimeout(function(){
        detailsEchart.resize()},200);
}


// 后台传入数据转所需要的数组, 第一个为数据源, 后面两个为字段名
function arrayObjs2array(arrayObj){
    var arrs = [];
    var argument = arguments;
    arrayObj.forEach(function(value,index,array){
        var arr = [value[argument[1]], value[argument[2]] ];
        arrs.push(arr);
    })
    return arrs;
}

function arrayObjs2Objs(arrayObj){
    var arrs = [];
    var argument = arguments;
    arrayObj.forEach(function(value,index,array){
        var obj={name: value[argument[1]], value:  value[argument[2]]}
        arrs.push(obj);
    })
    return arrs;
}


// 后台传入数据转所需要的数据, 第一个为数据源, 后面一个为字段名,用于得到类目
function arrayObjs2arrayAttr(arrayObj){
    var arr=[];
    var argument = arguments;
    arrayObj.forEach(function(value,index,array){
        arr.push( value[argument[1]] );
    })
    return arr;
}

function initData(el) {
    $(el).text(moment(new Date).format('YYYY-MM-DD'));  // 初始页眉日期
}

function setDaterangeReturnFun(elid,daterangeReturnFun){
    $(elid).daterangepicker({
        locale:{
            format: 'YYYY-MM-DD',
            applyLabel: '确认',
            cancelLabel: '取消',
            fromLabel: '从',
            toLabel: '到',
            weekLabel: 'W',
            customRangeLabel: '自定义',
            daysOfWeek:["日","一","二","三","四","五","六"],
            monthNames: ["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
        },
        ranges: {
            '今日': [moment(), moment()],
            '昨日': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
            '最近一周': [moment().day(1), moment().day(7)],
            '最近一月': [moment().subtract(29, 'days'), moment()],
            '本季度': [moment().quarter(1), moment().quarter(1)],
            '本月': [moment().startOf('month'), moment().endOf('month')],
            '自定义':[]
        },
        showCustomRangeLabel: false,
        alwaysShowCalendars: false
    },function(start, end, label) {

        var tempdatetext = ''
        if(label === '今日' || label === '明日')
            tempdatetext = label + " " + start.format('YYYY-MM-DD');
        else
            tempdatetext = label + "(" + start.format('YYYY-MM-DD') + " ~ " +end.format('YYYY-MM-DD') + ")";
        $(elid+">span").text(tempdatetext);


        daterangeReturnFun(start, end, label);

        $.ajax({
            type:"GET",
            async : false,  //同步请求
            url : "/ioReport/queryByTime",
            data : {"start":start.format('YYYY-MM-DD'), "end":end.format('YYYY-MM-DD')},
            timeout:1000

        })
        alert("/ioReport/queryByTime?start="+start.format('YYYY-MM-DD')+"&end="+start.format('YYYY-MM-DD'))
        setNewEchartData("/ioReport/queryByTime?start="+start.format('YYYY-MM-DD')+"&end="+end.format('YYYY-MM-DD'),echart);
    });
}


function setTopData(top, data){
    top.reLoadData(data); // data is array
}

function setTableData(table, data){
    table.bootstrapTable("load",data);
}



$(function(){


    var echartOption = {
        legend: {
            data:['收入','支出','盈利']
        },
        xAxis: {
            name: '日期',
            type: 'category',
        },
        yAxis: {
            name: '金额',
            type: "value",
            axisLine: {
                show: false
            },
            axisTick: {
                show: false
            },
            axisLabel: {
                textStyle: {
                    color: '#999'
                }
            }
        },
        series: [{
            name: "收入",
            type: 'bar',
            itemStyle: {
                normal: {
                    color: "#33aaaa"
                }
            }
        },{
            name: "支出",
            type: 'bar',
            itemStyle: {
                normal: {
                    color: "#dd3333",
                }
            }
        },{
            name: "盈利",
            type: 'line'
        }],
        tooltip: {
            trigger: 'axis',
            formatter: "{a}<br />{b}: {c}<br />{b1}:{c1} 单"
        },

        toolbox: {
            feature : {
                restore : {show: true},
                saveAsImage : {show: true}
            }
        }
    }
    var tab =  $('#table').bootstrapTable();

    var top1 = $("#top1").cyItem({
        title: { text: '支出类型排行' },
        data: ['支出1','支出2','支出3']
    });
    var top2 = $("#top2").cyItem({
        title: { text: '收入类型排行' },
        data: ['收入1','收入2','收入3']
    });

    echart.setOption(echartOption);

    initData($("#reportrange>span"));
    setDaterangeReturnFun("#reportrange",daterangeReturnFun);

    setNewEchartData("/ioReport/queryByTime", echart);
    pageChangeEchartsResize(echart);
})


function queryParam(dat){
    $.extend(dat, {name:"Rin",age:14})
}
<!-- table end -->

function daterangeReturnFun(start, end, label){
    // 更新主图表        setNewEchartData
    // 更新右侧两个排行  setTopData
    //更新表格           setTableData
}

function setNewEchartData(url,echart){
    alert(url)
    $.get(url,function(data){
        console.log(data)
        var dataa= arrayObjs2arrayAttr(data,"inOutMoney");
       var dataStr =  tempInts2Strs(dataa);
       console.log(dataStr);
        var newEchartOption = {
            xAxis: {
                data: (function(){
                    var dates = [];
                    var date = new Date();
                    for(var i =0;i<7;i++) {
                        var datestr = [date.getFullYear(), date.getMonth(), date.getDate()].join("-");
                        dates.push(datestr);
                        date = addOneDay(date);
                    }
                    return dates;
                })()
            },
            series: [{

                data: dataStr.slice(0,7),
            },{

                data: dataStr.slice(0,7),
            },{

                data: dataStr.slice(0,7),
            }]
        }
        echart.setOption(newEchartOption);
    })
}

function tempInts2Strs(ints){
    var strs = [];
   for (var i = 0; i <= ints.length; i++ ){
       strs.push(ints[i]+"");
    }
    return strs;
}

function setTopData(top, data){
    top.reLoadData(data); // data is array
}

function setTableData(table, data){
    table.bootstrapTable("load",data);
}

function addOneDay(date){
    return new Date(+date+oneDay());
}
function oneDay(){
    return 24*3600*1000;
}



