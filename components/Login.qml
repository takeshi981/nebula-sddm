import QtQuick 2.15
import QtQuick.Controls 2.4 as QQC
import Qt5Compat.GraphicalEffects 1.0
import org.kde.plasma.plasma5support 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents
import org.kde.breeze.components
import org.kde.kirigami 2.20 as Kirigami

Rectangle {
    id: form
    x: 738
    y: 58
    width: 445
    height: 604
    visible: true
    radius: 10
    anchors.centerIn: parent
    property bool isUserListVisible: false
    property Item password: password

Item {
    id: clock

    ShowClock {

        x: 228
        y: 0

    }
}



    QQC.TextField {
        id: username

        x: 46
        y: 376
        width: 362
        height: 40
        text: userList.defaultUser
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 11

        font.family: localFont.name
        antialiasing: false
        placeholderText: qsTr("Username")
        background: Rectangle {color: "#eaeaea"; radius: 10 ;border.width: 0}

    }

    QQC.TextField {
        id: password
        x: 46
        y: 438
        width: 362
        height: 40
        horizontalAlignment: Text.AlignHCenter
        font.pointSize: 11
        font.family: localFont.name
        echoMode: TextInput.Password
        activeFocusOnPress: true
        focus: true
        placeholderText: qsTr("Password")
        background: Rectangle {color: "#eaeaea"; radius: 10}
        onAccepted: loginButton.clicked()
    }




    Item {
        z: 10
        Image {
        id: userImage
        x: 150
        y: 100

        width: 150
        height: width
        source: userList.defaultImage
        asynchronous: true
        cache: true
        clip: true
        visible: true
        anchors.fill: parent.fill
        property bool rounded: true
        property bool adapt: true
        //@disable-check M16
        layer.enabled: true
        //@disable-check M16
        layer.effect: OpacityMask {
            maskSource: Item {
                width: userImage.width
                height: userImage.height
                Rectangle {
                    anchors.centerIn: parent
                    width: userImage.adapt ? userImage.width : Math.min(userImage.width, userImage.height)
                    height: userImage.adapt ? userImage.height : width
                    radius: Math.min(width, height)
                }
            }
        }


        MouseArea {
            width: userImage.width
            height: userImage.height
            onClicked: {
                console.log("Image clicked!");
                isUserListVisible = !isUserListVisible;
            }
        }

    }
}

UsersList {
    id: userList
    x: 0
    y: -90
    z: 0

    visible: isUserListVisible

    onUserSelected: {
        userImage.source = userList.selectedImage;
        username.text = userList.selectedUsername;
        password.forceActiveFocus();
        isUserListVisible = false;
    }
}
PlasmaComponents.Label  {
    id: notificationMessage
    width: 240
    x: 190
    y: 550
    anchors.fill: parent.fill


    visible: true
    color: "red"
    text: ""
    font.family: localFont.name

}
QQC.Button {
    id: loginButton

    y: 550
    width: 240
    height: 40
    text: qsTr("Log In")
    font.family: localFont.name
    anchors.verticalCenter: parent.verticalCenter
    highlighted: true
    flat: true
    icon.color: "#2c2d2d"
    anchors.verticalCenterOffset: 212
    anchors.horizontalCenterOffset: 1
    checkable: true
    anchors.horizontalCenter: parent.horizontalCenter
    background: Rectangle { color: "#2278cd"; radius: 10
        border.color: "#f9f9f9"
        border.width: 0 }
        onClicked: { sddm.login(username.text.toLowerCase(), password.text, sessionButton.currentIndex) }
    Keys.onReturnPressed: clicked()
    Keys.onEnterPressed: clicked()

}
Connections {
    target: sddm
    function onLoginFailed() {
        notificationMessage.text = i18nd("plasma_lookandfeel_org.kde.lookandfeel", "Login Failed")
    }
    function onLoginSucceeded() {}
}
}
