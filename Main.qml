import QtQuick 2.15

import QtQuick.Controls 2.4 as QQC
import Qt5Compat.GraphicalEffects
import "components"
import "assets"

import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.breeze.components
import org.kde.kirigami 2.20 as Kirigami
Item {
    id: root
    height: 1080
    width: 1920

    QtObject {

        readonly property var localFont: FontLoader {
            id: localFont
            source: "assets/fonts/Poppins-Regular.ttf"
        }


    }

    property string selectedImage: ""
    property string selectedUsername: ""
    property string selectedSession: ""
    property string notificationMessage



BorderImage {
    id: backgroundImage

    height: parent.height
    width: parent.width
    anchors.fill: parent
        source: "assets/background.png"
        border { left: 0; top: 0; right: 0; bottom: 0;}
        asynchronous: true
        cache: true
        clip: true
        visible: true






}

QQC.StackView {
            id: mainStack
            anchors {
                left: parent.left
                right: parent.right
            }
            height: root.height
            initialItem: Login {
                id: userListComponent

}



}




PlasmaComponents.ToolButton {
                   id: virtualKeyboardButton


                        text: i18ndc("<font color=\"#FFFFFF\">plasma-desktop-sddm-theme</font>", "<font color=\"#FFFFFF\">Button to show/hide virtual keyboard</font>", "<font color=\"#FFFFFF\">Virtual Keyboard</font>")

                        font.family: localFont.name
                         font.pixelSize: 18
                         anchors.left: sessionButton.right
                         anchors.leftMargin: 50




                    icon.name: "input-keyboard"
                    icon.color: "white"





                   onClicked: {

                       userListComponent.password.forceActiveFocus();
                        inputPanel.showHide()
                   }
                   visible: inputPanel.status === Loader.Ready


                   containmentMask: Item {
                       parent: virtualKeyboardButton
                       anchors.fill: parent


                   }
               }


KeyboardButton {
    id: keyboardButton

    onKeyboardLayoutChanged: {

                        userListComponent.password.forceActiveFocus();
                    }


                    containmentMask: Item {
                        parent: keyboardButton
                        anchors.fill: parent
                        anchors.leftMargin: virtualKeyboardButton.visible
                    }
                }

VirtualKeyboardLoader {
            id: inputPanel

            z: 1

            screenRoot: root
            mainStack: mainStack
            mainBlock: userListComponent
            passwordField: userListComponent.password
        }
SessionButton {
       id: sessionButton
       x: 180
       y: 0

       onSessionChanged: {
            userListComponent.password.forceActiveFocus();
    }

}



Item {
    id: footer
    anchors {
        bottom: parent.bottom
        left: parent.left
        right: parent.right
        margins: Kirigami.Units.smallSpacing
    }
    height: Kirigami.Units.gridUnit * 3
    visible: true

    Rectangle {
        anchors.fill: parent
        color: "#222222"
        opacity: 0.9
        radius: 5
    }

    Row {
        anchors.centerIn: parent
        spacing: Kirigami.Units.largeSpacing

        PlasmaComponents.ToolButton {
            icon.name: "system-suspend"
            icon.color: "white"
            font.family: localFont.name
            text: "<font color=\"#FFFFFF\">Sleep</font>"
            onClicked: sddm.suspend()
            enabled: sddm.canSuspend
        }
        PlasmaComponents.ToolButton {
            icon.name: "system-reboot"
            icon.color: "white"
            font.family: localFont.name
            text: "<font color=\"#FFFFFF\">Restart</font>"
            onClicked: sddm.reboot()
            enabled: sddm.canReboot
        }
        PlasmaComponents.ToolButton {
            icon.name: "system-shutdown"
            icon.color: "white"
            font.family: localFont.name
            text: "<font color=\"#FFFFFF\">Shut Down</font>"
            onClicked: sddm.powerOff()
            enabled: sddm.canPowerOff
        }
    }
}






}
