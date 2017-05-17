import QtQuick 2.0

Column {
    id: fullCycleDisplay
    property string offColor: "#ffff99"
    property string onColor: "#0099ff"

    property var bitBlockList: rCol.children
    property var bitBlockEle

    Repeater {
        id: repeater2
        model: 8
        Rectangle {
            x: (rightCol.width * .15)
            width: rightCol.width * .12
            height: rightCol.width * .12
            color: parent.offColor
            border.width: 10
            border.color: "silver"
        }
    }

    function setByte(_num){
        var num = _num;
        for (var i = 0;i < 8;i++){
            repeater2.itemAt(i).color = fullCycleDisplay.offColor;
        }

        while(true) {

            if (num > 127){
                repeater2.itemAt(0).color = fullCycleDisplay.onColor;
                num -= 128;
            }
            else if (num > 63){
                repeater2.itemAt(1).color = fullCycleDisplay.onColor;
                num -= 64;
            }
            else if (num > 31){
                repeater2.itemAt(2).color = fullCycleDisplay.onColor;
                num -= 32;
            }
            else if (num > 15){
                repeater2.itemAt(3).color = fullCycleDisplay.onColor;
                num -= 16;
            }
            else if (num > 7){
                repeater2.itemAt(4).color = fullCycleDisplay.onColor;
                num -= 8;
            }
            else if (num > 3){
                repeater2.itemAt(5).color = fullCycleDisplay.onColor;
                num -= 4;
            }
            else if (num > 1){
                repeater2.itemAt(6).color = fullCycleDisplay.onColor;
                num -= 2;
            }
            else if (num > 0){
                repeater2.itemAt(7).color = fullCycleDisplay.onColor;
                num -= 1;
            }
            else
                return;
        }

    }
    Timer {
        id: cycleClock
        property int bitBlockListLength: bitBlockList.length
        property int bitBlockIdx: 0
        running: true
        repeat: true
        function inter () {
            if (bitBlockEle){
                if (bitBlockEle.t > 0){
                    return 1000 * (bitBlockEle.t)
                }
            }
            return 80;
        }

        interval: inter()

        onTriggered: {
            if (bitBlockIdx < bitBlockListLength){
                if (bitBlockList[bitBlockIdx]){
                    bitBlockEle = bitBlockList[bitBlockIdx];
                }
                bitBlockIdx++;
            }
            else {
                bitBlockIdx = 0;
            }
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
        function inter() {
            if (bitBlockEle){
                if (bitBlockEle.f > 0){
                    return 1000/(bitBlockEle.f)
                }
            }
            return false;
        }

        interval: inter()

        running: true
        repeat: true
        onTriggered: {

            if (bitBlockEle) {
                variClock.list = variClock.patternSelecter(bitBlockEle.p);
                variClock.len = variClock.list.length;
                fullCycleDisplay.setByte(variClock.list[idx]);
                variClock.idx = variClock.idx + 1;
                if (variClock.idx >= variClock.len) variClock.idx = 0;
            }
            else {
                variClock.idx = 0;
            }
        }

    }

}
