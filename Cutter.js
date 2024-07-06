// Cutter.js
//Button1中的调用

// 控制层
function removeButton(){
    console.log("REMOVE triggered")
}


//Buttons

//打开文件的组建调用
function openfileTriggered() {
    maincontent.dialogs.openfile.open();
}

//剪辑起点的设置
function startcutTriggered(){
    if(_startcut.enable === true)
    {
        _startcut.enable=false
        _endcut.enable =true

        var now = maincontent.player.position
        //var snow = siplifytime(now);
        _startcut.startTime = now;
        console.log("startCuttingTime: "+ now)
        /*不需要这么做，把问题复杂化了还有bug
            var startTime =new Date(qmlData.getTime()).getTime()
            console.log("startTime "+startTime)
            var startCuttingTime = now- startTime.getTime()
            console.log("startCuttingTime: "+startCuttingTime)*/
        return now
    }
}
//剪辑终点的设置
function endcutTriggered(){
    if(_endcut.enable === true)
    {
        _endcut.enable =false
        _startcut.enable=true

        var now = maincontent.player.position
        //var snow = siplifytime(now);
        _endcut.endTime = now;
        console.log("endCuttingTime: "+ now)
        returnOpenfilePath()
        return now
    }
}
//保存剪辑文件
function saveTriggered(){
    //todo
    maincontent.dialogs.savefile.open()

}
// Controller.js
// 移除裁剪的视频路径
function removeTriggered(){
    // to do
    // 清空或重置所有视图项
    // 有个小bug,就是调用readPath时，无法清除filepath.txt文件的内容，只会在后面追加为 file ''
    _mainContent.videoEdit.readPath("");
    if (_mainContent.videoEdit.videoPaths.length === 0) {
      console.log("remove");
    } else {
      console.log("not remove");
    }
    // 刷新视图
    listview.model =[];
    // listview.model = _mainContent.videoEdit.videoPaths
}



//Time

function setfileStartTime(){
    var t = new Date();
    return t;
}

//小时:分钟:秒:毫秒的string格式
//f最初是QML中的Date类型，return的结果是string类型
function siplifytime(f){
    // var holetime = maincontent.player.duration
    var holetime = new Date(f.getTime())
    var ms = parseInt(holetime%1000)
    var totolsecond = parseInt(holetime/1000)
    var second = totolsecond%60
    var minit = parseInt(totolsecond/60)
    var hour = parseInt(minit/60)

    f = hour.toString().padStart(2,'0') + ":"+ minit.toString().padStart(2,'0') + ":" + second.toString().padStart(2,'0') + ":" + ms.toString().padStart(4,'0')
    console.log(f)
    return f
}



//Content
// 设置单文件路径
function setfilepath(){
    // setFileModel(openfile.selectedFile)
    // audioSource = "";
    // player.stop()
    //当Dialog中按下accepted之后才会继续
    maincontent.dialogs.openfile.
    accepted.connect(()=>{
                         maincontent.audioSource = maincontent.dialogs.openfile.selectedFile
                         console.log("Dialogs: "+maincontent.audioSource)
                         maincontent.player.play()
                         maincontent.bgimg.visible = false
                     })
}

function returnOpenfilePath(){
    return maincontent.audioSource.toString()
}

//void getSubtitle(QString in_filepath,QString out_filepath);
function getsubtitle(){
    var in_filepath = maincontent.audioSource.toString()
    var out_filepath =  dialogs.getSubtitle.selectedFile.toString() +".srt"//不加.srt就会失败————why？

    maincontent.videoEdit.getSubtitle( in_filepath , out_filepath)
}

//    void addSubtitle(QString in_film,QString in_subtitle,QString out_filmpath)
function addsubtitle(){
    var in_filepath = maincontent.audioSource.toString();
    console.log("in_filepath: "+in_filepath);

    var in_subtitle = maincontent.dialogs.addSubtitle.selectedFile.toString();
    console.log("in_subtitle: "+in_subtitle);

    maincontent.dialogs.addSubtitle.
    accepted.connect(()=>{
                         maincontent.dialogs.getNewPath.open()
                     })

    maincontent.dialogs.getNewPath.
    accepted.connect( ()=>{
                         var out_filmpath = maincontent.dialogs.getNewPath.selectedFile.toString()+".mp4"
                         console.log("out_filmpath: "+out_filmpath)
                         maincontent.videoEdit.addSubtitleAsync(in_filepath, in_subtitle, out_filmpath);
                         //如果直接在这里更改视频源，那么就回因为上面代码是异步执行而产生问题
                         return out_filmpath
                     })
    //同步写在了MainContent中
    // onSynfinished:{
    //     maincontent.audioSource = out_filmpath
    //     console.log("现在的播放路径： "+ out_filmpath)
    //     maincontent.player.play()
    // }
}
