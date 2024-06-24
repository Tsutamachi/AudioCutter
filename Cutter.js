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
        console.log("endCuttingTime: "+ now)
        return now
    }
}
//保存剪辑文件
function saveTriggered(){
    //todo
    maincontent.dialogs.savefile.open()

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

