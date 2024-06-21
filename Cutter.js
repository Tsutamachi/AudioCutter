// 控制层
function removeButton(){
    console.log("REMOVE triggered")
}



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

function setfileStartTime(){
    var t = new Date();
    return t;
}


//Content
// 设置文件路径
function setfilepath(){
    // setFileModel(openfile.selectedFile)
    // audioSource = "";
    // player.stop()
    maincontent.dialogs.openfile.accepted.connect(()=>{
                                                      maincontent.audioSource = maincontent.dialogs.openfile.selectedFile
                                                      console.log("Dialogs: "+maincontent.audioSource)
                                                      maincontent.player.play()
                                                      maincontent.bgimg.visible = false
                                                      // setfileStartTime()
                                                      // await sleep(1000)
                                                      // currentTime()

                                                  })

    // for (var key in player.metaData) {
    //     console.log(key + ": " +stringValue(player.metaData[key]));
    // }
}
//小时:分钟:秒:毫秒的string格式
function positiontime(){
    var holetime = maincontent.player.duration
    var ms = parseInt(holetime%1000)
    var totolsecond = parseInt(holetime/1000)
    var second = totolsecond%60
    var minit = parseInt(totolsecond/60)
    var hour = parseInt(minit/60)

    var f = hour.toString().padStart(2,'0') + ":"+ minit.toString().padStart(2,'0') + ":" + second.toString().padStart(2,'0') + ":" + ms.toString().padStart(4,'0')
    console.log(f)
}

// function sleep(ms){
//     return new  Promise(resolve => setTimeout(resolve, ms));
// }

function getMediaStartTime(){
    var now = new Date()
    console.log("mediaStart time: "+now)
    return now
}
