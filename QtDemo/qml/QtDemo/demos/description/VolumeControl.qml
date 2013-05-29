
import QtQuick 2.0

Item {
    id: root
    property alias volume: volumeSlider.value

    //Volume Controls
    ImageButton {
        id: volumeDown
        height: parent.height * 0.5
        imageSource: "images/VolumeDown.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.left: root.left
        onClicked: {
            root.volume = 0.0;
        }
    }
    Slider {
        id: volumeSlider
        anchors.left: volumeDown.right
        anchors.right: volumeUp.left
        height: root.height
        maximum: 1.0
        minimum: 0.0
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 1
    }

    ImageButton {
        id: volumeUp
        height: parent.height * 0.5
        imageSource: "images/VolumeUp.png"
        anchors.verticalCenter: root.verticalCenter
        anchors.verticalCenterOffset: 1
        anchors.right: root.right
        onClicked: {
            root.volume = 1.0
        }
    }
}
