import QtQuick 2.0
import Ubuntu.Components 1.1


    Page {

        Rectangle {
            width: 360
            height: 360
            Text {
                anchors.centerIn: parent
                text: "Main Page"
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    ld.source="running.qml"
                }
            }
            Loader{
                id:ld;
                anchors.fill: parent;
            }
        }

        Button {
            id: startbutton
            objectName: "startbutton"
            width: units.gu(30)
            height: unit.gu(15)
            color: "orange"
            text: i18n.tr("START!")

        }
    }
