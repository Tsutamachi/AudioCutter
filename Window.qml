// 可以qml中调用 VideoEdit 类了
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import se.qt.videoEditing

ApplicationWindow {
    id:app
    // width: 1100
    // height: 900
    // Layout.fillHeight: true
    // Layout.fillWidth: true
    minimumHeight: 650
    minimumWidth: 920
    visible: true
    property alias footerText: statusText.text
    property alias actions: actions

    menuBar: MenuBar
    {
        Menu{
            title: qsTr("Subtitle")
            MenuItem{
                action: actions.getsubtitle
                // color: actions.getsubtitle.enabled? balck: grey
            }
            MenuItem{ action: actions.addsubtitle}
        }
    }

    Actions{
        id:actions
        getsubtitle.onTriggered:{
            if(actions.getsubtitle.enable)
                content.maincontent.dialogs.getSubtitle.open()
        }

        addsubtitle.onTriggered:{
            if(actions.addsubtitle.enable)
                content.maincontent.dialogs.addSubtitle.open()
        }
    }

    Content{
        id:content
    }

    footer:
    Rectangle{
        id: foot
        visible: true
        width: app.width
        height: 20

        Text{
            id:statusText
            text: ""
            color:"black"
            anchors.left: parent.left
            font.pixelSize: 12
            font.weight: Font.Thin
        }
    }

    Connections{
        target: app
        onClosing:{
           content.maincontent.videoEdit.deleteDirectory()
        }
    }
}
