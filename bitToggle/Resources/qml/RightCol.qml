import QtQuick 2.0
import QtQuick.Layouts 1.2
import "bitBlockCreation.js" as BitBlockCreatorScript
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
        root.lastElementClicked.destroy();
    }

    Column {
        id: rCol
        x: 192
        width: parent.width * .7
        height: parent.height
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0

        spacing: 3



    }
}
