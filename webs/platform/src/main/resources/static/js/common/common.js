//微信配置
var wxConfig;
// 新冠病毒数据
var ncpInfo;
/**
 * 微信-初始化
 */
function initWx() {
    $.ajax({
        url: context_path + "/common/wxConfig",
        success:function(data){
            if ("FAIL" == data.type) {
                console.log(data);
                return;
            } else {
                wxConfig = data.data;
                wxFun(data.data)
            }
        },
        error:function(error){
            alert(error)
        }
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
    wx.checkJsApi({
        jsApiList: jsApiList, // 需要检测的JS接口列表，所有JS接口列表见附录2,
        success: function(res) {
            // 以键值对的形式返回，可用的api值true，不可用为false
            // 如：{"checkResult":{"chooseImage":true},"errMsg":"checkJsApi:ok"}
        }
    });
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
    $.ajax({
        url: context_path + "/d/saveUrl",
        data:{
            longUrl : longUrl
        },
        success:function(data){
            console.log(data);
            if ("FAIL" == data.type) {
                alert(data.msg);
                return;
            } else {
                var  html ="短网址：";
                html += '<a id="short_url_a" href="' + data.data.shortUrl +'" target="_blank">点击这里</a>'
                html += "<br><span>" + data.data.shortUrl + "</span>";
                $("#short_url").html(html);
            }
        },
        error:function(error){
            alert(error)
        }
    })
}

/**
 * 新冠病毒-初始化
 */
function initNcp() {
    $.ajax({
        url: context_path + "/common/ncpInfo",
        success:function(data){
            if ("FAIL" == data.type) {
                console.log(data);
                return;
            } else {
                // 反转义转换JSON
                ncpInfo = JSON.parse(oppositeMeaning(data.data))
                ncpFun(ncpInfo)
            }
        },
        error:function(error){
            alert(error)
        }
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
