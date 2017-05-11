import QtQuick 2.0
import QtQuick.Layouts 1.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls.Private 1.0
Item {
    id: leftCol
    anchors.right: rightCol.left
    anchors.rightMargin: 0
    anchors.left: parent.left
    anchors.leftMargin: 0
    anchors.bottom: parent.bottom
    anchors.bottomMargin: 0
    anchors.top: parent.top
    anchors.topMargin: 0

    Column {
        id: col
        x: 0
        y: 0

        spacing: 25

        ComboBox {
            id: patternSelect
            width: leftCol.width
            height: leftCol.height/12
            style: ComboBoxStyle {
                label: Text {
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pointSize: 60
                    font.family: "Courier"
                    font.capitalization: Font.SmallCaps
                    color: "black"
                    text: patternSelect.currentText
                }
                property Component __dropDownStyle: MenuStyle {
                    itemDelegate.label: Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 60
                        font.family: "Courier"
                        font.capitalization: Font.SmallCaps
                        color: "black"
                        text: styleData.text
                    }
                }
            }

            model: ["alt-flash", "snake", "on-off"]
            onAccepted: {
                root.pattern = patternSelect.currentText;
                root.entryFormChanged()
            }
        }
        //spacer
        Rectangle {
            height: 80
            width: leftCol.width
        }

        TextField {
            id: freqSelect
            font.pointSize: 60
            font.family: "Courier"
            font.capitalization: Font.AllLowercase
            placeholderText: "Frequency Select"
            width: leftCol.width
            validator: DoubleValidator{}
            onTextChanged: {
                root.entryFormChanged()
            }
        }

        TextField {
            id: timeSelect
            font.pointSize: 60
            font.family: "Courier"
            font.capitalization: Font.AllLowercase
            placeholderText: "Time Select"
            width: leftCol.width
            validator: DoubleValidator{}
        }
        //spacer
        Rectangle {
            height: 10
            width: leftCol.width
        }

        PatternDisplay {

        }
        //spacer
        Rectangle {
            height: 10
            width: leftCol.width
        }

        Rectangle {
            id: addDeleteButtons
            width: leftCol.width
            height: 50

            Button {
                id: deleteBlock
                width: addDeleteButtons.width/2
                height: 50
                text: qsTr("Delete Block")
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: addBlock.right
                anchors.leftMargin: 0
                style: ButtonStyle {
                    label: Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 60
                        font.family: "Courier"
                        font.capitalization: Font.SmallCaps
                        color: "black"
                        text: deleteBlock.text
                    }
                }
                onClicked: {
                    root.deleteBlockClicked();
                }
            }

            Button {
                id: addBlock
                width: addDeleteButtons.width/2
                height: 50
                text: qsTr("Add Block")
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.left: parent.left
                anchors.leftMargin: 0
                style: ButtonStyle {
                    label: Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 60
                        font.family: "Courier"
                        font.capitalization: Font.SmallCaps
                        color: "black"
                        text: addBlock.text
                    }
                }
                onClicked: {
                    root.addBlockClicked();
                }
            }
        }
        Rectangle {
            id: flashButtons
            width: leftCol.width
            height: 50

            Button {
                id: flashButton
                width: flashButtons.width
                height: 50
                text: qsTr("Flash Blocks")
                anchors.left: parent.left
                anchors.leftMargin: 0
                anchors.top: parent.top
                anchors.topMargin: 0
                style: ButtonStyle {
                    label: Text {
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                        font.pointSize: 60
                        font.family: "Courier"
                        font.capitalization: Font.SmallCaps
                        color: "black"
                        text: flashButton.text
                    }
                }
                onClicked: {
                    root.flashClicked();
                }
            }
        }
    }
}
