import QtQuick 2.0
import QtQuick.LocalStorage 2.0
import Ubuntu.Components 1.1
import IntervalTimer 1.0

/*!
    \brief MainView with Tabs element.
           First Tab has a single Label and
           second Tab has a single ToolbarAction.
*/

MainView {
    // objectName for functional testing purposes (autopilot-qt5)
    objectName: "mainView"

    // Note! applicationName needs to match the "name" field of the click manifest
    applicationName: "intervaltimer.org"

    /*
     This property enables the application to change orientation
     when the device is rotated. The default is false.
    */
    //automaticOrientation: true

    // Removes the old toolbar and enables new features of the new header.
    useDeprecatedToolbar: false

    width: units.gu(100)
    height: units.gu(76)

    property real margins: units.gu(2)
    property real buttonWidth: units.gu(9)

    property var db : LocalStorage.openDatabaseSync("IntervalTimerDB", "1.0", "Interval Timer Storage", 1000000);

    function prepareDB() {

        db.transaction( function(tx) {
            // Create the database if it doesn't exist
            tx.executeSql('DROP TABLE Timer');
            tx.executeSql('CREATE TABLE IF NOT EXISTS Timer(Id INTEGER PRIMARY KEY, name TEXT, warmup INT, work INT, rest INT, cooldown INT, rounds INT)');

        })
    }



    function getNewId() {

        db.transaction( function(tx) {
            var lastid=0;
            var rs = tx.executeSql('SELECT * FROM Timer');
            return rs.rows.length+1;
        })
    }

    function getAllTimer(){


        db.transaction( function(tx) {
            var rs = tx.executeSql('SELECT * FROM Timer ORDER BY Id');

            var r=""
            for(var i=0; i<rs.rows.length; i++){
                r +=  JSON.stringify(rs.rows.item(i))+ "\n"
            }
            ta.text=r;
        })
    }

    function saveTimer(){
        db.transaction( function(tx) {

            var id=getNewId();
            if(id===null){
                id=1;
            }

            tx.executeSql('INSERT INTO Timer VALUES(?,?,?,?,?,?,?)', [id, timerName.text, parseInt(timerWarmup.text), parseInt(timerWorkout.text),parseInt(timerRest.text), parseInt(timerCooldown.text),parseInt(timerRounds.text) ]);

            // Show all greetings

        })
    }



    Page {
        title: i18n.tr("Interval Timer")
        Component.onCompleted: {

            prepareDB()
            getAllTimer()
        }

//        MyType {
//            id: myType

//            Component.onCompleted: {
//                //myType.helloWorld = i18n.tr("Hello world..")
//            }
//        }

        Column {
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }


            Row {
                spacing: units.gu(1)
                Label {
                    id: label_warmup
                    objectName: "label_warump"

//                    height: units.gu(4)
//                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: i18n.tr("Warmup [s]")
                }

                TextField {
                    id:  timerWarmup
                    objectName: "timerWarmup"
                    text: "10"
                    errorHighlight: true
                    validator: IntValidator{}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")
                    // placeholderText: i18n.tr("Warmup time in seconds")
//                    style: TextFieldStyle {
//                        textColor: "black"
//                        background: Rectangle {
//                            radius: 20
//                            color: "#A9F5F2"
//                            implicitWidth: 40
//                            implicitHeight: 24
//                            border.color: "#000000"
//                            border.width: 1
//                        }
//                    }


                }
            }

            Row {
                spacing: units.gu(1)
                Label {
                    id: label_workout
                    objectName: "label_workout"
//                    height: units.gu(4)
//                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: i18n.tr("Workout [s]")
                }

                TextField {
                    id:  timerWorkout
                    objectName: "timerWorkout"
                    text: "20"
                    errorHighlight: true
                    validator: IntValidator{}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")


                }
            }

            Row {
                spacing: units.gu(1)
                Label {
                    id: label_rest
                    objectName: "label_rest"
//                    height: units.gu(4)
//                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: i18n.tr("Rest [s]")
                }

                TextField {
                    id:  timerRest
                    objectName: "timerRest"
                    text: "10"
                    errorHighlight: true
                    validator: IntValidator{}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")


                }
            }

            Row {
                spacing: units.gu(1)
                Label {
                    id: label_rounds
                    objectName: "label_rounds"
                    //                    height: units.gu(4)
                    //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: i18n.tr("Rounds")
                }

                TextField {
                    id:  timerRounds
                    objectName: "timerRounds"
                    text: "8"
                    errorHighlight: true
                    validator: IntValidator{}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")


                }
            }

            Row {
                spacing: units.gu(1)
                Label {
                    id: label_cooldown
                    objectName: "label_cooldown"
                    //                    height: units.gu(4)
                    //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth


                    text: i18n.tr("Cooldown [s]")
                }

                TextField {
                    id:  timerCooldown
                    objectName: "timerCooldown"
                    text: "10"
                    errorHighlight: true
                    validator: IntValidator{}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")


                }
            }

            Row {
                spacing: units.gu(1)
                Label {
                    id: label_name
                    objectName: "label_name"
                    //                    height: units.gu(4)
                    //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: "Name"
                }

                TextField {
                    id:  timerName
                    objectName: "timerName"
                    text: "Name"
                    errorHighlight: false
                    //validator: DoubleValidator {notation: DoubleValidator.StandardNotation}
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                    height: units.gu(4)
                    font.pixelSize: FontUtils.sizeToPixels("medium")


                }
            }

            Button {
                objectName: "button"
                width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                text: i18n.tr("Save Timer!")

                onClicked: {
                    saveTimer()
                    getAllTimer()
                }
            }

            TextArea {
                id: ta
                objectName: "loadedtext"
                text :  getAllTimer()
                width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

            }

        }
    }
}

