import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import tempsensor 1.0
import datalogger 1.0

Item {
    ColumnLayout {
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top


        Text {
            text: "FERMENT"
            font.pointSize: 30
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
        }

        GridLayout {
            id: grid
            clip: false
            columnSpacing: 10
            rowSpacing: 20
            columns: 3
            Layout.fillHeight: false
            Layout.fillWidth: true

            function calcABV() {
                if (tOG.text.length == 4 && tFG.text.length == 4) {
                    var og = parseInt(tOG.text) / 1000.0;
                    var fg = parseInt(tFG.text) / 1000.0;
                    var abv = (76.08 * (og-fg) / (1.775-og)) * (fg / 0.794)
                    lABV.text = Number(Math.round(abv+'e2')+'e-2') + '% ABV'
                }
            }

            SpinBox {
                id: tSetpoint
                from: 10
                to: 28
                stepSize: 1
                value: 19
                Layout.fillWidth: true
                font.pixelSize: 36
            }

            Switch {
                id: sControlEnabled
                text: qsTr("CONTROL")
                font.bold: true
                Layout.fillWidth: false
                autoExclusive: false
            }

            Text {
                id: lTemp
                text: qsTr("##.#°C")
                Layout.fillWidth: true
                font.pixelSize: 36
            }

            Text {
                id: lStartTime
                text: qsTr("started 12:38 04-08-2017")
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                fontSizeMode: Text.FixedSize
                font.pixelSize: 24
                Layout.columnSpan: 2
            }

            Text {
                id: lTimeElapsed
                text: qsTr("HHH:MM elapsed")
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                font.pixelSize: 24
            }

            Text {
                id: text1
                text: qsTr("OG")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                font.family: "Ubuntu Mono"
                font.pixelSize: 30
            }

            TextField {
                id: tOG
                placeholderText: "OG"
                onTextChanged: grid.calcABV()


            }

            Text {
                id: lABV
                text: qsTr("#.##% ABV")
                font.family: "Ubuntu Mono"
                font.pixelSize: 30
            }

            Text {
                id: text2
                text: qsTr("FG")
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                horizontalAlignment: Text.AlignLeft
                font.family: "Ubuntu Mono"
                font.pixelSize: 30
            }

            TextField {
                id: tFG
                placeholderText: "FG"
                Layout.fillWidth: false
                onTextChanged: grid.calcABV()
            }

            Button {
                id: btnLog
                text: qsTr("ADD SAMPLE")
            }





        }
    }
}
