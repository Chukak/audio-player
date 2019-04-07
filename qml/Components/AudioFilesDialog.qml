import QtQuick 2.12
import QtQuick.Dialogs 1.3

FileDialog 
{
    id: fileDialog
    title: qsTr("Select file")
    nameFilters: [
        "mp3 (*.mp3)",
        "wav (*.wav)",
        "ogg (*.ogg)",
        "wma (*.wma)"
    ]
    onAccepted: 
    {
        if (fileDialog.selectExisting) {
            var path = fileUrl.toString()
            path = path.replace(/^.*(file:)/, "")
            if (listAudioModels.addAudioModel(path)) {
                listAudio.addAudio()
            }
        }
    }
}