//Button1中的调用
function removeButton(){
    console.log("REMOVE triggered")
}


//Button2中调用Dialogs
//打开文件的组建调用
function openfileTriggered() {
    content.dialogs.openfile.open();
}

//播放视频的状态控制
function playTriggered(){
    if(content.audioSource.isValid)//isEmpty也不行。url怎么对空值进行判断
        content.bgimg.visible = false

    //这里只能播放，不能停止？？？？
    if(content.player.playbackState === 0)//PlayingState read-only
        content.player.pause();
    if(content.player.playbackState === 1)//PauseState
        content.player.play();
    if(content.player.playbackState === 2)//StoppedState
        content.player.play();
    // content.player.playbackState === content.player.PlayingState? content.player.pause(): content.player.play();
    console.log("Play-Button pressed!")
}
//剪辑起点的设置
function startcutTriggered(){
    endcut.enable =true
    //todo
}
//剪辑终点的设置
function endcutTriggered(){
    endcut.enable =false
    //todo
}
//保存剪辑文件
function saveTriggered(){
    //todo
}
