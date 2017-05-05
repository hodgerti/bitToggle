import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.1

Item {
    id: root
    objectName: "root"
    property bool color: false
    signal write
    signal close
    x: 0
    y: 0
    width: 640
    height: 480
    Rectangle {
        id: rectangle
        color: root.color ? "red" : "blue"
        anchors.fill: parent
        MouseArea {
            anchors.fill: parent
            onClicked: {
                root.color = !root.color;
                root.write();
            }
        }
    }
}
