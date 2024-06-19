//Button2中调用Dialogs
//打开文件的组建调用
function openfileTriggered() {
    content.dialogs.openfile.open();
}
//播放视频的状态控制
function playTriggered(){
    if(content.player.playbackState === StoppedState)
        content.player.play();
    if(content.player.playbackState === PlayingState)
        content.player.pause();
    if(content.player.playbackState === PauseState)
        content.player.play();
}
//剪辑起点的设置
function startcutTriggered(){
    endcut.enable =true
}
//剪辑终点的设置
function endcutTriggered(){
    endcut.enable =false
}
//保存剪辑文件
function saveTriggered(){

}
