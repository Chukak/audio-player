import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Rectangle
{
    property int mainWidth: parent.width
    property QtObject listModels: null
    signal filled
    
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: mainWidth
    color: "gray"

    
    Page 
    {
        anchors.fill: parent

        ListView 
        {
            id: listViewModel
            anchors.fill: parent
            delegate: itemDelegateId
            highlightFollowsCurrentItem: false
            ScrollBar.vertical: ScrollBar 
            {
            }
        }


        Component 
        {
            id: itemDelegateId

            Rectangle 
            {
                property double itemHeight: 50
                property int titleTextSize: 32
                property int columnLayoutLeftMargin: 0
                property string borderColor: "black"

                height : itemHeight
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
                            width: mainWidth - mainWidth / 3
                            height: itemHeight / 2 - 7 // 18 px
                            Layout.alignment: Qt.AlignLeft | Qt.AlignTop
                            anchors.margins: 2
                            color: "transparent"

                            Text 
                            {
                                id: singerName
                                width: parent.width - 6
                                anchors.leftMargin: 4.5
                                anchors.rightMargin: 1.5
                                horizontalAlignment: Text.AlignLeft
                                wrapMode: Text.NoWrap
                                clip: true
                                elide: Text.ElideRight
                                color: "#f1f1f1"
                                text: modelData.getSingerName()
                                font 
                                { 
                                    weight: Font.Light
                                    family: "Times"; 
                                    pixelSize: 16; 
                                    capitalization: Font.SmallCaps
                                }
                            }
                        }

                        Rectangle 
                        {
                            id: durationNameArea
                            width: mainWidth - mainWidth / 3 * 2
                            height: itemHeight / 2 - 7 // 18px
                            Layout.alignment: Qt.AlignRight | Qt.AlignTop
                            anchors.margins: 2
                            color: "transparent"

                            Text 
                            {
                                id: durationName
                                width: parent.width - 15
                                anchors.leftMargin: 1.5
                                anchors.rightMargin: 13.5 // scrollbar pixel
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
                            }
                        }
                    }

                    RowLayout
                    {
                        id: lowerLayoutId
                        Layout.alignment: Qt.AlignBottom

                        Rectangle 
                        {
                            id: audioNameArea
                            width: mainWidth
                            height: itemHeight / 2 + 7 // 32 px
                            Layout.alignment: Qt.AlignCenter | Qt.AlignBottom
                            anchors.margins: 2
                            color: "transparent"

                            Text 
                            {
                                id: songName
                                width: parent.width - 6
                                anchors.leftMargin: 1.5
                                anchors.rightMargin: 4.5
                                wrapMode: Text.NoWrap
                                clip: true
                                elide: Text.ElideRight
                                color: "#f1f1f1"
                                text: modelData.getSongName()
                                font 
                                { 
                                    weight: Font.Light
                                    family: "Times"; 
                                    pixelSize: 18; 
                                    capitalization: Font.SmallCaps
                                }
                            } 
                        }
                    }
                }

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
            }
        }
    }

    onFilled: 
    {
        listViewModel.model = Net.toListModel(listModels.audioModels())
    }
}
