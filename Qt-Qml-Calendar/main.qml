import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    visible: true
    width: 1280
    height: 800
    title: qsTr("日历控件")
    color:"#232429"

    Day {
        anchors.centerIn: parent
    }

//    SwipeView {
//        id: swipeView
//        //        width: 800
//        //        height: 720
//        //        anchors.centerIn: parent
//        anchors.fill: parent
//        currentIndex: tabBar.currentIndex

//        Item{

//            Day {
//                anchors.centerIn: parent
//            }
//        }

//        Page {
//            Label {
//                text: qsTr("Second page")
//                anchors.centerIn: parent
//            }
//        }
//    }

//    footer: TabBar {
//        id: tabBar
//        currentIndex: swipeView.currentIndex
//        TabButton {
//            text: qsTr("日历")
//        }
//        TabButton {
//            text: qsTr("Second")
//        }
//    }



}
