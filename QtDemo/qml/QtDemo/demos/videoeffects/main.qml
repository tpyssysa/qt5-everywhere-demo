/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Qt Mobility Components.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
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
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
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
import QtQuick.Window 2.1
import "qml/qmlvideofx"

Rectangle {
    id: root

    property string fileName
    property alias volume: content.volume
    property int pixDens: Math.ceil(Screen.pixelDensity)
    property int itemWidth: 15 * pixDens
    property int itemHeight: 7 * pixDens
    property int windowWidth: parent.width // Screen.desktopAvailableWidth
    property int windowHeight: parent.height // Screen.desktopAvailableHeight
    property int scaledMargin: 2 * pixDens
    property int fontSize: 3 * pixDens

    color: "black"
    anchors.fill: parent

    QtObject {
        id: d
        property real gripSize: 20
    }

    Content {
        id: content
        color: "transparent"
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: effectName.top
            margins: scaledMargin
            leftMargin: scaledMargin + itemHeight
        }
        gripSize: d.gripSize
    }

    ParameterPanel {
        id: parameterPanel
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: scaledMargin
            leftMargin: scaledMargin
        }
        gripSize: d.gripSize
        height: root.itemHeight * 2
        width: root.itemWidth * 3
    }

    Button {
        id: effectName
        anchors {
            right: parent.right
            bottom: parameterPanel.top
            margins: scaledMargin
        }

        text: "No effect"
        width: itemWidth * 2
        height: itemHeight
        onClicked: {
            effectName.visible = false
            listview.visible = true
            lvbg.visible = true
        }
        color: "#303030"
    }

    Rectangle {
        id: lvbg
        width: itemWidth * 2
        color: "black"
        opacity: 0.8
        visible: false

        anchors {
            right: parent.right
            bottom: parent.bottom
            top: parent.top
            margins: scaledMargin
        }

        ListView {
            id: listview
            width: itemWidth * 2
            anchors.fill: parent
            visible: false

            model: EffectSelectionList {}
            delegate: effectDelegate

            clip: true
            focus: true

            Component {
                id: effectDelegate
                Button {
                    text: name
                    width: itemWidth * 2
                    onClicked: {
                        content.effectSource = source
                        listview.visible = false
                        lvbg.visible = false
                        effectName.text = name
                        effectName.visible = true
                        parameterPanel.model = content.effect.parameters
                    }
                }
            }
        }
    }

    FileOpen {
        id: fileOpen
        state: "collapsed"
        anchors {
            left: parent.left
            top: parent.top
            bottom: parent.bottom
            margins: scaledMargin
        }
        width: itemHeight + scaledMargin
        z: 2
        opacity: 0.9

        states: [
            State {
                name: "expanded"
                PropertyChanges {
                    target: fileOpen
                    width: itemWidth * 1.5
                    opacity: 0.8
                }
            },
            State {
                name: "collapsed"
                PropertyChanges {
                    target: fileOpen
                    width: itemHeight + scaledMargin
                    opacity: 0.9
                }
            }
        ]

        transitions: [
            Transition {
                NumberAnimation { target: fileOpen; property: "width"; duration: 100 }
                NumberAnimation { target: fileOpen; property: "opacity"; duration: 100 }
            }
        ]
    }

    FileBrowser {
        id: imageFileBrowser
        anchors.fill: root
        Component.onCompleted: fileSelected.connect(content.openImage)
    }

    FileBrowser {
        id: videoFileBrowser
        anchors.fill: root
        Component.onCompleted: fileSelected.connect(content.openVideo)
    }

    Component.onCompleted: {
        fileOpen.openImage.connect(openImage)
        fileOpen.openVideo.connect(openVideo)
        fileOpen.openCamera.connect(openCamera)
        fileOpen.close.connect(close)
        imageFileBrowser.folder = imagePath
        videoFileBrowser.folder = videoPath
        content.init()
        if (fileName != "")
            content.openVideo(fileName)
    }

    function qmlFramePainted() {
    }

    function openImage() {
        imageFileBrowser.show()
    }

    function openVideo() {
        videoFileBrowser.show()
    }

    function openCamera() {
        content.openCamera()
    }

    function close() {
        content.init()
    }
}

