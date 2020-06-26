var getLocation = function(){
    if(navigator.geolocation){
        //判断是否有这个对象
        navigator.geolocation.getCurrentPosition(function(pos){
            return "经度："+pos.coords.longitude+ "纬度："+pos.coords.latitude;
        })
    }else{
        return -1;
    }
}
/*
————————————————
版权声明：本文为CSDN博主「Winston-王」的原创文章，遵循 CC 4.0 BY-SA 版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/qq_42915565/article/details/81512034*/
