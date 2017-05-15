import QtQuick 2.0
import QtQuick.Window 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.2
import QtQuick.Controls.Material 2.0


Item {
    id: root
    objectName: "root"
    Material.theme: Material.Dark


    property string pattern: "None"
    property var snake: [0,1,2,4,8,16,32,64,128]
    property var alt_flash: [85,170]
    property var on_off: [0,255]
    property var lastElementClicked

    signal entryFormChanged()
    signal deleteBlockClicked()
    signal addBlockClicked(string pattern, double freq, double time)
    signal flashClicked()

    Component.onCompleted: {
        root.addBlockClicked.connect(rightCol.addButtonClicked);
        root.deleteBlockClicked.connect(rightCol.deleteBlockClicked);
    }



    x: 0
    y: 0
    width: 1920
    height: 1080

    LeftCol {
        id: leftCol
    }

    RightCol {
        id: rightCol
    }
}
