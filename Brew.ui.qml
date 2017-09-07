import QtQuick 2.7

Item {
    Column {
        id: column
        antialiasing: false
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
    }
}
