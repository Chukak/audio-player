
// ControlsButtons functions

function leftJustified(number)
{
    var hour = Math.floor(number / 3600) % 60
    var minutes = Math.floor(number / 60) % 60
    var seconds =  Math.round(number % 60)
    var result = "";
    if (hour > 0) {
        result += hour >= 10 ? hour.toString() : "0" + hour.toString()
    } else {
        result += "00"
    }
    result += ":"
    if (minutes > 0) {
        result += minutes >= 10 ? minutes.toString() : "0" + minutes.toString()
    } else {
        result += "00"
    }
    result += ":"
    if (seconds > 0) {
        result += seconds >= 10 ? seconds.toString() : "0" + seconds.toString()
    } else {
        result += "00"
    }
    return result
}
