/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
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
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Universal 2.1
import Qt.labs.settings 1.0

Page {
    id: window
    anchors.fill: parent

    Settings {
        id: settings
        property string style: "Default"
    }

    Shortcut {
        sequence: "Esc"
        enabled: stackView.depth > 1
        onActivated: {
            stackView.pop()
            listView.currentIndex = -1
        }
    }

    Shortcut {
        sequence: "Menu"
        onActivated: optionsMenu.open()
    }

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: stackView.depth > 1 ? "content/images/back.png" : "content/images/drawer.png"
                }
                onClicked: {
                    if (stackView.depth > 1) {
                        stackView.pop()
                        listView.currentIndex = -1
                    } else {
                        drawer.width = Qt.binding(function() { return Math.min(window.width, window.height) / 3 * 2; })
                    }
                }
            }

            Label {
                id: titleLabel
                text: listView.currentItem ? listView.currentItem.text : "Gallery"
                font.pixelSize: 20
                elide: Label.ElideRight
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "content/images/menu.png"
                }
                onClicked: optionsMenu.open()

                Menu {
                    id: optionsMenu
                    x: parent.width - width
                    transformOrigin: Menu.TopRight

                    MenuItem {
                        text: "About"
                        onTriggered: aboutDialog.open()
                    }
                }
            }
        }
    }

    Rectangle {
        id: drawer
        width: 0
        height: window.height
        clip: true
        z: 1

        Behavior on width {
            NumberAnimation { }
        }

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: ItemDelegate {
                width: parent.width
                text: model.title
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index
                    stackView.push(model.source)
                    drawer.width = 0;
                }
            }

            model: ListModel {
                ListElement { title: "BusyIndicator"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/BusyIndicatorPage.qml" }
                ListElement { title: "Button"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ButtonPage.qml" }
                ListElement { title: "CheckBox"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/CheckBoxPage.qml" }
                ListElement { title: "ComboBox"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ComboBoxPage.qml" }
                ListElement { title: "DelayButton"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/DelayButtonPage.qml" }
                ListElement { title: "Dial"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/DialPage.qml" }
                ListElement { title: "Dialog"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/DialogPage.qml" }
                ListElement { title: "Delegates"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/DelegatePage.qml" }
                ListElement { title: "Frame"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/FramePage.qml" }
                ListElement { title: "GroupBox"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/GroupBoxPage.qml" }
                ListElement { title: "PageIndicator"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/PageIndicatorPage.qml" }
                ListElement { title: "ProgressBar"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ProgressBarPage.qml" }
                ListElement { title: "RadioButton"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/RadioButtonPage.qml" }
                ListElement { title: "RangeSlider"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/RangeSliderPage.qml" }
                ListElement { title: "ScrollBar"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ScrollBarPage.qml" }
                ListElement { title: "ScrollIndicator"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ScrollIndicatorPage.qml" }
                ListElement { title: "Slider"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/SliderPage.qml" }
                ListElement { title: "SpinBox"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/SpinBoxPage.qml" }
                ListElement { title: "StackView"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/StackViewPage.qml" }
                ListElement { title: "SwipeView"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/SwipeViewPage.qml" }
                ListElement { title: "Switch"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/SwitchPage.qml" }
                ListElement { title: "TabBar"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/TabBarPage.qml" }
                ListElement { title: "TextArea"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/TextAreaPage.qml" }
                ListElement { title: "TextField"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/TextFieldPage.qml" }
                ListElement { title: "ToolTip"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/ToolTipPage.qml" }
                ListElement { title: "Tumbler"; source: "qrc:/qml/QtDemo/demos/controlsgallery/content/pages/TumblerPage.qml" }
            }

            ScrollIndicator.vertical: ScrollIndicator { }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent

        initialItem: Pane {
            id: pane

            Image {
                id: logo
                width: pane.availableWidth / 2
                height: pane.availableHeight / 2
                anchors.centerIn: parent
                anchors.verticalCenterOffset: -50
                fillMode: Image.PreserveAspectFit
                source: "content/images/qt-logo.png"
            }

            Label {
                text: "Qt Quick Controls 2 provides a set of controls that can be used to build complete interfaces in Qt Quick."
                anchors.margins: 20
                anchors.top: logo.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: arrow.top
                horizontalAlignment: Label.AlignHCenter
                verticalAlignment: Label.AlignVCenter
                wrapMode: Label.Wrap
            }

            Image {
                id: arrow
                source: "content/images/arrow.png"
                anchors.left: parent.left
                anchors.bottom: parent.bottom
            }
        }
    }

    Dialog {
        id: aboutDialog
        modal: true
        focus: true
        title: "About"
        x: (window.width - width) / 2
        y: window.height / 6
        width: Math.min(window.width, window.height) / 3 * 2
        contentHeight: aboutColumn.height

        Column {
            id: aboutColumn
            spacing: 20

            Label {
                width: aboutDialog.availableWidth
                text: "The Qt Quick Controls 2 module delivers the next generation user interface controls based on Qt Quick."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }

            Label {
                width: aboutDialog.availableWidth
                text: "In comparison to the desktop-oriented Qt Quick Controls 1, Qt Quick Controls 2 "
                    + "are an order of magnitude simpler, lighter and faster, and are primarily targeted "
                    + "towards embedded and mobile platforms."
                wrapMode: Label.Wrap
                font.pixelSize: 12
            }
        }
    }
}
