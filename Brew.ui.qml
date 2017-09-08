import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import tempsensor 1.0

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
                text: tsRed.sensorAddress
                onTextChanged: tsRed.sensorAddress = text
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: tBlueId
                onTextChanged: tsBlue.sensorAddress = text
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: tGreenId
                onTextChanged: tsGreen.sensorAddress = text
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TempSensor {
                id: tsRed
            }

            TempSensor {
                id: tsBlue
            }

            TempSensor {
                id: tsGreen
            }

            Button {
                id: btnPrep
                text: qsTr("PREP")
                font.bold: true
                Layout.fillWidth: true
            }

            Button {
                id: btnMash
                text: qsTr("MASH")
                font.bold: true
                spacing: 0
                Layout.fillWidth: true
            }

            Button {
                id: btnBoil
                text: qsTr("BOIL")
                font.bold: true
                Layout.fillWidth: true
            }
        }
    }
}
