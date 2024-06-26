import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias openfile: _openfile
    // property alias savefile: _savefile

    FileDialog {
        id: _openfile
        title: "Select some movie files"
        currentFolder: StandardPaths.writableLocation(StandardPaths.DocumentsLocation)
        fileMode: FileDialog.OpenFiles
        nameFilters: [ "Movie files (*.mp4 *.avi *.mkv)" ]
    }

    // FileDialog{
    //     id:_savefile
    //     title: "Save file"
    //     currentFolder: "/root"
    //     fileMode: FileDialog.SaveFile

    //     Component.onCompleted: {
    //         _mainContent.videoEdit.videoMergeCompleted.connect(function(mergeFilePath){
    //         _savefile.fileUrl = mergeFilePath  // 设置保存的文件路径
    //             _savefile.open() // 打开文件保存的对话框
    //         }
    //             )
    //     }
    // }


}
