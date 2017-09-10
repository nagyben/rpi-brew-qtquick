import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import tempsensor 1.0
import datalogger 1.0

Item {

    ColumnLayout {
        id: column
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        antialiasing: false

        DataLogger{
            id: brewLogger
        }

        Text {
            id: lPhase
            text: qsTr("IDLE")
            Layout.fillWidth: true
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 36
        }

        GridLayout {
            id: grid
            rowSpacing: 10
            columnSpacing: 10
            rows: 3
            columns: 3
            Layout.fillHeight: true
            Layout.fillWidth: true

            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: {
                    tsRed.update()
                    tsBlue.update()
                    tsGreen.update()
                    lPrepElapsed.update()
                    lMashElapsed.update()
                    lBoilElapsed.update()
                    var logData = [tsRed.temp, tsBlue.temp, tsGreen.temp]
                    brewLogger.log(logData)
                }
            }

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
                text: tsBlue.sensorAddress
                onTextChanged: tsBlue.sensorAddress = text
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                id: tGreenId
                text: tsGreen.sensorAddress
                onTextChanged: tsGreen.sensorAddress = text
                Layout.fillWidth: true
                horizontalAlignment: Text.AlignHCenter
            }

            TempSensor {
                id: tsRed
                onTempChanged: lRed.text = Number(Math.round(getTemp()+'e2')+'e-2') + " °C"
            }

            TempSensor {
                id: tsBlue
                onTempChanged: lBlue.text = Number(Math.round(getTemp()+'e2')+'e-2') + " °C"
            }

            TempSensor {
                id: tsGreen
                onTempChanged: lGreen.text = Number(Math.round(getTemp()+'e2')+'e-2') + " °C"
            }

            Button {
                id: btnPrep
                text: qsTr("PREP")
                font.bold: true
                Layout.fillWidth: true
                onClicked: {
                    lPhase.text = "PREP"
                    lPhase.color = "red"
                    lPrepStart.startTime = new Date()
                }
            }

            Button {
                id: btnMash
                text: qsTr("MASH")
                font.bold: true
                spacing: 0
                Layout.fillWidth: true
                onClicked: {
                    lPhase.text = "MASH"
                    lPhase.color = "blue"
                    lMashStart.startTime = new Date()
                }
            }

            Button {
                id: btnBoil
                text: qsTr("BOIL")
                font.bold: true
                Layout.fillWidth: true
                onClicked: {
                    lPhase.text = "BOIL"
                    lPhase.color = "green"
                    lBoilStart.startTime = new Date()
                }
            }

            Text {
                id: lPrepStart
                font.family: "Ubuntu Mono"
                horizontalAlignment: Text.AlignLeft
                Layout.fillWidth: true
                font.pixelSize: 36

                property date startTime
                onStartTimeChanged: {
                    text = startTime.toLocaleString(Qt.locale(), "hh:mm")
                    lPrepElapsed.text = "   00:00"
                    lPrepElapsed.running = true
                }
            }

            Text {
                id: lMashStart
                font.family: "Ubuntu Mono"
                font.pixelSize: 36
                property date startTime
                onStartTimeChanged: {
                    text = startTime.toLocaleString(Qt.locale(), "hh:mm")
                    lMashElapsed.text = "   00:00"
                    lMashElapsed.running = true
                }
            }

            Text {
                id: lBoilStart
                font.family: "Ubuntu Mono"
                font.pixelSize: 36
                property date startTime
                onStartTimeChanged: {
                    text = startTime.toLocaleString(Qt.locale(), "hh:mm")
                    lBoilElapsed.text = "   00:00"
                    lBoilElapsed.running = true
                }
            }

            Text {
                id: lPrepElapsed
                font.family: "Ubuntu Mono"
                font.pixelSize: 36

                property bool running
                running: false
                function update() {
                    if (running) {
                        var diffSeconds = Math.floor((new Date() - lPrepStart.startTime) / 1000)
                        var mins = String("00" + Math.floor(diffSeconds / 60)).slice(-2);
                        var seconds = String("00" + diffSeconds % 60).slice(-2);
                        text = "   " + mins + ":" + seconds
                    }
                }
            }

            Text {
                id: lMashElapsed
                font.family: "Ubuntu Mono"
                font.pixelSize: 36

                property bool running
                running: false
                function update() {
                    if (running) {
                        var diffSeconds = Math.floor((new Date() - lMashStart.startTime) / 1000)
                        var mins = String("00" + Math.floor(diffSeconds / 60)).slice(-2);
                        var seconds = String("00" + diffSeconds % 60).slice(-2);
                        text = "   " + mins + ":" + seconds
                    }
                }
            }

            Text {
                id: lBoilElapsed
                font.family: "Ubuntu Mono"
                font.pixelSize: 36

                property bool running
                running: false
                function update() {
                    if (running) {
                        var diffSeconds = Math.floor((new Date() - lBoilStart.startTime) / 1000)
                        var mins = String("00" + Math.floor(diffSeconds / 60)).slice(-2);
                        var seconds = String("00" + diffSeconds % 60).slice(-2);
                        text = "   " + mins + ":" + seconds
                    }
                }
            }

            Pane {
                id: pane
                width: 200
                height: 200
            }
            Switch {
                id: sLog
                text: qsTr("LOGGING")
                spacing: 18
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                font.bold: true
                onCheckedChanged: {
                    brewLogger.logEnabled = checked;
                }
            }
        }

    }
}
