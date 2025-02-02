const functions = require('firebase-functions/v1');
const admin = require('firebase-admin');

admin.initializeApp();

exports.fireNotification = functions.https.onCall((data, context) => {
    const { title, body, topic } = data;

    const message = {
        notification: {
            title: title,
            body: body,
        },
        topic: topic,
        android: {
            notification: {
                clickAction: "FLUTTER_NOTIFICATION_CLICK",
            }
        },
        apns: {
            payload: {
                aps: {
                    alert: {
                        title: title,
                        body: body
                    },
                    sound: 'default',
                }
            },
        }
    };
    return admin.messaging().send(message)
        .then(response => {
            console.log("Notification sent successfully:", response);
            return { success: true };
        })
        .catch(error => {
            console.error("Error sending notification:", error);
            throw new functions.https.HttpsError('internal', 'Error sending notification', error);
        });
});