import QtQuick
import QtMultimedia
import QtQuick.Controls

Item{
    Item{
        id: item
        anchors.fill: parent

        MediaPlayer{
            id: player
            // property url path: "file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
            // source: "/root/tmp/Nathan Evans - Wellerman (Sea Shanty) .mkv"
            source: "file:///root/tmp/Linux Directories Explained in 100 Seconds.mp4"
            audioOutput: AudioOutput{}
            videoOutput:videoOutput
            autoPlay:true
        }
        VideoOutput{
                        id: videoOutput;
                        anchors.fill: parent
                        fillMode: VideoOutput.PreserveAspectFit
                        // orientation: 90
                    }

        focus: true
        Keys.onSpacePressed: player.playbackState === MediaPlayer.PlayingState? player.pause(): player.play()

        Keys.onLeftPressed: player.position -=2000
        Keys.onRightPressed: player.position -=2000
    }

        Slider{
            width: parent.width
            anchors.bottom: item.bottom
            to: player.duration
            value: player.position
        }
}
