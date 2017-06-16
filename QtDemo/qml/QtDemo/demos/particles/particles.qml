/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
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
import "content/qml"

Item {
    anchors.fill: parent

    LauncherList {
        id: ll
        anchors.fill: parent
        Component.onCompleted: {
            addExample("Age", "Kills off particles that enter the affector",  Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/age.qml"));
            addExample("Attractor", "Simulates a small black hole", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/attractor.qml"));
            addExample("Custom Affector", "Custom falling leaves", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/customaffector.qml"));
            addExample("Friction", "Leaves that slow down as they fall", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/friction.qml"));
            addExample("Gravity", "Leaves that fall towards the earth as you move it", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/gravity.qml"));
            addExample("GroupGoal", "Balls that can be set on fire various ways", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/groupgoal.qml"));
            addExample("Move", "Some effects you can get by altering trajectory midway", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/move.qml"));
            addExample("SpriteGoal", "A ship that makes asteroids explode", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/spritegoal.qml"));
            addExample("Turbulence", "A candle with faint wind", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/turbulence.qml"));
            addExample("Wander", "Drifting snow flakes", Qt.resolvedUrl("qrc:/qml/QtDemo/demos/particles/content/qml/wander.qml"));
        }
    }
}
