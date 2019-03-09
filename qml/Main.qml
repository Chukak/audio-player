import "./Components" as Components
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import ListAudioModels 0.1
import AudioModel 0.1

ApplicationWindow 
{
    id: mainWindow
    visible: true
    minimumWidth: 1024
    minimumHeight: 512
    title: "Audio Player"

    Components.Audio
    {
        id: audioPlayer
    }

    ListAudioModels
    {
        id: listAudioModels
        Component.onCompleted: {
            console.log(listAudioModels.at(0).getPath())
            console.log(listAudioModels.at(0).getTitle())
            audioPlayer.source = listAudioModels.at(0).getPath()
            audioPlayer.play()
        }
    }
}
