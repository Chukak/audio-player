import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import "../../js/controls.js" as Scripts

Rectangle 
{
    property QtObject iconModel: null
    property real savedSoundValue: 0.0
    property int sizeButton: height - 0
    signal playAudio
    signal pauseAudio
    signal stopAudio
    signal setIcons

    id: controls
    
    anchors.leftMargin: 0
    anchors.rightMargin: 0

    gradient: Gradient 
    {
        GradientStop
        {
            color: "#40403E"
            position: 0.0
        }
        GradientStop
        {
            color: "#2E2E2D" 
            position: 1.0
        }
    }

    onPlayAudio: 
    {
        playButton.playing = true
        playButtonIcon.source = iconModel.pauseButtonIcon()
    }
    onPauseAudio: 
    {
        playButton.playing = false
    }
    onStopAudio:
    {
        playButton.playing = false
        playButtonIcon.source = iconModel.playButtonIcon()
    }
    onSetIcons:
    {
        playButtonIcon.source = iconModel.playButtonIcon()
        stopButtonIcon.source = iconModel.stopButtonIcon()
        soundButtonIcon.source = iconModel.soundButtonIcon()
    }


    Item 
    {
        id: controlsItem
        anchors.left: parent.left
        width: 80
        height: parent.height
        anchors.topMargin: 3
        anchors.bottomMargin: 3

        ToolButton 
        {
            property bool playing: false
            
            id: playButton
            anchors.left: parent.left
            width: sizeButton
            height: sizeButton

            background: Item 
            {
                Rectangle 
                {
                    id: playButtonBackground
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "transparent"
                }

                MouseArea 
                {
                    id: playButtonMouseArea
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: 
                    {
                        if (playButton.playing) {
                            playButtonIcon.source = iconModel.pauseButtonHoverIcon()
                        } else {
                            playButtonIcon.source = iconModel.playButtonHoverIcon()
                        }
                    }
                    onExited: 
                    {
                        if (playButton.playing) {
                            playButtonIcon.source = iconModel.pauseButtonIcon()
                        } else {
                            playButtonIcon.source = iconModel.playButtonIcon()
                        }
                    }
                    onClicked: 
                    {
                        if (audioPlayer.hasAudio || audioPlayer.hasVideo) {
                            if (playButton.playing) {
                                audioPlayer.pause()
                                playButtonIcon.source = iconModel.playButtonHoverIcon()
                            } else {                              
                                audioPlayer.play()
                                playButtonIcon.source = iconModel.pauseButtonHoverIcon()
                            }
                        }
                    }
                }
            }

            Image 
            {
                id: playButtonIcon
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                mipmap: true
                smooth: true
                anchors.margins: 4
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskPlayButtonIcon
                }
            }

            Rectangle 
            {
                id: maskPlayButtonIcon
                width: playButton.width
                height: playButton.height
                radius: 4
                visible: false
            }
        }
        
        ToolButton 
        {
            id: stopButton
            anchors.left: playButton.right
            width: sizeButton
            height: sizeButton

            background: Item 
            {
                Rectangle 
                {
                    id: stopButtonBackground
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "transparent"
                }

                MouseArea 
                {
                    id: stopButtonMouseArea
                    anchors.fill: stopButtonBackground
                    hoverEnabled: true

                    onEntered: 
                    {
                        stopButtonIcon.source = iconModel.stopButtonHoverIcon()
                    }
                    onExited: 
                    {
                        stopButtonIcon.source = iconModel.stopButtonIcon()
                    }
                    onClicked: 
                    {
                        if (audioPlayer.hasAudio || audioPlayer.hasVideo) {
                            audioPlayer.stop()
                        }
                    }
                    
                }
            }

            Image 
            {
                id: stopButtonIcon
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                mipmap: true
                smooth: true
                anchors.margins: 4
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskStopButtonIcon
                }
            }

            Rectangle 
            {
                id: maskStopButtonIcon
                width: stopButton.width
                height: stopButton.height
                radius: 4
                visible: false
            }
        }
    }

    Item 
    {
        id: currentDurationLabelItem
        anchors.left: controlsItem.right
        anchors.bottom: parent.bottom
        width: 60
        height: parent.height
        anchors.bottomMargin: 2

        Item 
        {
            id: currentDuration
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: sizeButton / 2 - 7

            Label 
            {
                id: labelDurationCurrent
                color: "#f1f1f1"
                text: Scripts.leftJustified(audioPlayer.position / 1000) 
                anchors.left: parent.left
                anchors.leftMargin: 6
                width: 50
                font.bold: true
                font.pointSize: 10
                horizontalAlignment: Text.AlignRight
                height: 10 
            }
        }
    }

    Item 
    {
        id: durationItem
        anchors.left: currentDurationLabelItem.right
        anchors.right: totalDurationLabelItem.left
        anchors.bottom: parent.bottom
        height: parent.height

        Slider 
        {
            id: sliderDurationAudio
            orientation: Qt.Horizontal
            anchors.left: parent.left
            anchors.right: parent.right
            handle: Rectangle 
            {
                x: sliderDurationAudio.visualPosition * (sliderDurationAudio.width - width)
                y: (sliderDurationAudio.height - height + 10) / 2
                width: 24
                height: 24
                radius: width * 0.5
                border.color: "#2997e5"

                gradient: Gradient 
                {
                    GradientStop 
                    {
                        position: 0.0
                        color: "#6DC3FF"
                    }
                    GradientStop
                    {
                        position: 1.0
                        color: "#2997e5"
                    }
                }
            }

            background: Rectangle 
            {
                y: (sliderDurationAudio.height - height + 10) / 2
                height: 12
                color: "#f2f2f2"
                radius: 24
                border.color: "#2997e5"
            }

            height: parent.height - 10
            anchors.leftMargin: 5
            anchors.rightMargin: 5
            from: 0
            to: audioPlayer.duration 
            value: audioPlayer.position 
            onMoved: 
            {
                audioPlayer.seek(value)
            }
        }
    }

    Item 
    {
        id: totalDurationLabelItem
        anchors.right: soundItem.left
        anchors.bottom: parent.bottom
        width: 60
        height: parent.height
        anchors.bottomMargin: 2

        Item 
        {
            id: totalDuration
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: sizeButton / 2 - 7

            Label 
            {
                id: labelDurationFull
                color: "#f1f1f1"
                text: Scripts.leftJustified(audioPlayer.duration / 1000)
                width: 50
                anchors.right: parent.right
                anchors.rightMargin: 2
                font.bold: true
                font.pointSize: 10
                height: 10 
                horizontalAlignment: Text.AlignRight
                onTextChanged: 
                {
                    width = text.length * 6 + 2
                }
            }
        }
    }  

    Item 
    {
        id: soundItem
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        width: 140
        height: parent.height

        Slider 
        {
            id: soundSlider
            anchors.left: parent.left
            anchors.right: soundButton.left
            anchors.margins: 2
            orientation: Qt.Horizontal

            handle: Rectangle 
            {
                x: soundSlider.visualPosition * (soundSlider.width - width)
                y: (soundSlider.height - height + 10) / 2 
                color: "#fff"
                width: 20
                height: 20
                radius: width * 0.5
                border.color: "#2997e5"
            }

            background: Rectangle 
            {
                y: (soundSlider.height - height + 10) / 2
                height: 8
                color: "#f1f1f1"
                radius: 50
                border.color: "#2997e5"

                Rectangle 
                {
                    width: soundSlider.visualPosition * parent.width
                    height: parent.height
                    radius: 50
                    border.color: "#f1f1f1"

                    gradient: Gradient 
                    {
                        GradientStop 
                        {
                            position: 0.0
                            color: "#6DC3FF"
                        }
                        GradientStop 
                        {
                            position: 1.0
                            color: "#2997e5"
                        }
                    }
                }
            }

            height: parent.height - 10
            from: 0.0
            to: 1.0
            value: audioPlayer.volume

            onValueChanged: 
            {
                audioPlayer.volume = value
                if (value === 0 && soundButton.soundCurrentValue > 0.0) {
                    soundButton.muted()
                    audioPlayer.volume = 0.0
                } else {                  
                    soundButton.raise()
                    soundButton.soundCurrentValue = value
                }
            }
        }

        ToolButton 
        {
            property real soundCurrentValue: 0.0
            signal muted
            signal raise

            id: soundButton
            width: sizeButton
            height: sizeButton
            anchors.right: parent.right

            onMuted: 
            {
                soundButtonIcon.source = iconModel.mutedSoundButtonIcon()
            }
            onRaise: 
            {
                if (iconModel != null)
                    soundButtonIcon.source = iconModel.soundButtonIcon()
            }

            background: Item 
            {
                Rectangle 
                {
                    id: soundButtonBackground
                    anchors.fill: parent
                    color: "transparent"
                    border.color: "transparent"
                }

                MouseArea
                {
                    id: soundButtonMouseArea
                    anchors.fill: soundButtonBackground
                    hoverEnabled: true

                    onEntered: 
                    {
                        if (soundSlider.value === 0.0) {
                            soundButtonIcon.source = iconModel.soundButtonHoverIcon()
                        } else {
                            soundButtonIcon.source = iconModel.mutedSoundButtonHoverIcon()
                        }
                    }
                    onExited: 
                    {
                        if (soundSlider.value === 0.0) {
                            soundButtonIcon.source = iconModel.mutedSoundButtonIcon()
                        } else {
                            soundButtonIcon.source = iconModel.soundButtonIcon() 
                        }
                    }
                    onClicked: 
                    {
                        if (savedSoundValue === 0.0) {
                            savedSoundValue = soundSlider.value
                            soundSlider.value = 0.0
                            soundButtonIcon.source = iconModel.soundButtonHoverIcon()
                        } else {
                            soundSlider.value = savedSoundValue
                            savedSoundValue = 0.0
                            soundButtonIcon.source = iconModel.mutedSoundButtonHoverIcon()
                        }
                    }
                }
            }

            Image 
            {
                id: soundButtonIcon
                anchors.fill: parent
                fillMode: Image.PreserveAspectFit
                mipmap: true
                smooth: true
                anchors.margins: 4
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskSoundButtonIcon
                }
            }

            Rectangle 
            {
                id: maskSoundButtonIcon
                width: soundButton.width
                height: soundButton.height
                radius: 4
                visible: false
            }
        }
    }
}