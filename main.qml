import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ColumnLayout {
        id: column
        anchors.fill: parent

        Text {
            id: lDate
            text: qsTr("02 January 2017")
            verticalAlignment: Text.AlignVCenter
            elide: Text.ElideNone
            fontSizeMode: Text.HorizontalFit
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            width: parent.width
        }

        Text {
            id: lTime
            text: qsTr("Text")
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 12
            width: parent.width
        }

        SwipeView {
            id: swipeView
            Layout.fillHeight: true
            Layout.fillWidth: true
            currentIndex: tabBar.currentIndex

            Brew {
            }

            Ferment {
            }
        }
    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex
        TabButton {
            x: -304
            y: 0
            text: qsTr("BREW")
        }
        TabButton {
            x: -243
            y: 0
            text: qsTr("FERMENT")
        }
    }
}
