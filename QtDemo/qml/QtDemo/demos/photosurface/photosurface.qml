/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** You may use this file under the terms of the BSD license as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of Digia Plc and its Subsidiary(-ies) nor the names
**     of its contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.7

Rectangle {
    id: root
    visible: true
    anchors.fill: parent
    property int highestZ: 0
    property real defaultSize: 200

    gradient: Gradient{
        GradientStop{position: 0.0; color: "#333333"}
        GradientStop{position: 1.0; color: "#111111"}
    }

    Repeater {
//        model: FolderListModel {
//            id: folderModel
//            objectName: "folderModel"
//            showDirs: false
//            nameFilters: ["*.png", "*.jpg", "*.gif"]
//        }
        id: repeater
        model: 5
        anchors.fill: parent

        clip: true
        Rectangle {
            id: photoFrame
            width: image.width * image.scale + 20
            height: image.height * image.scale + 20
            border.color: "black"
            border.width: 2
            smooth: true
            antialiasing: true
            x: Math.random() * root.width - defaultSize / 2
            y: Math.random() * root.height - defaultSize / 2
            rotation: Math.random() * 13 - 6
            Image {
                id: image
                anchors.centerIn: parent
                fillMode: Image.PreserveAspectFit
                source: "images/image"+index+".png"
                scale: defaultSize / Math.max(sourceSize.width, sourceSize.height)
                antialiasing: true
            }
            PinchArea {
                anchors.fill: parent
                pinch.target: photoFrame
                pinch.minimumRotation: -360
                pinch.maximumRotation: 360
                pinch.minimumScale: 0.1
                pinch.maximumScale: 10
                onPinchFinished: photoFrame.border.color = "black";
                MouseArea {
                    id: dragArea
                    hoverEnabled: true
                    anchors.fill: parent
                    drag.target: photoFrame
                    onPressed: photoFrame.z = ++root.highestZ;
                    onEntered: photoFrame.border.color = "red";
                    onExited: photoFrame.border.color = "black";
                    onWheel: {
                        if (wheel.modifiers & Qt.ControlModifier) {
                            photoFrame.rotation += wheel.angleDelta.y / 120 * 5;
                            if (Math.abs(photoFrame.rotation) < 4)
                                photoFrame.rotation = 0;
                        } else {
                            photoFrame.rotation += wheel.angleDelta.x / 120;
                            if (Math.abs(photoFrame.rotation) < 0.6)
                                photoFrame.rotation = 0;
                            var scaleBefore = image.scale;
                            image.scale += image.scale * wheel.angleDelta.y / 120 / 10;
                            photoFrame.x -= image.width * (image.scale - scaleBefore) / 2.0;
                            photoFrame.y -= image.height * (image.scale - scaleBefore) / 2.0;
                        }
                    }
                }
            }
        }
    }
//    Text {
//        anchors.bottom: parent.bottom
//        anchors.left: parent.left
//        anchors.margins: 10
//        color: "darkgrey"
//        text: "On a touchscreen: use two fingers to zoom and rotate, one finger to drag\n" +
//              "With a mouse: drag normally, use the vertical wheel to zoom, horizontal wheel to rotate, or hold Ctrl while using the vertical wheel to rotate"
//        wrapMode: Text.Wrap
//    }

    //Component.onCompleted: fileDialog.open()
}
