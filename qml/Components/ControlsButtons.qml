import QtQuick 2.12
import QtQuick.Controls 2.12
import "../../js/controls.js" as Scripts

Rectangle 
{
    property real savedSoundValue: 0.0
    property int sizeButton: height - 10
    signal playAudio
    signal pauseAudio
    signal stopAudio

    id: controls
     
    anchors.leftMargin: 0
    anchors.rightMargin: 0

    gradient: Gradient 
    {
        GradientStop
        {
            color: "#40403E" // "#f3f3f3" 51524F
            position: 0.0
        }
        GradientStop
        {
            color: "#2E2E2D" // "#f3f3f3" 
            position: 1.0
        }
    }

    onPlayAudio: 
    {
        // todo
    }
    onPauseAudio: 
    {
        // todo
    }
    onStopAudio:
    {
        // todo
    }

    Item 
    {
        id: controlsItem
        anchors.left: parent.left
        width: 80
        height: parent.height

        ToolButton 
        {
            property bool playing: false
            signal stop
            
            id: playButton
            anchors.left: parent.left
            width: sizeButton
            height: sizeButton

            onStop: 
            {
                // todo: icon button
            }

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
                        Scripts.mouseAreaEntered(playButtonBackground)
                    }
                    onExited: 
                    {
                        Scripts.mouseAreaExited(playButtonBackground)
                    }
                    onClicked: 
                    {
                        if (audioPlayer.hasAudio || audioPlayer.hasVideo) {
                            if (playButton.playing) {
                                // todo
                            } else {
                                // todo
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
                anchors.margins: 0
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
                        Scripts.mouseAreaEntered(stopButtonBackground)
                    }
                    onExited: 
                    {
                        Scripts.mouseAreaExited(stopButtonBackground)
                    }
                    onClicked: 
                    {
                        if (audioPlayer.hasAudio || audioPlayer.hasVideo) {
                            // todo
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
                anchors.margins: 6
            }
        }
    }

    Item 
    {
        id: durationItem
        anchors.left: controlsItem.right
        anchors.right: durationLabelItem.left
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
                y: (sliderDurationAudio.height - height) / 2
                color: "#fff"
                width: 20
                height: 20
                radius: width * 0.5
                border.color: "#2997e5"//"#8f8f8f"
            }

            background: Rectangle 
            {
                y: (sliderDurationAudio.height - height) / 2
                height: 10
                color: "#f2f2f2" //"#f2f2f2"
                radius: 20
                border.color: "#2997e5"

                Rectangle 
                {
                    y: sliderDurationAudio.vidualPosition * parent.width
                    height: parent.height
                    color: "#f2f2f2"
                    border.color: "#f1f1f1"//"#8f8f8f"

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
        id: durationLabelItem
        anchors.right: soundItem.left
        anchors.bottom: parent.bottom
        width: 130
        height: parent.height
        anchors.bottomMargin: 2

        Item 
        {
            id:labelsDuration
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.topMargin: sizeButton / 2 - 7

            Label 
            {
                id: labelDurationCurrent
                color: "#f1f1f1"
                text: "00:00:00" //"<font color=\"white\">00:00:00</font>" // todo
                anchors.left: parent.left
                anchors.leftMargin: 6
                width: 50
                font.bold: true
                font.pointSize: 10
                horizontalAlignment: Text.AlignRight
                height: 10 
                onTextChanged: 
                {
                    width = text.length * 6 + 2
                }
            }

            Label 
            {
                id: labelDurationSeparator
                color: "#f1f1f1"
                text: "/"
                anchors.left: labelDurationCurrent.right
                anchors.leftMargin: 0
                width: 10
                font.bold: true
                font.pointSize: 10
                horizontalAlignment: Text.AlignRight
                height: 10 
            }

            Label 
            {
                id: labelDurationFull
                color: "#f1f1f1"
                text: "10:00:00"
                width: 50
                anchors.left: labelDurationSeparator.right
                anchors.leftMargin: 2
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
                y: (soundSlider.height - height) / 2
                color: "#fff"
                width: 20
                height: 20
                radius: width * 0.5
                border.color: "#2997e5"//"#8f8f8f"
            }

            background: Rectangle 
            {
                y: (soundSlider.height - height) / 2
                height: 8
                color: "#f1f1f1"
                radius: 50
                border.color: "#2997e5"

                Rectangle 
                {
                    width: soundSlider.visualPosition * parent.width
                    height: parent.height
                    radius: 50
                    border.color: "#f1f1f1"//"#8f8f8f"

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

            onMoved: 
            {
                audioPlayer.volume = value
            }
            onValueChanged: 
            {
                if (value === 0 && soundButton.soundCurrentValue > 0.0) {
                    soundButton.muted()
                    audioPlayer.volume = 0.0
                } else {
                    soundButton.raise()
                    soundButton.soundCurrentValue = value
                    audioPlayer.volume = value
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
                // todo
            }
            onRaise: 
            {
                // todo
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
                        Scripts.mouseAreaEntered(soundButtonBackground)
                    }
                    onExited: 
                    {
                        Scripts.mouseAreaExited(soundButtonBackground)
                    }
                    onClicked: 
                    {
                        if (savedSoundValue === 0.0) {
                            savedSoundValue = soundSlider.value
                            soundSlider.value = 0.0
                            // todo
                        } else {
                            soundSlider.value = savedSoundValue
                            savedSoundValue = 0.0
                            // todo
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
                anchors.margins: 6
            }
        }
    }
}