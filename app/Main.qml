/**
  * Interval Timer is a program to configure custom timers for interval trainings and workouts
  * Copyright (c) 2015 Gerald Ortner <ortner.g@hotmail.com>
  *
  * This file is part of Interval Timer
  *
  * Interval Timer is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 3 of the License, or
  * (at your option) any later version.
  *
  * This program is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  *
  * You should have received a copy of the GNU General Public License
  * along with this program. If not, see <http://www.gnu.org/licenses/>.
  *
  */


import QtQuick 2.0
import QtQuick.LocalStorage 2.0

//import QtQuick.Controls 1.1
//import QtQuick.Controls.Styles 1.2
import QtQuick.Layouts 1.1
import Ubuntu.Components 1.1
import QtGraphicalEffects 1.0
import IntervalTimer 1.0

/*!
    \brief MainView with Timer settings and start button
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
            tx.executeSql('DROP TABLE IF EXISTS Timer');
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

    backgroundColor: "#454545"

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
        FontLoader { id: digitalMono; source: "fonts/digital-7 (mono).ttf" }

        Column{
            id: pageLayout
            spacing: units.gu(1)
            anchors {
                margins: units.gu(2)
                fill: parent
            }

            Row{
                GridLayout {
                    id: grid
                    columns: 2

                    Label {
                        id: label_warmup
                        objectName: "label_warump"
                        text: i18n.tr("Warmup [s]")
                    }



                    Rectangle {
                        radius: 20
                        color: "#b7ff82"
                        id: rect3

                        width: units.gu(20)

                        height: units.gu(4)
                        //implicitWidth: 100
                        //implicitHeight:24
                        border.color: "#ffffff"
                        border.width: 1
                        TextField {
                            id:  timerWarmup
                            objectName: "timerWarmup"
                            text: "10"
                            //errorHighlight: true
                            validator: IntValidator{}
                            width: parent.width //pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                            height: units.gu(4)
                            color: "black"
                            font { family: digitalMono.name; pixelSize: 20; capitalization: Font.Capitalize}
                            horizontalAlignment: TextInput.AlignRight
                        }

                    }

                    Label {
                        id: label_workout
                        objectName: "label_workout"
                        //                    height: units.gu(4)
                        //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                        text: i18n.tr("Workout [s]")
                    }

                    Rectangle {
                        radius: 20
                        color: "#b7ff82"
                        id: rect4

                        width: units.gu(20)

                        height: units.gu(4)
                        //implicitWidth: 100
                        //implicitHeight:24
                        border.color: "#ffffff"
                        border.width: 1
                        TextField {
                            id:  timerWorkout
                            objectName: "timerWorkout"
                            text: "20"
                            errorHighlight: true
                            validator: IntValidator{}
                            width: parent.width // pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                            height: units.gu(4)
                            color: "black"
                            font { family: digitalMono.name; pixelSize: 20; capitalization: Font.Capitalize}
                            horizontalAlignment: TextInput.AlignRight


                        }
                    }


                    Label {
                        id: label_rest
                        objectName: "label_rest"
                        //                    height: units.gu(4)
                        //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                        text: i18n.tr("Rest [s]")
                    }


                    Rectangle {
                        radius: 20
                        color: "#b7ff82"
                        id: rect5
                        width: units.gu(20)

                        height: units.gu(4)
                        //implicitWidth: 100
                        //implicitHeight:24
                        border.color: "#ffffff"
                        border.width: 1
                        TextField {
                            id:  timerRest
                            objectName: "timerRest"
                            text: "10"
                            errorHighlight: true
                            validator: IntValidator{}
                            width: parent.width //pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                            height: units.gu(4)
                            color: "black"
                            font { family: digitalMono.name; pixelSize: 20; capitalization: Font.Capitalize}
                            horizontalAlignment: TextInput.AlignRight

                        }
                    }


                    Label {
                        id: label_rounds
                        objectName: "label_rounds"
                        //                    height: units.gu(4)
                        //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                        text: i18n.tr("Rounds")
                    }

                    Rectangle {
                        radius: 20
                        color: "#b7ff82"
                        id: rect6
                        width: units.gu(20)
                        height: units.gu(4)
                        //implicitWidth: 100
                        //implicitHeight:24
                        border.color: "#ffffff"
                        border.width: 1
                        TextField {
                            id:  timerRounds
                            objectName: "timerRounds"
                            text: "8"
                            color: "black"
                            errorHighlight: true
                            validator: IntValidator{}
                            width: parent.width //pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                            height: units.gu(4)
                            font { family: digitalMono.name; pixelSize: 20; capitalization: Font.Capitalize}
                            horizontalAlignment: TextInput.AlignRight

                        }
                    }

                    Label {
                        id: label_cooldown
                        objectName: "label_cooldown"
                        //                    height: units.gu(4)
                        //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth


                        text: i18n.tr("Cooldown [s]")
                    }
                    Rectangle {
                        id: rect7
                        radius: 20
                        color: "#b7ff82"

                        width: units.gu(20)

                        height: units.gu(4)
                        //implicitWidth: 100
                        //implicitHeight:24
                        border.color: "#ffffff"
                        border.width: 1
                        TextField {
                            font { family: digitalMono.name; pixelSize: 20; capitalization: Font.Capitalize}
                            horizontalAlignment: TextInput.AlignRight
                            id:  timerCooldown
                            color: "black"
                            objectName: "timerCooldown"
                            text: "10"
                            errorHighlight: true
                            validator: IntValidator{}
                            width: parent.width //pageLayout.width - 2* mainView.margins - mainView.buttonWidth
                            height: units.gu(4)
                            //font.pixelSize: FontUtils.sizeToPixels("medium")


                        }
                    }



                }
            }

            Row{
                spacing: units.gu(1)



                Button {
                    objectName: "button"
                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

                    text: i18n.tr("Save Timer!")

                    onClicked: {
                        saveTimer()
                        getAllTimer()
                    }
                }

            }

        }



    }
    // Save Dialog

    Label {
        id: label_name
        objectName: "label_name"
        //                    height: units.gu(4)
        //                    width: pageLayout.width - 2* mainView.margins - mainView.buttonWidth

        text: "Name"
    }
    Rectangle {
        //anchors.centerIn: parent
        id: rect8
        radius: 20
        color: "#b7ff82"
        //anchors.fill: parent

        width: units.gu(20)
        height: units.gu(4)
        //implicitWidth: 100
        //implicitHeight:24
        border.color: "#ffffff"
        border.width: 1

        TextField {

            id:  timerName
            color: "black"
            objectName: "timerName"
            text: "Name"
            errorHighlight: false
            //validator: DoubleValidator {notation: DoubleValidator.StandardNotation}
            width: parent.width //pageLayout.width - 2* mainView.margins - mainView.buttonWidth
            height: units.gu(4)
            font.pixelSize: FontUtils.sizeToPixels("medium")

        }
    }
}

