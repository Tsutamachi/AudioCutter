import QtQuick
import QtQuick.Controls

Item {
    property alias view:view
    property var sum:[]
    Rectangle{
        anchors.fill:parent
        color:"gray"
        ListView{
            id:view
            anchors.fill: parent
        }
    }
}
