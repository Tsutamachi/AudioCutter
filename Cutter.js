// Cutter.js
//Button1中的调用
// 控制层
function removeButton(){
    console.log("REMOVE triggered")
}


//Button2中调用Dialogs
//打开文件的组建调用
function openfileTriggered() {
    maincontent.dialogs.openfile.open();
}


//剪辑起点的设置
function startcutTriggered(){
    _startcut.enable=false
    _endcut.enable =true
    //todo
}
//剪辑终点的设置
function endcutTriggered(){
    _endcut.enable =false
    _startcut.enable=true
    //todo
}
//保存剪辑文件
function saveTriggered(){
    //todo
}


//Content
// to do
function setfilepath(){
    // setFileModel(openfile.selectedFile)
    // audioSource = "";
    // player.stop()
    maincontent.audioSource = maincontent.dialogs.openfile.selectedFile
    console.log("Dialogs: "+maincontent.audioSource)
    maincontent.player.play()
    maincontent.bgimg.visible = false
}
