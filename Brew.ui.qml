import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3

Item {

    ColumnLayout {
        id: column
        anchors.fill: parent
        antialiasing: false

        GridLayout {
            id: grid
            rowSpacing: 10
            columnSpacing: 10
            //            spacing: 10
            rows: 3
            columns: 3
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: lRed
                text: qsTr("n/a °C")
                horizontalAlignment: Text.AlignHCenter
                font.family: "Ubuntu"
                fontSizeMode: Text.FixedSize
                font.pixelSize: 30
                Layout.fillWidth: true
            }

            Text {
                id: lBlue
                text: qsTr("n/a °C")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
                Layout.fillWidth: true
            }

            Text {
                id: lGreen
                text: qsTr("n/a °C")
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 30
                Layout.fillWidth: true
            }

            TextField {
                id: tRedId
                text: qsTr("Text Field")
                Layout.fillHeight: false
                leftPadding: 10
                padding: 6
                topPadding: 6
                Layout.preferredHeight: 30
                Layout.minimumHeight: 0
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: tBlueId
                text: qsTr("Text Field")
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: tGreenId
                text: qsTr("Text Field")
                Layout.preferredHeight: 30
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            Button {
                id: btnPrep
                text: qsTr("PREP")
                Layout.fillWidth: true
            }

            Button {
                id: btnMash
                text: qsTr("MASH")
                spacing: 0
                Layout.fillWidth: true
            }

            Button {
                id: btnBoil
                text: qsTr("BOIL")
                Layout.fillWidth: true
            }
        }
    }
}
