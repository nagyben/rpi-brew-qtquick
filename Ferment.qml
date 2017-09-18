import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls.Styles 1.4
import QtCharts 2.2
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
            columnSpacing: 5
            rowSpacing: 5
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
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                font.pointSize: 12
                font.bold: true
                Layout.fillWidth: false
                autoExclusive: false
            }


            Text {
                id: lTemp
                text: qsTr("##.#°C")
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                //                Layout.fillWidth: true
                font.pixelSize: 36
            }

            TextField {
                background: Rectangle {
                    implicitHeight: 25
                    color: "white"
                    border.color: "grey"
                }

                id: tSensorId
                Layout.fillWidth: true
                placeholderText: "Sensor ID"
            }

            Item {
                id: item1
                width: 200
                height: 200
                Layout.preferredHeight: 1
                Layout.preferredWidth: 1
                Layout.fillHeight: false
                Layout.fillWidth: false
            }

            Item {
                id: item2
                width: 200
                height: 200
                Layout.preferredHeight: 1
                Layout.preferredWidth: 1
            }

            Text {
                property date startTime
                id: lStartTime
                text: qsTr("")
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: true
                fontSizeMode: Text.FixedSize
                font.pixelSize: 24
                Layout.columnSpan: 2
            }

            Text {
                id: lTimeElapsed
                text: qsTr("")
                horizontalAlignment: Text.AlignHCenter
                Layout.fillWidth: false
                font.pixelSize: 24

                property bool running
                running: false
                function update() {
                    if (running) {
                        var diffSeconds = Math.floor((new Date() - lStartTime.startTime) / 1000);
                        var hours = String(Math.floor(diffSeconds / 60 / 60));
                        var mins = String("00" + (Math.floor((diffSeconds / 60) % 60))).slice(-2);
                        text = "+" + hours + "h" + mins + "m"
                    }
                }
            }

            TextField {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    border.color: "grey"
                    color: "white"
                }

                id: tOG
                horizontalAlignment: Text.AlignLeft
                Layout.alignment: Qt.AlignRight | Qt.AlignBottom
                placeholderText: "OG"
                onTextChanged: grid.calcABV()


            }

            Timer {
                interval: 1000; running: true; repeat: true
                onTriggered: {
                    lTimeElapsed.update()
                    button.resetLoop()
                }
            }

            Button {
                property string state: "START"
                property int resetCounter: 0
                id: button
                text: state
                font.bold: true
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignLeft | Qt.AlignBottom

                onPressed: {
                    if (state === "START" && tOG.length == 4) {
                        var og = parseInt(tOG.text)
                        if (!isNaN(og)) {
                            state = "STOP"
                            lStartTime.startTime = new Date()
                            lStartTime.text = "started " + new Date().toLocaleString(Qt.locale(), "dd-MM-yyyy hh:mm")
                            lTimeElapsed.running = true
                            lTimeElapsed.text = "+0h00m"
                            lineSeriesSG.clear()
                            lineSeriesSG.append(new Date().getTime(), og)
                            tOG.enabled = false
                        }
                    } else if (state === "STOP") {
                        state = "SURE?"
                    } else if (state == "SURE?") {
                        state = "START"
                        lTimeElapsed.running = false
                        tOG.enabled = true
                    }
                }
                function resetLoop() {
                    if (state === "SURE?") {
                        resetCounter++
                        if (resetCounter > 3) {
                            state = "STOP"
                            resetCounter = 0
                        }
                    }
                }
            }


            ChartView {
                Layout.minimumHeight: 200
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.rowSpan: 3
                antialiasing: true

                //                legend.visible: false

                LineSeries {
                    id: lineSeriesSG
                    axisX: DateTimeAxis {
                        id: dateAxis
                        format: "dd.MM"
                        min: new Date(2017, 8, 18)
                        max: new Date(2017, 8, 19)
                    }
                    axisY: ValueAxis {
                        labelFormat: "%d"
                        min: 900
                        max: 1100
                    }

                    onPointAdded: {
                        var minX = new Date(lineSeriesSG.at(0).x)
                        var maxX = new Date(lineSeriesSG.at(lineSeriesSG.count - 1).x)
                        dateAxis.min = minX
                        dateAxis.max = maxX
                    }
                }
            }

            TextField {
                background: Rectangle {
                    implicitWidth: 100
                    implicitHeight: 40
                    border.color: "grey"
                    color: "white"
                }

                id: tFG
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                placeholderText: "FG"
                Layout.fillWidth: false
                onTextChanged: grid.calcABV()

                width: 100
            }

            Button {
                id: btnLog
                text: qsTr("ADD SAMPLE")
                font.bold: true
                onPressed: {
                    var sg = parseInt(tFG.text)
                    if (!isNaN(sg)) {
                        lineSeriesSG.append(new Date().getTime(), sg)
                    }
                }
            }

            Text {
                id: lABV
                text: qsTr("#.##% ABV")
                Layout.columnSpan: 2
                Layout.fillWidth: false
                Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
                font.family: "Ubuntu Mono"
                font.pixelSize: 30
            }
        }
    }
}


