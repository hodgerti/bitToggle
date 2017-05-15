function createBitBlock(pattern, freq, time) {
    var comp = Qt.createComponent("BitBlockDef.qml");
    var sprite = comp.createObject(rCol, {"p": pattern,
                                       "f": freq,
                                       "t": time});

    if (sprite === null) {
        // Error Handling
        console.log("Error creating object");
    }
}
