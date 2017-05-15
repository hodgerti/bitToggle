import QtQuick 2.0

Rectangle {
    id: block
    x: parent.width/2
    height: 100
    width: 100
    color: (block === root.lastElementClicked) ? "#ff9966" : "#C0E6ED"
    border.width: 2
    border.color: "#edc7c0"
    property string p
    property double f
    property double t

    MouseArea {
        anchors.fill: parent
        onClicked: {
            root.lastElementClicked = block;
        }
    }
    Text {
        id: pattern
        width: parent.width
        height: parent.height/3
        text: block.p
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Courier"
        font.capitalization: Font.SmallCaps
        color: "black"
    }
    Text {
        id: frequency
        width: parent.width
        height: parent.height/3
        text: ((block.f).toFixed(4)).toString()
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 33
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Courier"
        font.capitalization: Font.SmallCaps
        color: "black"
    }
    Text {
        id: time
        width: parent.width
        height: parent.height/3
        text: ((block.t).toFixed(4)).toString()
        anchors.top: parent.top
        anchors.topMargin: 67
        anchors.left: parent.left
        anchors.leftMargin: 0
        font.pixelSize: 12
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.family: "Courier"
        font.capitalization: Font.SmallCaps
        color: "black"
    }


}
