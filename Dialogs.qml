import QtQuick
import QtCore
import QtQuick.Controls
import QtQuick.Dialogs

Item {
    property alias openfile: _openfile
    // property alias savefile: _savefile
    // property alias videoEdit: _videoEdit
    property alias getSubtitle: _getSubtitle
    property alias addSubtitle: _addSubtitle
    property alias getNewPath: _getNewPath


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

    //获取提取出的字幕文件的保存路径
    FileDialog{
        id:_getSubtitle
        title: qsTr("Select the path to save subtitle file")
        currentFolder: "/root"
        fileMode:FileDialog.SaveFile
    }

    //获取要添加到视屏的字幕文件的路径
    FileDialog{
        id:_addSubtitle
        title: qsTr("Select the will to add subtitle file")
        currentFolder: "/root"
        fileMode:FileDialog.OpenFile

        nameFilters: [ "Subtitle files (*.srt)" ]
    }
    //获取 合成视频和字幕 后的新文件的路径
    FileDialog{
        id:_getNewPath
        title: qsTr("Select the path to save new film file")
        currentFolder: "/root"
        fileMode:FileDialog.SaveFile
    }
}
