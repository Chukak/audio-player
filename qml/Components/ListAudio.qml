import QtQuick 2.12
import QtQuick.Controls 2.12


Rectangle
{
    property QtObject listModels: null
    signal filled
    
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.right: parent.right
    anchors.bottom: parent.bottom
    width: parent.width
    color: "gray"

    
    Column
    {
        width: 200

        Repeater 
        {
            id: repeater
            delegate: Text 
            {
                text: modelData.getTitle()
            }

            onItemAdded: 
            {
                console.log("add")
            }
        }
    }

    onFilled: 
    {
        repeater.model = Net.toListModel(listModels.audioModels())
    }
}
