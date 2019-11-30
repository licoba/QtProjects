import QtQuick 2.0
import QtWebEngine 1.4
Item {

    anchors.fill: parent

    WebEngineView{
        anchors.fill: parent
        url:"test.html"
//        url: "http://www.baidu.com"
    }
}
