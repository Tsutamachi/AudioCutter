import QtQuick
import QtQuick.Controls

Item{
    id:actions
    property alias getsubtitle: _getsubtitle
    property alias addsubtitle: _addsubtitle


    Action{
        id:_getsubtitle
        text:qsTr("get subtitle file")
        property bool enable: false
    }

    Action{
        id:_addsubtitle
        text:qsTr("add subtitle file")
        property bool enable: false
    }

}
