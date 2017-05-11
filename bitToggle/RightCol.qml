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

    Column {
        id: rCol
        x: 0
        y: 0

        spacing: 5

        Rectangle {
            id: block1
            width: rightCol.width
            height: 300

            Component.onCompleted:{
                BitBlockCreatorScript.createBitBlock("red");
            }
        }
    }
}
