import QtQuick
import QtQuick.Dialogs
import "Cutter.js" as Controller

Item {
    id:messageBox
    property alias messageDialog1:_messageDialog1
    property alias messageDialog2:_messageDialog2
    property alias messageDialog3:_messageDialog3
    property alias messageDialog4:_messageDialog4

    MessageDialog {
            id: _messageDialog1
            title: "Hint Message"
            text: "Please specify the movie file before you extract the subtitle file!\n"
            buttons: MessageDialog.Ok /*| MessageDialog.Open*/
            // onOpenClicked:{Controller.setfilepath()}
        }

    MessageDialog {
            id: _messageDialog2
            title: "Hint Message"
            text: "Please specify the movie file before you merge the subtitle file!\n"
            buttons: MessageDialog.Ok/* | MessageDialog.Open*/
        }

    MessageDialog{
        id:_messageDialog3
        title: "Hint Message"
        text:"have Finished to extract the subtitle file!"
        buttons: MessageDialog.Ok
    }
    MessageDialog{
        id:_messageDialog4
        title: "Hint Message"
        text:"have Finished to merge the subtitle file!"
        buttons: MessageDialog.Ok
    }
}
