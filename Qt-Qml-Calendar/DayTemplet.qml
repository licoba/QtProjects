import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Button {

    width: 100
    height: 100
    property var number: 01 //显示的数字
    property var beClicked:false //是否被点击过
    property var isPass: true //是否已经过了，用来设置文字的颜色。没过为灰色，不可点击，过了的为白色
    id: control


    Text {
        text: qsTr("" + number)
        anchors.centerIn: parent
        font.pixelSize: 30
        //如果是“今”：白色/如果
        color:text=="今"?"white": control.checked?"white":isPass ? "#aaffffff" : "gray"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    style: ButtonStyle {
        background:Rectangle {
            anchors.fill: parent
            opacity: enabled ? 1 : 0.3 //透明度
            color: control.checked ? "#4975F8" : "#2C2F38"

            Rectangle {
                id: rectangle
                x: 12
                width: 6
                height: 6
                color: "#4975F8"
                radius: 3
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 15
                anchors.horizontalCenter: parent.horizontalCenter
                visible:number===""?false:!beClicked
            }

        }

    }


    onClicked: {
        if(number!==""){
            control.checked = true;
            beClicked = true
        }}
}


