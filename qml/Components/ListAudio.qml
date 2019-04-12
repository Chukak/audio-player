import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
import QtQuick.Layouts 1.12


Rectangle
{
    property int mainWidth: parent.width
    property int mainHeight: parent.height
    property QtObject listModels: null
    property QtObject iconModel: null
    property var previousItems: [ null, null, null, null ]
    property double itemHeight: 50
    property int selectedIndex: -1
    signal filled
    signal setIcons
    signal addAudio
    
    id: listAudioModels
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: mainWidth

    onSetIcons:
    {
        addTrackIcon.source = iconModel.addTrackButtonIcon()
    }
    onAddAudio:
    {
        // TODO: better replace to .append()
        listViewModel.model = Net.toListModel(listModels.audioModels())
        listViewModel.currentIndex = listViewModel.count - 1
    }

    Gradient 
    {
        id: gradientItemDelegate
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

    Gradient
    {
        id: gradientHoverItemDelegate
        GradientStop
        {
            color: "#f2f2f2"
            position: 0.0
        }
        GradientStop
        {
            color: "#f4f4f4"
            position: 1.0
        }
    }

    Item 
    {
        id: itemAddTrack

        Rectangle 
        {
            height: itemHeight
            width: mainWidth
            gradient: gradientItemDelegate

            MouseArea
            {
                id: itemAddTrackMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onEntered:
                {
                    parent.gradient = gradientHoverItemDelegate
                    addTracKText.color = "#2E2E2D"
                    addTrackIcon.source = iconModel.addTrackButtonHoverIcon()
                }
                onExited:
                {
                    parent.gradient = gradientItemDelegate
                    addTracKText.color = "#f1f1f1"
                    addTrackIcon.source = iconModel.addTrackButtonIcon()
                }
                onClicked:
                {
                    audioFileDialog.selectExisting = true
                    audioFileDialog.open();
                }
            }

            Text 
            {
                id: addTracKText
                width: parent.width - itemHeight
                height: itemHeight
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.leftMargin: 4.5
                anchors.rightMargin: 1.5
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                elide: Text.ElideRight
                color: "#f1f1f1"
                text: "Add track"
                font 
                { 
                    weight: Font.Light
                    family: "Times"; 
                    pixelSize: 28; 
                    capitalization: Font.SmallCaps
                }
            }

            Image 
            {
                id: addTrackIcon
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                height: itemHeight - 3
                width: itemHeight - 3
                mipmap: true
                smooth: true
                anchors.margins: 3
                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: maskAddTrackIcon
                }
            }

            Rectangle
            {
                id: maskAddTrackIcon
                width: addTrackIcon.width
                height: addTrackIcon.height
                radius: 4
                visible: false
            }
        }
    }
    
    Page 
    {
        id: listPageId
        anchors.fill: parent
        header: itemAddTrack
        background: Rectangle 
        {
            gradient: Gradient 
            {
                GradientStop
                {
                    color: "#2E2E2D" 
                    position: 0.0
                }
                GradientStop
                {
                    color: "#2E2E2D" 
                    position: 0.10
                }
                GradientStop
                {
                    color: "#40403E" 
                    position: 0.16
                }
                GradientStop
                {
                    color: "#40403E" 
                    position: 0.92
                }
                GradientStop
                {
                    color: "#2E2E2D" 
                    position: 1.0
                }
            }
        }

        ListView 
        {
            id: listViewModel
            anchors.fill: parent
            anchors.topMargin: itemHeight
            delegate: itemDelegateId
            highlightFollowsCurrentItem: true
            highlightMoveDuration: 1000
            highlightMoveVelocity: -1
            cacheBuffer: 5000 // max 1000 delegates with 50px height
            ScrollBar.vertical: ScrollBar 
            {
                interactive: false
                stepSize: 0.1
                size: 20
            }
        }

        Component
        {
            id: itemDelegateId

            Rectangle 
            {
                id: itemDelegateArea
                height: itemHeight
                anchors.left: parent.left
                anchors.right: parent.right

                ColumnLayout 
                {
                    anchors.fill: parent

                    RowLayout 
                    {
                        id: upLayoutId
                        Layout.alignment: Qt.AlignTop 

                        Rectangle 
                        {
                            id: signerNameArea
                            width: mainWidth - durationNameArea.width - 15 // ~214px
                            height: itemHeight / 2 - 7 // 18 px
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            Layout.maximumWidth: width
                            Layout.fillWidth: false
                            anchors.margins: 2
                            color: "transparent"
                            layer.enabled: true

                            Text 
                            {
                                id: singerName
                                width: parent.width - 6
                                anchors.leftMargin: 4.5
                                anchors.rightMargin: 1.5
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.NoWrap
                                textFormat: Text.PlainText
                                color: "#f1f1f1"
                                text: modelData.getSingerName()
                                font 
                                { 
                                    weight: Font.Light
                                    family: "Times"; 
                                    pixelSize: 16; 
                                    capitalization: Font.SmallCaps
                                }

                                TextMetrics 
                                {
                                    id: singerNameTextMetrics
                                    font: singerName.font
                                    text: singerName.text
                                    elideWidth: parent.width
                                }

                                NumberAnimation on x
                                {
                                    property bool forward: false 
                                    id: animateSingerName
                                    from: -1 * (singerNameTextMetrics.boundingRect.width - singerName.width)
                                    to: 0
                                    loops: singerName.width < singerNameTextMetrics.boundingRect.width ? 1 : 0
                                    duration: 5000

                                    onFinished:
                                    {
                                        from = forward ? -1 * (singerNameTextMetrics.boundingRect.width - singerName.width) : 0 
                                        to = !forward ? -1 * (singerNameTextMetrics.boundingRect.width - singerName.width) : 0
                                        forward = !forward
                                        pauseAnimateSingerName.start()
                                    }
                                }

                                PauseAnimation 
                                {
                                    id: pauseAnimateSingerName
                                    duration: 3000

                                    onFinished: 
                                    {
                                        animateSingerName.start()
                                    }
                                }
                            }
                        }

                        Rectangle 
                        {
                            id: durationNameArea
                            width: durationNameTextMetrics.width + 15 // ~71px
                            height: itemHeight / 2 - 7 // 18px
                            Layout.alignment: Qt.AlignRight 
                            anchors.topMargin: 2
                            anchors.bottomMargin: 2
                            anchors.rightMargin: 2
                            anchors.leftMargin: 6
                            color: "transparent"

                            Text 
                            {
                                id: durationName
                                width: parent.width
                                anchors.leftMargin: 1.5
                                anchors.rightMargin: 1.5 // scrollbar pixel
                                horizontalAlignment: Text.AlignRight
                                wrapMode: Text.NoWrap
                                clip: true
                                elide: Text.ElideRight
                                color: "#f1f1f1"
                                text: modelData.getDuration()
                                font 
                                { 
                                    weight: Font.Light
                                    family: "Times"; 
                                    pixelSize: 16; 
                                    capitalization: Font.SmallCaps
                                }

                                TextMetrics 
                                {
                                    id: durationNameTextMetrics
                                    font: durationName.font
                                    text: durationName.text
                                }
                            }
                        }
                    }

                    RowLayout
                    {
                        id: lowerLayoutId
                        Layout.alignment: Qt.AlignBottom
                        layer.enabled: true

                        Rectangle 
                        {
                            id: audioNameArea
                            width: mainWidth
                            height: itemHeight / 2 + 7 // 32 px
                            Layout.alignment: Qt.AlignCenter | Qt.AlignBottom
                            Layout.maximumWidth: width
                            Layout.fillWidth: false
                            anchors.margins: 2
                            color: "transparent"
                            
                            Text
                            {
                                id: songName
                                width: parent.width - 6
                                anchors.leftMargin: 1.5
                                anchors.rightMargin: 4.5
                                wrapMode: Text.NoWrap
                                textFormat: Text.PlainText
                                color: "#f1f1f1"
                                text: modelData.getSongName()
                                font 
                                { 
                                    weight: Font.Light
                                    family: "Times"; 
                                    pixelSize: 18; 
                                    capitalization: Font.SmallCaps
                                }

                                TextMetrics 
                                {
                                    id: songNameTextMetrics
                                    font: songName.font
                                    text: songName.text
                                    elideWidth: parent.width
                                }

                                NumberAnimation on x
                                {
                                    property bool forward: false 
                                    id: animateSongName
                                    from: -1 * (songNameTextMetrics.boundingRect.width - songName.width)
                                    to: 0
                                    loops: songName.width < songNameTextMetrics.boundingRect.width ? 1 : 0
                                    duration: 5000

                                    onFinished:
                                    {
                                        from = forward ? -1 * (songNameTextMetrics.boundingRect.width - songName.width) : 0 
                                        to = !forward ? -1 * (songNameTextMetrics.boundingRect.width - songName.width) : 0
                                        forward = !forward
                                        pauseAnimateSongName.start()
                                    }
                                }

                                PauseAnimation 
                                {
                                    id: pauseAnimateSongName
                                    duration: 3000

                                    onFinished: 
                                    {
                                        animateSongName.start()
                                    }
                                }
                            } 
                        }
                    }
                }

                gradient: gradientItemDelegate

                MouseArea 
                {
                    id:itemDelegateMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:
                    {
                        gradient = gradientHoverItemDelegate
                        songName.color = durationName.color = singerName.color = "#2E2E2D"
                    }
                    onExited:
                    {
                        if (selectedIndex != index) {
                            gradient = gradientItemDelegate
                            songName.color = durationName.color = singerName.color = "#f1f1f1"
                        } else {
                            gradient = gradientHoverItemDelegate
                            songName.color = durationName.color = singerName.color = "#2997e5"
                        }
                    }
                    onClicked: 
                    {
                        if (selectedIndex != -1 && selectedIndex != index) {
                            previousItems[0].gradient = gradientItemDelegate
                            for (var i = 1; i < 4; ++i) {
                                previousItems[i].color = "#f1f1f1"
                            } 
                        }

                        previousItems[0] = parent // delegate
                        previousItems[1] = songName // Text
                        previousItems[2] = singerName // Text
                        previousItems[3] = durationName // Text
                        
                        selectedIndex = index
                        gradient = gradientHoverItemDelegate
                        songName.color = durationName.color = singerName.color = "#2997e5"
                        audioPlayer.source = modelData.getPath()
                        audioPlayer.play()
                    }
                }
            }
        }
    }

    onFilled: 
    {
        listViewModel.model = Net.toListModel(listModels.audioModels())
    }
}
