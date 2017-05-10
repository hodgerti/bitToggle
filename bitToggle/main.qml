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
    property var on_off: [255,0]


    signal write
    signal close
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
