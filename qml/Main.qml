import "./Components" as Components
import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Window 2.12
import ListAudioModels 0.1
import AudioModel 0.1
import IconModel 0.1

ApplicationWindow 
{
    id: mainWindow
    visible: true
    minimumWidth: 1024
    minimumHeight: 512
    maximumWidth: 1024
    maximumHeight: 512
    title: "Audio Player"

    ListAudioModels
    {
        id: listAudioModels
        Component.onCompleted: 
        {
            listAudio.listModels = listAudioModels
            listAudio.filled()
        }
    }

    IconModel
    {
        id: iconModel
        Component.onCompleted: 
        {
            playerControlsButton.iconModel = iconModel
            playerControlsButton.setIcons()
            listAudio.iconModel = iconModel
            listAudio.setIcons()
            audioInfo.iconModel = iconModel
        }
    }

    Components.Audio
    {
        id: audioPlayer

        onPlaying:
        {
            playerControlsButton.playAudio()
        }
        onPaused:
        {
            playerControlsButton.pauseAudio()
        }
        onStopped:
        {
            playerControlsButton.stopAudio()
        }
    }

    Components.AudioFilesDialog
    {
        id: audioFileDialog
    }

    Item 
    {
        id: listAudioArea
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        width: 300     

        Components.ListAudio 
        {
            id: listAudio
            audioInfoObject: audioInfo
        }
    }

    Item 
    {
        id: playerContronsButtonArea
        anchors.left: listAudioArea.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        height: 40
        
        Components.ControlsButtons 
        {
            id: playerControlsButton
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: parent.height
        }
    }

    Item 
    {
        id: audioInfoArea
        anchors.left: listAudioArea.right
        anchors.right: parent.right
        anchors.bottom: playerContronsButtonArea.top
        anchors.top: parent.top

        Components.AudioInfoArea
        {
            id: audioInfo
            anchors.fill: parent
        }
    }
}
