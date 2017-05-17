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

    function setByte(_num){
        var num = _num;
        for (var i = 0;i < 8;i++){
            repeater.itemAt(i).color = display.offColor;
        }

        while(true) {

            if (num > 127){
                repeater.itemAt(0).color = display.onColor;
                num -= 128;
            }
            else if (num > 63){
                repeater.itemAt(1).color = display.onColor;
                num -= 64;
            }
            else if (num > 31){
                repeater.itemAt(2).color = display.onColor;
                num -= 32;
            }
            else if (num > 15){
                repeater.itemAt(3).color = display.onColor;
                num -= 16;
            }
            else if (num > 7){
                repeater.itemAt(4).color = display.onColor;
                num -= 8;
            }
            else if (num > 3){
                repeater.itemAt(5).color = display.onColor;
                num -= 4;
            }
            else if (num > 1){
                repeater.itemAt(6).color = display.onColor;
                num -= 2;
            }
            else if (num > 0){
                repeater.itemAt(7).color = display.onColor;
                num -= 1;
            }
            else
                return;
        }

    }

    Timer {
        id: variClock
        property int idx: 0
        property int len: 1
        property var list

        function patternSelecter(pattern) {
            if (pattern === "alt-flash")
                return root.alt_flash;
            else if (pattern === "on-off")
                return root.on_off;
            else if (pattern === "snake")
                return root.snake;
            else {
                console.log("none selected: " + pattern);
                return;
            }
        }
        function inter () {
            if ((1000/ (parseFloat(freqSelect.text) * variClock.len)) > 0){
                return 1000/ (parseFloat(freqSelect.text) * variClock.len);
            }
            return false;
        }

        interval: inter()
        running: true
        repeat: true
        onTriggered: {
            variClock.list = variClock.patternSelecter(patternSelect.currentText);
            variClock.len = variClock.list.length;
            display.setByte(variClock.list[idx]);
            variClock.idx = variClock.idx + 1;
            if (variClock.idx >= variClock.len) variClock.idx = 0;
        }

    }

}
