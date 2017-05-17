function sort(children, currentElement) {
    var len = children.length;
    var j;
    var eleIdx;

    var swapped;
    do {
        swapped = false;
        for (var i=0; i < len-1; i++) {
            if (children[i].y > children[i+1].y) {
                var temp = children[i];
                children[i] = children[i+1];
                children[i+1] = temp;
                swapped = true;
            }
        }
    } while (swapped);

    var sorted = children;

    for (j = 0; j < len; j++){
        if (children[j] === currentElement){
            eleIdx = j;
        }
    }
    for (j = 0; j < len; j++){
        children[j].destroy();
    }
    for (var m = 0; m < len; m++){
        var component = Qt.createComponent("BitBlockDef.qml").createObject(rCol, {"p": sorted[m].p,
                                                               "f": sorted[m].f,
                                                               "t": sorted[m].t});
        if (m === eleIdx){
            root.lastElementClicked = component;
            console.log("assigned");
        }
    }
}
