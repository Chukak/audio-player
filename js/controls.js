
// ControlsButtons functions

function mouseAreaEntered(QmlObj)
{
    QmlObj.color = "#f2f2f2"
    QmlObj.border.color = "#8f8f8f"
    QmlObj.radius = 5
}

function mouseAreaExited(QmlObj)
{
    QmlObj.color = "transparent"
    QmlObj.border.color = "transparent"
    QmlObj.radius = 0
}

function addTextInsideFontTag(text)
{
    var result = "<font color=\"white\">" + text + "</font>"
    console.log(result)
    return result
}
