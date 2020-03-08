var common = {}
//微信配置
var wxConfig;
// 新冠病毒数据
var ncpInfo;

var timerRunning = false;

function init() {
    var myChart = echarts.init(document.getElementById("now_time_echarts"))
    //  使用要点：
//  1、大表盘是由时、分、秒三个series[]数据项重叠构成
//  2、24小时、星期、月三个小表盘，以及日期，各自使用了一个series[]数据项
//  3、animation应设为0，避免指针归零是有“掉下来的感觉”
// 问题？？？？
// 1. 星期，我想做到汉字效果但是文字不随着圆的弧度而动？？？求大神解决
//模拟解决：
// 有人回复使用pie图模拟星期的时间转盘，如图所示
    var option = {
        tooltip: {
            // formatter: "{a}：{c}"
            backgroundColor: '#fff',
            borderColor: '#f60',
            borderWidth: '1px',
            textStyle: {
                color: '#333'
            },
            formatter: function(param) {
                var time = Math.floor(param.value);
                if (param.seriesIndex === 0) {
                    return '<em style="color:' + param.color + ';">当前小时:' + time + '</em>'
                }
                if (param.seriesIndex === 1) {
                    return '<em style="color:' + param.color + ';">当前星期:' + time + '</em>'
                }
                if (param.seriesIndex === 2) {
                    return '<em style="color:' + param.color + ';">当前月份:' + time + '</em>'
                }
                if (param.seriesIndex === 4) {
                    return '<em style="color:' + param.color + ';">当前小时:' + time + '</em>'
                }
                if (param.seriesIndex === 5) {
                    return '<em style="color:' + param.color + ';">当前分钟:' + time + '</em>'
                }
                if (param.seriesIndex === 6) {
                    return '<em style="color:' + param.color + ';">当前秒:' + time + '</em>'
                }
            }
        },
        backgroundColor: "rgba(0,0,0,0.1)",
        series: [{ //小表盘24小时
            name: '小时',
            type: 'gauge',
            center: ['28%', '50%'], // 默认全局居中
            radius: '22%', //仪表盘半径
            min: 0,
            max: 24,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 24,
            animation: 0,
            pointer: { //仪表盘指针
                show: 1,
                length: '90%',
                width: 3
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#00b0b0',
                    shadowColor: 'rgba(0, 0, 0, 0.5)',
                    shadowBlur: 10,
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            },
            axisLine: { //仪表盘轴线样式
                lineStyle: {
                    color: [
                        [1, '#337ab7']
                    ],
                    width: 6
                }
            },
            splitLine: { //分割线样式
                length: 6,
                lineStyle: {
                    width: 1
                }
            },
            axisTick: { //仪表盘刻度样式
                show: 0,
                splitNumber: 5, //分隔线之间分割的刻度数
                length: 5, //刻度线长
                lineStyle: {
                    color: ['#ffffff']
                }
            },
            axisLabel: { //刻度标签
                show: 1,
                distance: 2, //标签与刻度线的距离
                textStyle: {
                    color: '#0000ff'
                },
                formatter: function(t) {
                    switch (t + '') {
                        case '0':
                            return '';
                        case '1':
                            return '';
                        case '2':
                            return '';
                        case '3':
                            return '3';
                        case '4':
                            return '';
                        case '5':
                            return '';
                        case '6':
                            return '6';
                        case '7':
                            return '';
                        case '8':
                            return '';
                        case '9':
                            return '9';
                        case '10':
                            return '';
                        case '11':
                            return '';
                        case '12':
                            return '12';
                        case '13':
                            return '';
                        case '14':
                            return '';
                        case '15':
                            return '15';
                        case '16':
                            return '';
                        case '17':
                            return '';
                        case '18':
                            return '18';
                        case '19':
                            return '';
                        case '20':
                            return '';
                        case '21':
                            return '21';
                        case '22':
                            return '';
                        case '23':
                            return '';
                        case '24':
                            return '24';
                    }
                }
            },
            title: { //仪表盘标题
                show: 1,
                offsetCenter: ['250%', '-250%'],
                textStyle: {
                    color: '#333',
                    fontSize: 24,
                    fontWeight: 'bold'
                }
            },
            detail: { //仪表盘显示数据
                show: 0,
                formatter: '{value}',
                offsetCenter: [0, '60%']
            },
            data: [{
                name: '当前时间:\n'
            }]
        }, { ///////////////////////////////////////////////小表盘星期
            name: '星期',
            type: 'gauge',
            center: ['72%', '50%'], // 默认全局居中
            radius: '22%', //仪表盘半径
            min: 0,
            max: 7,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 7,
            animation: 0,
            pointer: { //仪表盘指针
                show: true,
                length: '80%',
                width: 3
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#00b0b0',
                    shadowColor: 'rgba(0, 0, 0, 0.5)',
                    shadowBlur: 10,
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            },
            axisLine: { //仪表盘轴线样式
                lineStyle: {
                    color: [
                        [0.07, 'rgba(192, 0, 0, 0.5)'],
                        [0.21, 'rgba(0, 0, 192, 0.5)'],
                        [0.35, 'rgba(0, 64, 192, 0.5)'],
                        [0.50, 'rgba(0, 96, 192, 0.5)'],
                        [0.64, 'rgba(0, 164, 192, 0.5)'],
                        [0.78, 'rgba(0, 128, 64, 0.5)'],
                        [0.93, 'rgba(192, 128, 0, 0.5)'],
                        [1, 'rgba(192, 0, 0, 0.5)']
                    ],
                    width: 0
                }
            },
            splitLine: { //分割线样式
                show: 0,
                length: 18,
                lineStyle: {
                    width: 1
                }
            },
            axisTick: {
                show: 0
            }, //仪表盘刻度样式
            axisLabel: { //刻度标签
                show: 1,
                distance: -15, //标签与刻度线的距离
                textStyle: {
                    color: '#ffffff'
                },
                formatter: function(t) {
                    return "";
                }
            },
            title: {
                show: 0
            }, //仪表盘标题
            detail: {
                show: 0
            }, //仪表盘显示数据
            data: [{}]
        }, { ///////////////////////////////////////////////小表盘月
            name: '月份',
            type: 'gauge',
            center: ['50%', '72%'], // 默认全局居中
            radius: '22%', //仪表盘半径
            min: 0,
            max: 12,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 12,
            animation: 0,
            pointer: { //仪表盘指针
                show: 1,
                length: '90%',
                width: 3
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#00b0b0',
                    shadowColor: 'rgba(0, 0, 0, 0.5)',
                    shadowBlur: 10,
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            },
            axisLine: { //仪表盘轴线样式
                lineStyle: {
                    color: [
                        [1, '#337ab7']
                    ],
                    width: 6
                }
            },
            splitLine: { //分割线样式
                show: 1,
                length: 6,
                lineStyle: {
                    width: 1
                }
            },
            axisTick: {
                show: 0
            }, //仪表盘刻度样式
            axisLabel: { //刻度标签
                show: 1,
                distance: 1, //标签与刻度线的距离
                textStyle: {
                    color: '#0000ff',
                    fontFamily: '宋体'
                },
                formatter: function(t) {
                    switch (t + '') {
                        case '2':
                            return '2';
                        case '4':
                            return '4';
                        case '6':
                            return '6';
                        case '8':
                            return '8';
                        case '10':
                            return '10';
                        case '12':
                            return '12';
                    }
                }
            },
            detail: {
                show: 0
            }, //仪表盘显示数据
            data: [{}]
        }, { ///////////////////////////////////////////////小表盘日
            type: 'gauge',
            center: ['50%', '72%'], // 默认全局居中
            radius: '22%', //仪表盘半径
            animation: 0,
            pointer: {
                width: 0
            }, //仪表盘指针
            axisLine: { //仪表盘轴线样式
                lineStyle: {
                    show: 0,
                    width: 0
                }
            },
            splitLine: {
                show: 0
            }, //分割线样式
            axisTick: {
                show: 0
            }, //仪表盘刻度样式
            axisLabel: {
                show: 0
            }, //刻度标签
            detail: { //仪表盘显示数据
                show: 1,
                formatter: function(e) {
                    if (e < 10)
                        e = '0' + e;
                    return e;
                },
                offsetCenter: ['160%', 0],
                borderWidth: 2,
                borderColor: '#337ab7',
                backgroundColor: '#fff',
                height: 20,
                width: 28,
                textStyle: {
                    color: '#f60',
                    fontSize: 16,
                    fontWeight: 'bold'
                },
            },
            data: [{}]
        }, { ///////////////////////////////////////////////大表盘时针
            name: '小时',
            type: 'gauge',
            radius: '90%', //仪表盘半径
            min: 0,
            max: 12,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 12,
            animation: 0,
            pointer: { //仪表盘指针
                length: '70%',
                width: 6
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#109A39',
                    shadowColor: 'rgba(0, 0, 0, 0.5)',
                    shadowBlur: 10,
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            },
            axisLine: { //仪表盘轴线样式
                show: 0,
                lineStyle: {
                    color: [
                        [1, '#337ab7']
                    ],
                    width: 10,
                    shadowColor: 'rgba(0, 0, 0, 0.8)',
                    shadowBlur: 12,
                    shadowOffsetX: 3,
                    shadowOffsetY: 3
                }
            },
            splitLine: { //分割线样式
                length: 10,
                lineStyle: {
                    width: 2
                }
            },
            axisTick: { //仪表盘刻度样式
                show: true,
                splitNumber: 5, //分隔线之间分割的刻度数
                length: 5, //刻度线长
                lineStyle: {
                    color: ['#ffffff']
                }
            },
            axisLabel: {
                show: 0
            }, //刻度标签
            title: {
                show: 0
            }, //仪表盘标题
            detail: {
                show: 0
            }, //仪表盘显示数据
            data: [{}]
        }, { ///////////////////////////////////////////////大表盘分针
            name: '分钟',
            type: 'gauge',
            radius: '90%', //仪表盘半径
            min: 0,
            max: 60,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 12,
            animation: 0,
            pointer: { //仪表盘指针
                length: '85%',
                width: 6
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#ca8622',
                    shadowColor: 'rgba(0, 0, 0, 0.5)',
                    shadowBlur: 10,
                    shadowOffsetX: 2,
                    shadowOffsetY: 2
                }
            },
            axisLine: { //仪表盘轴线样式
                show: 0,
                lineStyle: {
                    width: 0
                }
            },
            splitLine: { //分割线样式
                length: 10,
                lineStyle: {
                    width: 2
                }
            },
            axisTick: { //仪表盘刻度样式
                show: true,
                splitNumber: 5, //分隔线之间分割的刻度数
                length: 5, //刻度线长
                lineStyle: {
                    color: ['#ffffff']
                }
            },
            axisLabel: {
                show: 0
            }, //刻度标签
            title: {
                show: 0
            }, //仪表盘标题
            detail: {
                show: 0
            }, //仪表盘显示数据
            data: [{}]
        }, { ///////////////////////////////////////////////大表盘秒针
            name: '秒',
            type: 'gauge',
            radius: '90%', //仪表盘半径
            min: 0,
            max: 60,
            startAngle: 90,
            endAngle: -269.9999,
            splitNumber: 12,
            animation: 0,
            pointer: { //仪表盘指针
                show: true,
                length: '95%',
                width: 4
            },
            itemStyle: { //仪表盘指针样式
                normal: {
                    color: '#00b0b0',
                    shadowColor: 'rgba(0, 0, 0, 0.8)',
                    shadowBlur: 10,
                    shadowOffsetX: 4,
                    shadowOffsetY: 4
                }
            },
            axisLine: { //仪表盘轴线样式
                lineStyle: {
                    color: [
                        [1, '#337ab7']
                    ],
                    width: 10
                }
            },
            splitLine: { //分割线样式
                length: 10,
                lineStyle: {
                    width: 2
                }
            },
            axisTick: { //仪表盘刻度样式
                show: 1,
                splitNumber: 5, //分隔线之间分割的刻度数
                length: 5, //刻度线长
                lineStyle: {
                    color: ['#fff']
                }
            },
            axisLabel: { //刻度标签
                show: 1,
                distance: 6, //标签与刻度线的距离
                textStyle: {
                    fontWeight: 'bold',
                    fontSize: 16
                },
                formatter: function(t) {
                    switch (t + '') {
                        case '0':
                            return '';
                        case '5':
                            return '1';
                        case '10':
                            return '2';
                        case '15':
                            return '3';
                        case '20':
                            return '4';
                        case '25':
                            return '5';
                        case '30':
                            return '6';
                        case '35':
                            return '7';
                        case '40':
                            return '8';
                        case '45':
                            return '9';
                        case '50':
                            return '10';
                        case '55':
                            return '11';
                        case '60':
                            return '12';
                    }
                }
            },
            title: {
                show: 0
            }, //仪表盘标题
            detail: { //仪表盘显示数据
                show: 0,
                formatter: '{value}',
                offsetCenter: [0, '60%']
            },
            data: [{}]
        }, {
            name: '星期',
            type: 'pie',
            hoverAnimation: false,
            animation: false,
            center: ['72%', '50%'],
            radius: ['15%', '22.5%'],
            startAngle: 64.28,
            label: {
                normal: {
                    show: false,
                    position: 'inside'
                }
            },
            labelLine: {
                normal: {
                    show: false
                }
            },
            markPoint: {
                symbolSize: 1,
                label: {
                    normal: {
                        show: true,
                        formatter: function(t) {
                            return t.name
                        }
                    }
                },
                data: [{
                    name: '星期日',
                    x: '72%',
                    y: '41%'
                },
                    {
                        name: '星期一',
                        x: '77.5%',
                        y: '44.5%',
                        label: {
                            normal: {
                                rotate: -51.42
                            }
                        }
                    },
                    {
                        name: '星期二',
                        x: '78.7%',
                        y: '52%',
                        label: {
                            normal: {
                                rotate: -102.84
                            }
                        }
                    },
                    {
                        name: '星期三',
                        x: '75%',
                        y: '58.5%',
                        label: {
                            normal: {
                                rotate: -154.28
                            }
                        }
                    },
                    {
                        name: '星期四',
                        x: '69%',
                        y: '58.5%',
                        label: {
                            normal: {
                                rotate: -205.7
                            }
                        }
                    },
                    {
                        name: '星期五',
                        x: '65.5%',
                        y: '52%',
                        label: {
                            normal: {
                                rotate: -257.12
                            }
                        }
                    },
                    {
                        name: '星期六',
                        x: '66.8%',
                        y: '44.2%',
                        label: {
                            normal: {
                                rotate: 51.46
                            }
                        }
                    }
                ]
            },
            data: [{
                name: '星期日',
                value: 1
            },
                {
                    name: '星期一',
                    value: 1
                },
                {
                    name: '星期二',
                    value: 1
                },
                {
                    name: '星期三',
                    value: 1
                },
                {
                    name: '星期四',
                    value: 1
                },
                {
                    name: '星期五',
                    value: 1
                },
                {
                    name: '星期六',
                    value: 1
                },
            ],
            z: 1
        }]
    };
    // https://gallery.echartsjs.com/editor.html?c=xBJd0b_nNf
    clearInterval(timeTicket);
    nowDateGallery(myChart, option);
    var timeTicket = setInterval(function() {
        nowDateGallery(myChart, option);
    }, 100);
}

function nowDateGallery(myChart, option){
    var datetime = new Date();
    var year = datetime.getFullYear();
    var month = datetime.getMonth() + 1;
    var date = datetime.getDate();
    var h = datetime.getHours();
    var m = datetime.getMinutes();
    var s = datetime.getSeconds();
    var week = datetime.getDay();
    var ms = datetime.getMilliseconds();
    var minutes = m + s / 60;
    var hours_24 = h + m / 60;
    var hours_12;
    if (hours_24 > 12) {
        hours_12 = hours_24 - 12;
    } else {
        hours_12 = hours_24;
    }
    var seconds = s + ms / 1000;
    var cur_mon = new Date(year, month, 0);
    var cur_mon_count = cur_mon.getDate(); //当前月份总天数
    var month = month + date / cur_mon_count;
    if (month > 12) {
        month = month - 12;
    }
    var strmonth = datetime.getMonth() + 1;
    var str = year + "-" + checktime(strmonth) + "-" + checktime(date) + " " + checktime(h) + ":" + checktime(m) + ":" + checktime(s);
    option.series[0].data[0].name = '当前时间:\n' + str;
    option.series[0].data[0].value = (hours_24).toFixed(2);
    option.series[1].data[0].value = (week).toFixed(0);
    option.series[2].data[0].value = (month).toFixed(2);
    option.series[3].data[0].value = (date).toFixed(0);
    option.series[4].data[0].value = (hours_12).toFixed(2);
    option.series[5].data[0].value = (minutes).toFixed(2);
    option.series[6].data[0].value = (seconds).toFixed(2);
    myChart.setOption(option, true);
}

function checktime(str) {
    if (str < 10) {
        return '0' + str;
    }
    return str;
}
/**
 * 初始化时间
 * @param id
 */
function initNowDate() {
    clearInterval(nowTimeInterval);
    nowTimeRender();
    var nowTimeInterval = setInterval(function (){
        nowTimeRender();
    },1000)
}
function nowTimeRender() {
    var now = new Date();
    $("#now_time_span").text(dateFtt("yyyy年MM月dd日 hh:mm:ss", now));
}

/**
 * 微信-初始化
 */
function initWx() {
    common.ajaxPostJson(domain + "/common/wxConfig",null,function (data) {
        wxConfig = data.data;
        wxFun(data.data)
    },function (data) {
        console.log(data);
    })
}

/**
 * 微信jssdk-初始化
 */
function wxFun(data) {
    var jsApiList = ['onMenuShareAppMessage'];
    wx.ready(function () {   //需在用户可能点击分享按钮前就先调用
        wx.config({
            debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
            appId: data.appid, // 必填，公众号的唯一标识
            timestamp: data.timestamp, // 必填，生成签名的时间戳
            nonceStr: data.nonceStr, // 必填，生成签名的随机串
            signature: data.signature,// 必填，签名
            jsApiList: jsApiList // 必填，需要使用的JS接口列表
        });

        // 分享给朋友
        wx.onMenuShareAppMessage({
            title: '黄猿帅', // 分享标题
            desc: '[[${sys.domain}]]/', // 分享描述
            link: '[[${sys.domain}]]/[[${#httpServletRequest.getContextPath()}]]/index', // 分享链接，该链接域名或路径必须与当前页面对应的公众号JS安全域名一致
            imgUrl: '', // 分享图标
            type: '', // 分享类型,music、video或link，不填默认为link
            dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
            success: function () {
                // 用户点击了分享后执行的回调函数
            }
        });
    });
   /* wx.checkJsApi({
        jsApiList: jsApiList, // 需要检测的JS接口列表，所有JS接口列表见附录2,
        success: function(res) {
            // 以键值对的形式返回，可用的api值true，不可用为false
            // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
        }
    });*/
  /*  wx.getNetworkType({
        success: function (res) {
            var networkType = res.networkType; // 返回网络类型2g，3g，4g，wifi
            console.log(res);
        }
    });*/
}

/**
 * 保存短网址
 * @param longUrl
 */
function saveShortUrl(longUrl){
    var longUrl = $("#long_url").val();
    if(null == longUrl || "" == $.trim(longUrl)){
        alert("长网址不可为空");
        return;
    }
    $("#short_url").html("");
    common.ajaxPostJson(domain + "/d/saveUrl",null,function (data) {
        var  html ="短网址：";
        html += '<a id="short_url_a" href="' + data.data.shortUrl +'" target="_blank">点击这里</a>'
        html += "<br><span>" + data.data.shortUrl + "</span>";
        $("#short_url").html(html);
    },function (data) {
        alert(data.msg);
    })
}

/**
 * 新冠病毒-初始化
 */
function initNcp() {
    common.ajaxPostJson(domain + "/common/ncpInfo",null,function (data) {
        // 反转义转换JSON
        ncpInfo = JSON.parse(oppositeMeaning(data.data))
        ncpFun(ncpInfo)
    },function (data) {
        console.log(data);
    })
}

/**
 * 新冠病毒-数据组装
 */
function ncpFun(data) {
    var html = "";
    html += "确诊：" + data.data.diagnosed + "/新增"+ data.data.diagnosedIncr+"（重症：" + data.data.serious + "/新增" + data.data.seriousIncr + "）例";
    html += "<br>疑似：" + data.data.suspect + "/新增" + data.data.suspectIncr + "例";
    html += "<br>死亡：" + data.data.death + "/新增" + data.data.deathIncr + "例";
    html += "<br>治愈：" + data.data.cured + "/新增" + data.data.curedIncr + "例";
    html += "<br>数据更新时间：" + data.data.date;
    $("#ncpInfo").html(html);

    //  确诊病例
    var dataListConfirmed = new Array();
    // 治愈病例
    var dataListCured = new Array();
    // 死亡病例
    var dataListDead = new Array();
    var tempNanhai = new Object();
    tempNanhai.name = "南海诸岛";
    tempNanhai.value = 0;
    dataListConfirmed.push(tempNanhai);
    dataListCured.push(tempNanhai);
    dataListDead.push(tempNanhai);
    $.each(data.data.area,function(index, item) {
        //  确诊病例
        var obj = new Object();
        obj.name = item.provinceShortName;
        obj.value = item.confirmedCount;
        dataListConfirmed.push(obj);
        // 治愈病例
        obj = new Object();
        obj.name = item.provinceShortName;
        obj.value = item.curedCount;
        dataListCured.push(obj);
        obj = new Object();
        // 死亡病例
        obj.name = item.provinceShortName;
        obj.value = item.deadCount;
        dataListDead.push(obj);
    });

    // 基于准备好的dom，初始化echarts实例
    var myChartConfirmed = echarts.init(document.getElementById("ncp_confirmed_ount"));
    var myChartCured = echarts.init(document.getElementById("ncp_cured_count"));
    var myChartDead = echarts.init(document.getElementById("ncp_dead_count"));
    ncpMap(dataListConfirmed, "确诊病例", myChartConfirmed, "#F3BAB0");
    ncpMap(dataListCured, "治愈病例", myChartCured, "#66CC99");
    ncpMap(dataListDead, "死亡病例", myChartDead, "#B4C0D5");
}

/**
 * 新冠病毒map图渲染
 *   “新型冠状病毒肺炎”，简称“新冠肺炎”，英文名为“Novel coronavirus pneumonia”，简称为“NCP”
 **/
function ncpMap(data, name, myChart, colorMax) {
    var option = {
        title:{
            text:"实时新型冠状病毒全国统计数据（" + name + "）"
        },
        tooltip: {
            formatter:function(params,ticket, callback){
                return params.seriesName+'<br />'+params.name+'：'+params.value
            }
        },
        visualMap: {
            min: 0,
            max: 1500,
            left: 'left',
            top: 'bottom',
            text: ['高','低'],
            inRange: {
                color: ['#e0ffff', colorMax]
            },
            show:true
        },
        geo: {
            map: 'china',
            roam: false,
            zoom:1.23,
            label: {
                normal: {
                    show: true,
                    fontSize:'10',
                    color: 'rgba(0,0,0,0.7)'
                }
            },
            itemStyle: {
                normal:{
                    borderColor: 'rgba(0, 0, 0, 0.2)'
                },
                emphasis:{
                    areaColor: '#F3B329',
                    shadowOffsetX: 0,
                    shadowOffsetY: 0,
                    shadowBlur: 20,
                    borderWidth: 0,
                    shadowColor: 'rgba(0, 0, 0, 0.5)'
                }
            }
        },
        series : [
            {
                name: '信息量',
                type: 'map',
                geoIndex: 0,
                data:data
            }
        ]
    };
    // 使用刚指定的配置项和数据显示图表。
    myChart.setOption(option);
}

/**
 * 反转义
 * https://www.cnblogs.com/willingtolove/p/11059325.html
 * @param str
 * @returns {void | string | *}
 */
function oppositeMeaning(str) {
    var arrEntities={'lt':'<','gt':'>','nbsp':' ','amp':'&','quot':'"'};
    return str.replace(/&(lt|gt|nbsp|amp|quot);/ig,function(all,t){return arrEntities[t];});
}

/**
 * 时间格式化处理
 * @param fmt "yyyy-MM-dd"
 * @param date
 * @returns {void | string | *}
 */
function dateFtt(fmt,date){
    var o = {
        "M+" : date.getMonth()+1,     //月份
        "d+" : date.getDate(),     //日
        "h+" : date.getHours(),     //小时
        "m+" : date.getMinutes(),     //分
        "s+" : date.getSeconds(),     //秒
        "q+" : Math.floor((date.getMonth()+3)/3), //季度
        "S" : date.getMilliseconds()    //毫秒
    };
    if(/(y+)/.test(fmt))
        fmt=fmt.replace(RegExp.$1, (date.getFullYear()+"").substr(4 - RegExp.$1.length));
    for(var k in o)
        if(new RegExp("("+ k +")").test(fmt))
            fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
    return fmt;
}


common.ajaxPostJson = function(url, data, success, error){
    common.ajaxPostJsonBeforeSend(url, data, success, error,function(xhr) {})
}

common.ajaxPostJsonAuthorization = function(url, data, success, error){
    common.ajaxPostJsonBeforeSend(url, data, success, error,function(xhr) {
        xhr.setRequestHeader("Authorization", $.cookie("token"));
    })
}

common.ajaxPostJsonBeforeSend = function(url, data, success, error, beforeSendFun){
    $.ajax({
        type: 'POST',
        url: url,
        data: data,
        contentType: "application/json;charset=UTF-8",
        dataType : "json",
        beforeSend: function(xhr) {
            beforeSendFun(xhr);
        },
        success:function(data){
            if ("FAIL" == data.type) {
                error(data);
            } else {
                success(data);
            }
        },
        error:function(error){
            console.log(error);
        }
    })
}


// 根据城市编码获取城市名称
common.getCityNameForCount = function(value){
    if (value == '2101') {
        return '沈阳市';
    } else if (value == '2102') {
        return '大连市';
    } else if (value == '2103') {
        return '鞍山市';
    } else if (value == '2104') {
        return '抚顺市';
    } else if (value == '2105') {
        return '本溪市';
    } else if (value == '2106') {
        return '丹东市';
    } else if (value == '2107') {
        return '锦州市';
    } else if (value == '2108') {
        return '营口市';
    } else if (value == '2109') {
        return '阜新市';
    } else if (value == '2110') {
        return '辽阳市';
    } else if (value == '2111') {
        return '盘锦市';
    } else if (value == '2112') {
        return '铁岭市';
    } else if (value == '2113') {
        return '朝阳市';
    } else if (value == '2114') {
        return '葫芦岛市';
    } else if (value == '2100') {
        return '辽宁省';
    }
    return "";
}

log = function (data) {
    console.log(data);
}
