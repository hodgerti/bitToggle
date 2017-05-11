function createBitBlock(color) {
    var comp = Qt.createComponent("bitBlockDef.qml");
    var sprite = comp.createObject(block1,
                                   {"color" : color});

    if (sprite === null) {
        // Error Handling
        console.log("Error creating object");
    }
}
