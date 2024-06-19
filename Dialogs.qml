import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias openfile: _openfile

    FileDialog {
        id: _openfile
        title: "Select some movie files"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Movie files (*.mp4 *.avi *.mkv)" ]
    }


}
