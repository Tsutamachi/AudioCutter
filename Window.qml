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

    menuBar: MenuBar
    {
        Menu{
            title: qsTr("Subtitle")
            MenuItem{ action: actions.getsubtitle}
            MenuItem{ action: actions.addsubtitle}
        }
    }

    Actions{
        id:actions
        getsubtitle.onTriggered:content.maincontent.dialogs.getSubtitle.open()
        addsubtitle.onTriggered:{
            content.maincontent.dialogs.addSubtitle.open()
            // content.maincontent.dialogs.getNewPath.open()
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
}
