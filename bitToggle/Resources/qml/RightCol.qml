import QtQuick 2.0
import QtQuick.Layouts 1.2
import "bitBlockCreation.js" as BitBlockCreatorScript
import "bitBlockReorder.js" as BitBlockReorderScript
Item {
    id: rightCol
    anchors.top: parent.top
    anchors.topMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 960
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.right: leftCol.left
    anchors.rightMargin: -1920

    function addButtonClicked (pattern, freq, time){
        BitBlockCreatorScript.createBitBlock(pattern, freq, time);
    }
    function deleteBlockClicked (){
        if (root.lastElementClicked)
            root.lastElementClicked.destroy();
        fullCycleDisplay.setByte(0);
    }
    function dragFinished (block) {
        BitBlockReorderScript.sort(rCol.children, block);
    }

    Column {
        id: rCol
        objectName: "rCol"
        x: 192
        width: parent.width * .7
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        spacing: 3

    }

    DropArea {
        anchors.fill: parent
    }

    FullCycleDisplay {
        id: fullCycleDisplay
        width: parent.width * .3
        height: parent.height
        anchors.left: parent.left
        anchors.leftMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
    }
}
