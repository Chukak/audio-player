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
        }
    }

    Components.Audio
    {
        id: audioPlayer
    }

    Item 
    {
        id: listAudioArea
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: playerContronsButtonArea.bottom
        width: 300     

        Components.ListAudio 
        {
            id: listAudio
        }
    }

    Item 
    {
        id: playerContronsButtonArea
        anchors.left: listAudioArea.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: parent.width - listAudioArea.width
        height: 50
        
        Components.ControlsButtons 
        {
            id: playerControlsButton
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            width: parent.width
            height: parent.height > 40 ? 40 : parent.height
        }
    }
}
