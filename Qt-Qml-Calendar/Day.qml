import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.0

Item {
    width: 800
    height: 720
    id:item
    property var dayList: []
    property int year
    property int month
    property int day
    property var weekDay //星期几
    signal clickFresh();

    Component.onCompleted: {
        var nowTime = new Date();
        console.log("nowTime："+nowTime)
        year = nowTime.getFullYear()
        month = nowTime.getMonth()
        day = nowTime.getDate()
        //        console.log("nowTimeyear："+year)
        //        console.log("nowTimemonth："+month)//8 表示9月
        //        console.log("nowTimeDay："+day)
        //        initView(year,month,day)

    }

    function addMonth(){
//        console.log("+1月")
        pathView.incrementCurrentIndex()
        refresh();
    }

    function reduceMonth(){
//        console.log("-1月")
        pathView.decrementCurrentIndex()
        refresh();
    }

    function getShowText(year,month){
        var showMonth = month+1
        var showText = year+"/"+("0"+showMonth).substring(("0"+showMonth).length-2,(("0"+showMonth).length))
        return showText;
    }


    function refresh(){
        var cIndex = pathView.currentIndex
        //            console.log("onMovementEnded", "currentIndex："+cIndex)
        //pathView.currentIndex表示的是最左边的model
        //因为中间的一位永远是在显示的状态，所以在停止滑动之后，改变最左边和最右边的数据
        //            console.log("当前月：",riliModel.get((cIndex+1)%3).data_month)
        //            console.log("上一月：",riliModel.getMonth(0,riliModel.get((cIndex+1)%3).data_year,riliModel.get((cIndex+1)%3).data_month))

        riliModel.setProperty(cIndex,
                              "data_year",
                              riliModel.getYear(0,
                                                riliModel.get((cIndex+1)%3).data_year,
                                                riliModel.get((cIndex+1)%3).data_month
                                                )
                              )
        riliModel.setProperty(cIndex, "data_month", riliModel.getMonth(0,riliModel.get((cIndex+1)%3).data_year,riliModel.get((cIndex+1)%3).data_month))
        riliModel.setProperty((cIndex+2)%3, "data_year", riliModel.getYear(2,riliModel.get((cIndex+1)%3).data_year,riliModel.get((cIndex+1)%3).data_month))
        riliModel.setProperty((cIndex+2)%3, "data_month", riliModel.getMonth(2,riliModel.get((cIndex+1)%3).data_year,riliModel.get((cIndex+1)%3).data_month))
        //            riliModel.sync();// 这部不能省略，但是报错List sync() can only be called from a WorkerScript
        pathView.model = riliModel
        //            oneMonth.initView();
        tv.text = getShowText(riliModel.get((cIndex+1)%3).data_year,riliModel.get((cIndex+1)%3).data_month)
        item.clickFresh();
    }
    //当停止滑动，页面静止之后，更新currentIndex
    Connections{
        target: pathView
        onMovementEnded:{
        refresh();
        }
    }




    Rectangle {
        id: rectangle
        color: "#2c2f38"
        radius: 10
        border.width: 0
        anchors.fill: parent

        Rectangle {
            id: rectangle1
            height: 42
            color: "#1e1f23"
            radius: 5
            anchors.right: parent.right
            anchors.rightMargin: 80
            anchors.left: parent.left
            anchors.leftMargin: 80
            anchors.top: parent.top
            anchors.topMargin: 20

            Text {
                id: tv
                color: "#ffffff"
                text: getShowText(year,month)
                anchors.centerIn: parent
                font.pixelSize: 25
            }
        }

        Image {
            id: image
            width: 42
            height: 42
            anchors.top: rectangle1.top
            anchors.topMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 15
            source: "icon/arrowleft.png"

            MouseArea{
                anchors.fill: parent
                onClicked: {
                    item.reduceMonth()
                }
            }

        }

        Image {
            id: image1
            x: 225
            width: 42
            height: 42
            anchors.top: rectangle1.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 15
            source: "icon/arrowright.png"
            MouseArea{
                anchors.fill: parent
                onClicked: {
                    item.addMonth()
                }
            }
        }


        Rectangle {
            id: rectangle2
            color: "#2c2f38"
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 50
            anchors.right: parent.right
            anchors.rightMargin: 50
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.top: rectangle1.bottom
            anchors.topMargin: 50

            Row {
                id: row
                x: 38
                width: children.width+spacing*6
                height: 70
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 40
                anchors.top: parent.top
                anchors.topMargin: 0

                Text {
                    id: text1
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周日")
                    horizontalAlignment: Text.AlignHCenter
                    anchors.verticalCenter: parent.verticalCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text2
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周一")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text3
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周二")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text4
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周三")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text5
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周四")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text6
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周五")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }

                Text {
                    id: text7
                    width: 60
                    color: "#ffffff"
                    text: qsTr("周六")
                    anchors.verticalCenter: parent.verticalCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 25
                }
            }

            //日历的数字显示区
            Rectangle {
                id: rectangle3
                color: "#2c2f38"
                height: parent.height-row.height
                width: parent.width
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.top: row.bottom
                clip: true

                PathView {
                    id: pathView
                    anchors.fill: parent
                    model: riliModel
                    delegate: delegate
                    currentIndex : 0
                    clip:true
                    path: Path {

                        startX: - pathView.width/2
                        startY: pathView.height/2

                        PathLine {
                            x: pathView.width*2.5
                            y: pathView.height / 2
                        }

                    }

                    //路径上可见的项目数。如果不设置则会全部显示出来
                    pathItemCount:3
                    //不让它有拖拉惯性，无论拖拉再远都只显示路径上紧邻的一个
                    snapMode:PathView.SnapOneItem
                }


                //日历的数据，平常的日历只用传入年和月。
                ListModel {
                    id: riliModel

                    //ListElement里面不允许写JS语法

                    Component.onCompleted: {
                        riliModel.append({"data_year": getYear(0,year,month),"data_month": getMonth(0,year,month)})
                        riliModel.append({"data_year": getYear(1,year,month),"data_month": getMonth(1,year,month)})
                        riliModel.append({"data_year": getYear(2,year,month),"data_month": getMonth(2,year,month)})
                    }

                    function getMonth(index,year,month){
                        if(index === 1){
                            return month
                        }else if(index === 0){
                            return month === 0 ? 11:month-1//如果是一月份，那么月份为11
                        }else{
                            return month === 11 ? 0:month+1
                        }
                    }

                    function getYear(index,year,month){
                        if(index === 1){
                            return year
                        }else if(index === 0){
                            return month === 0 ? year -1:year //如果是一月份，那么年份减一
                        }else{
                            return month === 11 ?year +1:year
                        }
                    }
                }

                //代理，显示一个月的日历控件
                Component {
                    id:delegate
                    OneMonth{
                        height: rectangle3.height
                        width: rectangle3.width
                        year: data_year
                        month: data_month
                    }

                }



            }


        }
    }
}
