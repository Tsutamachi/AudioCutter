import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "Controller.js" as Controller

Rectangle {
    // anchors.right: parent.right
    anchors.bottom: parent.bottom
    Button{
        id:leftButton
        anchors{
            bottom: parent.bottom
            left:parent.left
            margins: 10
        }
        width:100
        height:40

        //按钮内容
        contentItem:RowLayout{
            Image{
                source:"/root/加.svg"
                width:20
                height:20
            }
            Text{
                text:"ADD"
                color:"white"
                font.bold:true
                // Layout.alignment: parent.Center
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                HoverHandler{
                    onHoveredChanged: ()=>{
                                          statusText.text=hovered?"Add one or more files to an existing project or an empty list if you are only joining files":""
                                      }
                }

            }
        }
        //设置背景颜色
        background:Rectangle{
            radius:5
            color:leftButton.down?(Qt.darker("gray",1.5)):"gray"
        }

    }

    Button{
        id:rightButton
        anchors{
            bottom:parent.bottom
            left:leftButton.right
            margins: 10
        }
        width:100
        height:40
        contentItem:RowLayout{
            anchors.right:parent.right
            Text{
                text:"REMOVE"
                color:"white"
                font.bold:true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                HoverHandler{
                    onHoveredChanged: ()=>{
                                          statusText.text=hovered?"Remove clips from your index":""
                                      }
                }

            }
            Image{
                source:"/root/减.svg"
                width:20
                height: 20
                anchors.verticalCenter: parent.verticalCenter
            }

        }
        //设置背景颜色
        background:Rectangle{
            color:rightButton.down?(Qt.darker("gray",1.5)):"gray"
            radius:5
        }
        TapHandler{
            onTapped:()=>{
                         Controller.removeButton();
                     }
        }
    }
}
