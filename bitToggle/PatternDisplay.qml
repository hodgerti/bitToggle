import QtQuick 2.0

Row {
    id: display
    width: leftCol.width
    height: leftCol.width / 8
    property string offColor: "#ffff99"
    property string onColor: "#0099ff"
    Repeater {
        id: repeater
        model: 8
        Rectangle {
            width: parent.width / 8
            height: parent.height
            color: parent.offColor
            border.width: 10
            border.color: "silver"
        }
    }
    //freqSelect.text
    Timer {
        id: variClock
        interval: parseInt(1000/(freqSelect.text) * (freqSelect.text).length)
        running: true
        repeat: true
        onTriggered: {

        }
    }

    Text { id: time }
}
