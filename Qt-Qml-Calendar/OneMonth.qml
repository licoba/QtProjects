import QtQuick 2.0
import QtQuick.Controls 1.4


Item {
    //提供给外界的参数
    id:oneMonth
    property int year
    property int month
    property var dayList: []
    property var nowDate : new Date()

    Component.onCompleted: {
        initView(year,month)
    }


    Connections{
        target:item
        onClickFresh:{
            initView(year,month)
        }
    }

    // 根据年、和月（日）来刷新视图
    function initView(x_year,x_month){

        dayList = []
        //获取month月天数：
        var daycount = new Date(x_year,x_month+1,0).getDate();
        //        console.log((x_month+1)+"月天数："+daycount)
        //        var myDate = new Date(x_year,x_month,x_day);
        //        console.log("myDate"+myDate)
        //        console.log("2018年11月1号是星期："+new Date(2018,10,1).getDay())
        //这个月的第一号是星期几(getDay方法)
        var weeDate = new Date(x_year,x_month,1);
        var weekDay = weeDate.getDay();
//        console.log("这个月一号是星期："+weekDay)
        // 加入dayList,先加入上个月的空白，然后加入本月的日期
        for(var i = 1;i<=weekDay;i++){
            dayList.push("")
        }

        for(var i = 1;i<=daycount;i++){
            var str = ("0"+i);
            dayList.push(str.substring(str.length-2,str.length))  //QML 的数组插入元素为push方法
        }

        //        console.log(dayList)
        repeater.model = dayList //需要手动指定model去刷新控件
//        console.log("--------")
    }


    //显示一个月的日历控件

    Grid {
        id: grid
        anchors.fill: parent
        columns:7
        spacing:1

        ExclusiveGroup {
            id: buttonGroup
        }

        Repeater{
            id:repeater
            model:dayList
            delegate:
                DayTemplet{
                exclusiveGroup:buttonGroup  //1.4里面的属性
                width: grid.width/7-1
                height: grid.height/6-1
                number:year == nowDate.getFullYear()?month == nowDate.getMonth()?modelData==nowDate.getDate()?"今":modelData:modelData:modelData
                isPass: judgePass(year,month)

                function judgePass(year,month){
                    if(year<nowDate.getFullYear())
                        return true;
                    else if(year>nowDate.getFullYear()){
                        return false
                    }else{
                        if(month<nowDate.getMonth())
                            return true;
                        else if(month>nowDate.getMonth())
                            return false;
                        else{
                            if(modelData<=nowDate.getDate())
                                return true;
                            else
                                return false;
                        }
                    }
                }
            }
        }
    }


}
