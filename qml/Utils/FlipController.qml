import QtQuick 2.0

MouseArea {
    id: root

    acceptedButtons: Qt.LeftButton
    propagateComposedEvents: true

    property bool debug: false

    property int delta: 50
    property bool clicked: false
    property point startPos
    property point stopPos

    signal flipRight()
    signal flipLeft()
    signal flipUp()
    signal flipDown()

    onPressed: {
        clicked = true
        startPos = Qt.point(mouseX, mouseY)
    }

    onReleased: {
        clicked = false
    }

    onPositionChanged: {
//        if(clicked){
//            stopPos = Qt.point(mouseX, mouseY)
//            var deltaX = stopPos.x - startPos.x
//            var deltaY = stopPos.y - startPos.y

////            if(debug) console.log("delta:", deltaX, deltaY)

//            if(Math.abs(deltaX) > delta){
//                if(deltaX < 0) flipLeft()
//                else flipRight()
//                clicked = false
//            }else if(Math.abs(deltaY) > delta){
//                if(deltaY < 0) flipUp()
//                else flipDown()
//                clicked = false
//            }
//        }
    }

    onFlipRight: if(debug) console.log("Right");
    onFlipLeft: if(debug) console.log("Left")
    onFlipUp: if(debug) console.log("Up")
    onFlipDown: if(debug) console.log("Down")
}
