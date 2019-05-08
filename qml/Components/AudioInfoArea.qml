import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtGraphicalEffects 1.12
import AudioModel 0.1
import "../../js/controls.js" as Scripts


Rectangle
{
    property QtObject iconModel: null
    property int infoColumnTopHeight: 70
    property int textPixelSize: 30
    signal selected(QtObject audioModel)

    id: audioInfo

    onSelected:
    {
        singerName.text = audioModel.getSingerName()
        albumName.text = audioModel.getAlbum() + (audioModel.hasYear() ? " (" + audioModel.getYear() + ") " : "")
        audioName.text = audioModel.getSongName()
        console.log(Scripts.startAnimation(singerName.width, singerNameTextMetrics.boundingRect.width))
        Scripts.restartAnimation(animateSingerName, singerName.width, singerNameTextMetrics.boundingRect.width)
        Scripts.restartAnimation(animateAlbumName, albumName.width, albumNameTextMetrics.boundingRect.width)
        Scripts.restartAnimation(animateAudioName, audioName.width, audioNameTextMetrics.boundingRect.width)
        selectedAudioImage.source = audioModel.hasImage() ? audioModel.getImage() : iconModel.defaultTrackIcon()
    }

    Gradient 
    {
        id: rowBackground
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

    Item 
    {
        id: itemPage
        anchors.fill: parent

        Rectangle
        {
            id: topColumn
            anchors.fill: parent
            color: "#f1f1f1"

            ColumnLayout
            {
                id: topLayout
                anchors.fill: parent
                spacing: 1

                RowLayout
                {
                    id: rowLayoutTopId
                    Layout.alignment: Qt.AlignTop
                    spacing: 1

                    Rectangle
                    {
                        id: signerNameArea
                        height: infoColumnTopHeight
                        Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                        Layout.fillWidth: true
                        anchors.margins: 2
                        layer.enabled: true
                        gradient: rowBackground

                        Text
                        {
                            id: singerName
                            width: parent.width - 4
                            height: parent.height
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            horizontalAlignment: singerName.width < singerNameTextMetrics.boundingRect.width ? Text.AlignLeft : Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.NoWrap
                            textFormat: Text.PlainText
                            color: "#f1f1f1"
                            text: ""
                            font
                            {
                                weight: Font.Light
                                family: "Times";
                                pixelSize: textPixelSize;
                                capitalization: Font.SmallCaps
                            }

                            TextMetrics
                            {
                                id: singerNameTextMetrics
                                font: singerName.font
                                text: singerName.text
                                elideWidth: parent.width
                            }

                            XAnimator on x
                            {
                                property bool forward: false
                                id: animateSingerName
                                duration: 5000

                                onFinished:
                                {
                                    from = !forward ? -1 * (singerNameTextMetrics.boundingRect.width - singerName.width) : 0
                                    to = forward ? -1 * (singerNameTextMetrics.boundingRect.width - singerName.width) : 0
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
                        id: albumNameArea
                        height: infoColumnTopHeight
                        Layout.alignment: Qt.AlignRight | Qt.AlignTop
                        Layout.fillWidth: true
                        anchors.margins: 2
                        layer.enabled: true
                        gradient: rowBackground

                        Text
                        {
                            id: albumName
                            width: parent.width - 4
                            height: parent.height
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            horizontalAlignment: albumName.width < albumNameTextMetrics.boundingRect.width ? Text.AlignLeft : Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.NoWrap
                            textFormat: Text.PlainText
                            color: "#f1f1f1"
                            text: ""
                            font
                            {
                                weight: Font.Light
                                family: "Times";
                                pixelSize: textPixelSize;
                                capitalization: Font.SmallCaps
                            }

                            TextMetrics
                            {
                                id: albumNameTextMetrics
                                font: albumName.font
                                text: albumName.text
                                elideWidth: parent.width
                            }

                            XAnimator on x
                            {
                                property bool forward: false
                                id: animateAlbumName
                                duration: 5000

                                onFinished:
                                {
                                    from = !forward ? -1 * (albumNameTextMetrics.boundingRect.width - albumName.width) : 0
                                    to = forward ? -1 * (albumNameTextMetrics.boundingRect.width - albumName.width) : 0
                                    forward = !forward
                                    pauseAnimateAlbumName.start()
                                }
                            }

                            PauseAnimation
                            {
                                id: pauseAnimateAlbumName
                                duration: 3000

                                onFinished:
                                {
                                    animateAlbumName.start()
                                }
                            }
                        }
                    }
                }
                RowLayout
                {
                    id: rowLayoutTopMiddleId
                    Layout.alignment: Qt.AlignHCenter

                    Rectangle
                    {
                        id: audioTitleArea
                        height: infoColumnTopHeight
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignTop
                        Layout.fillWidth: true
                        layer.enabled: true
                        gradient: rowBackground

                        Text
                        {
                            id: audioName
                            width: parent.width - 4
                            height: parent.height
                            anchors.leftMargin: 2
                            anchors.rightMargin: 2
                            horizontalAlignment: audioName.width < audioNameTextMetrics.boundingRect.width ? Text.AlignLeft : Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            wrapMode: Text.NoWrap
                            textFormat: Text.PlainText
                            color: "#f1f1f1"
                            text: ""
                            font
                            {
                                weight: Font.Light
                                family: "Times";
                                pixelSize: textPixelSize;
                                capitalization: Font.SmallCaps
                            }

                            TextMetrics
                            {
                                id: audioNameTextMetrics
                                font: audioName.font
                                text: audioName.text
                                elideWidth: parent.width
                            }

                            XAnimator on x
                            {
                                property bool forward: false
                                id: animateAudioName
                                duration: 5000

                                onFinished:
                                {
                                    from = !forward ? -1 * (audioNameTextMetrics.boundingRect.width - audioName.width) : 0
                                    to = forward ? -1 * (audioNameTextMetrics.boundingRect.width - audioName.width) : 0
                                    forward = !forward
                                    pauseAnimateAudioName.start()
                                }
                            }

                            PauseAnimation
                            {
                                id: pauseAnimateAudioName
                                duration: 3000

                                onFinished:
                                {
                                    animateAudioName.start()
                                }
                            }
                        }
                    }
                }
                RowLayout
                {
                    id: rowLayoutMiddleId
                    Layout.alignment: Qt.AlignHCenter 

                    Rectangle
                    {
                        id: audioImageArea
                        Layout.alignment: Qt.AlignVCenter | Qt.AlignTop
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        anchors.margins: 2
                        gradient: rowBackground

                        Image
                        {
                            id: selectedAudioImage
                            anchors.fill: parent
                            fillMode: Image.PreserveAspectFit
                            mipmap: true
                            anchors.margins: 4
                            source: iconModel.defaultTrackIcon()
                            layer.enabled: true
                            layer.effect: OpacityMask {
                                maskSource: Rectangle {
                                    width: audioTitleArea.width
                                    height: audioTitleArea.height
                                    radius: 16
                                    visible: true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}