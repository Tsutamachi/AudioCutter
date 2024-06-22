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
    function startcutTriggered(qmlData){
        _startcut.enable=false
        _endcut.enable =true

        // positiontime()
        var now = new Date()
        // console.log("cutTime: "+now.getTime())


        var startTime =new Date(qmlData.getTime())
        // console.log("startTime: "+startTime.getTime())
        var startCuttingTime = now.getTime()- startTime.getTime()
        console.log("startCuttingTime: "+startCuttingTime)
        return startCuttingTime
    }
    //剪辑终点的设置
    function endcutTriggered(qmlData){
        _endcut.enable =false
        _startcut.enable=true

        var now = new Date()
        var endTime =new Date(qmlData.getTime())
        var endCuttingTime = now.getTime()- endTime.getTime()
        console.log("endCuttingTime "+endCuttingTime)
        return endCuttingTime
    }
    //保存剪辑文件
    function saveTriggered(){
        //todo
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

