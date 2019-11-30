import QtQuick 2.7
import QtQuick.Layouts 1.1
import QtQuick.Controls 2.1
import "./Pinyin.js" as PinyinUtil
Item {
    width: 1870/2
    height: 1000

    property var letters: ["A","B","C","D","E","F","G","H","I","J","K",
        "L","M","N","O","P","Q","R","S","T","U","V","W",
        "X","Y","Z","#"]


    //联系人列表
    Item{
        width: parent.width
        height: parent.height
        anchors.centerIn: parent


        Rectangle{
            anchors.fill: parent
            color: "#2A2D33"
        }

        Component {
            id:sectionHeader
            Item {
                width: 100
                height: 120

                Text {
                    //                    anchors.verticalCenter: parent.verticalCenter
                    text: section.toUpperCase()/*.substr(0, 1)*/
                    font.pixelSize: 54
                    anchors.left: parent.left
                    anchors.leftMargin: 40
                    color: "#545a66"
                    anchors.bottom: parent.bottom
                }
            }
        }




        ListView{

            //listview的分组不会自动排序
            width:parent.width;height: parent.height-130
            anchors.bottom: parent.bottom
            clip: true
            id:listView
            //            spacing:20

            model: testModel
            delegate: Item {
                height: 120
                width: parent.width
                Text {
                    text: listView.getShowTextSpecial(name)
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#858fa2"
                    font.pixelSize: 45
                    x:40
                }
                Rectangle{
                    anchors.bottom: parent.bottom
                    color: "#1a1c20"
                    width: parent.width
                    height: 1
                }
            }

            ScrollIndicator.vertical: ScrollIndicator {
                anchors.right: parent.right
                anchors.rightMargin: 10
                contentItem: Rectangle {
                    implicitWidth: 8
                    radius: implicitWidth/2
                    color: "#0f1115"
                }
            }

            function getShowTextSpecial(str){
                var first = str[0];
                if (first === "#")
                    return str.substr(1);
                return str;
            }


            section.property: "pinyin";
            section.criteria: ViewSection.FirstCharacter //ViewSection.FirstCharacter//
            section.delegate: sectionHeader

        }




        //只要是View就必须要给一个大小
        Item{
            width:80;height: parent.height-130
            anchors.top: parent.top
            anchors.topMargin: 130
            anchors.right: parent.right
            anchors.rightMargin: 20

            MouseArea{
                anchors.fill: parent
                //position:0到smallText.height*26(546)

                function changeBigText(){
                    bigTip.visible = true
                    var index = parseInt(mouseY/(28))
//                    console.log("index："+index)
                    if(index<0)
                        index=0
                    if(index>26)
                        index = 26
                    bigText.text = qsTr(letters[index]+"")

                    var search_index = getIndexByLab(bigText.text)
//                    console.log("search_index"+search_index )
                    listView.positionViewAtIndex(search_index, ListView.Beginning)

                }




                function getIndexByLab(lab)
                {
                    var index = -1;
                    for (var i=0;i<testModel.count;i++)
                    {
                        if (testModel.get(i).pinyin.substr(0, 1).toUpperCase() === lab)
                        {
                            return i;
                        }
                    }

                    return index;
                }



                onPositionChanged: {
                    changeBigText();
                }

                onPressed: {
                    changeBigText();
                }

                onReleased: {
                    bigTip.visible = false;

                }
            }

            Column{
                spacing:0
                padding:0
                Repeater{
                    model:letters
                    delegate: Text {
                        id:smallText
                        width: 80
                        height: 28
                        text: modelData
                        font.pixelSize: 28
                        color: "#1a1c20"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        style: Text.Raised;
                        styleColor: "#454e59"
                    }
                }
            }
        }


        Rectangle{
            width: 60;height: width
            radius: width/2
            color: "gray"
            anchors.centerIn: parent
            visible: false
            id:bigTip

            Text {
                id:bigText
                text: qsTr("A")
                font.pixelSize: 40
                color: "#181c21"
                anchors.centerIn: parent
            }
        }
    }


    function generateData(gname){
        var name = gname
        var pinyin = PinyinUtil.pinyin.getFullChars(name);
//                console.log("拼音:"+pinyin)
        var result = {"name":name,"pinyin":pinyin}
        return result
    }


    //判断是否为特殊字符
    function chack_special(str){
        var pattern1 = new RegExp("[`~!@#$^&*()=|{}':;',\\[\\].<>《》/?~！@#￥……&*（）——|{}【】‘；：”“'。，、？ ]");
        var pattern2 = /^[0-9]*$/;
        if (pattern1.test(str)||pattern2.test(str)){
            return true;
        }
        return false;
    }

    //移动数组的第一个元素到最后
    function moveFirstToEnd(array){
        var first = array[0]
        array.push(first)
        array.shift()
    }



    //测试数据
    ListModel{
        id:testModel
        property var nameList: ["皮皮","日历","父亲","额额额","高大上","黑凤梨","阿文","阿南","宝贝","昌源","老妈","老爸","#特殊","*特殊","aaa","AAA","a啊a","啊aa","阿亮","1阿1","爸爸","第八个","奶奶","叔叔","智障啊","满意","岁月","可能","黄河"]

        //        property var nameList: ["阿文","宝贝","阿6"]

        Component.onCompleted: {

            //因为ListView的分组不会自动排序，所以需要按照顺序排好啊
            //            var resultArray = nameList.sort(
            //                        function compareFunction(param1, param2) {
            //                            return param1.localeCompare(param2,"en");
            //                        }
            //                        );



            //原生排序：特殊字符-->数字-->英文-->中文


            console.log("排序前的数组："+nameList)
            var resultArray = nameList.sort(function(a, b) {
                return PinyinUtil.pinyin.getFullChars(a).localeCompare(PinyinUtil.pinyin.getFullChars(b))
            })

            var specialNumber = 0;
            for(var i =0;i<resultArray.length;i++){
                //在首字符前面加上#号
                if(chack_special(resultArray[i].substr(0, 1))){
                    //                    chack_special[i] = "#" + chack_special[i];
                    //                    resultArray.splice(-1,0,chack_special[i]);
                    //                    resultArray.unshift(resultArray[i]);
                    //在首字符前面加上#号
                    resultArray[i] = "#" + resultArray[i];
                    specialNumber++;
                }
            }

            for(i =0;i<specialNumber;i++)
                moveFirstToEnd(resultArray)

            //            console.log("特殊字符个数："+specialNumber)
            console.log("排序后的数组："+resultArray)


            for(i = 0;i<resultArray.length;i++)
                testModel.append(generateData(resultArray[i]))
        }

    }
}


