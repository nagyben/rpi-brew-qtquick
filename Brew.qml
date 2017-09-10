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
            font.family: "Tahoma"
            padding: 5
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
                    var logData = [lPhase.text, tsRed.temp, tsBlue.temp, tsGreen.temp]
                    brewLogger.log(logData)
                }
            }

            Text {
                id: lRed
                color: "#960000"
                text: qsTr("n/a")
                font.pixelSize: 40
                padding: 10
                horizontalAlignment: Text.AlignHCenter
                font.family: "Ubuntu"
                fontSizeMode: Text.FixedSize
                Layout.fillWidth: true
            }

            Text {
                id: lBlue
                color: "#508bc6"
                text: qsTr("n/a")
                padding: 10
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 40
                Layout.fillWidth: true
            }

            Text {
                id: lGreen
                color: "#288e28"
                text: qsTr("n/a")
                padding: 10
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 40
                Layout.fillWidth: true
            }

            TextField {
                background: Rectangle {
                    implicitHeight: 25
                    color: "white"
                    border.color: "grey"
                }

                id: tRedId
                color: "#960000"
                maximumLength: 6
                text: tsRed.sensorAddress
                padding: 0
                onTextChanged: tsRed.sensorAddress = text
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                background: Rectangle {
                    implicitHeight: 25
                    color: "white"
                    border.color: "grey"
                }
                id: tBlueId
                color: "#508bc6"
                text: tsBlue.sensorAddress
                maximumLength: 6
                padding: 0
                onTextChanged: tsBlue.sensorAddress = text
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                horizontalAlignment: Text.AlignHCenter
            }

            TextField {
                background: Rectangle {
                    implicitHeight: 25
                    color: "white"
                    border.color: "grey"
                }
                id: tGreenId
                color: "#288e28"
                maximumLength: 6
                padding: 0
                text: tsGreen.sensorAddress
                onTextChanged: tsGreen.sensorAddress = text
                Layout.fillWidth: true
                Layout.leftMargin: 5
                Layout.rightMargin: 5
                horizontalAlignment: Text.AlignHCenter
            }

            TempSensor {
                id: tsRed
                onTempChanged: {
                    var temp = Number(Math.round(getTemp()+'e2')+'e-2');
                    lRed.text = temp === -1 ? "n/a" : temp + " °C"
                }
            }

            TempSensor {
                id: tsBlue
                onTempChanged: {
                    var temp = Number(Math.round(getTemp()+'e2')+'e-2');
                    lBlue.text = temp === -1 ? "n/a" : temp + " °C"
                }
            }

            TempSensor {
                id: tsGreen
                onTempChanged: {
                    var temp = Number(Math.round(getTemp()+'e2')+'e-2');
                    lGreen.text = temp === -1 ? "n/a" : temp + " °C"
                }
            }

            Button {
                id: btnPrep
                text: qsTr("PREP")
                font.pointSize: 20
                padding: 10
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
                font.pointSize: 20
                padding: 10
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
                padding: 10
                font.pointSize: 20
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
                font.pixelSize: 36

                property date startTime
                Layout.fillWidth: false
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

            Pane {}

            Switch {
                id: sLog
                text: qsTr("LOGGING")
                padding: 0
                spacing: 10
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
