/**
*   “新型冠状病毒肺炎”，简称“新冠肺炎”，英文名为“Novel coronavirus pneumonia”，简称为“NCP”
**/
// 新冠病毒map图渲染
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
