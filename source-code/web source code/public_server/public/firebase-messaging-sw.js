importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js');
let config = {
        apiKey: "AIzaSyAmEHBVJDjpH9W9MOUAPsAjrdZPldqxf3Y",
        authDomain: "kahumbo-4e6e7.firebaseapp.com",
        projectId: "kahumbo-4e6e7",
        storageBucket: "kahumbo-4e6e7.firebasestorage.app",
        messagingSenderId: "3032888630",
        appId: "1:3032888630:web:acbd037e2d1242c5292f97",
        measurementId: "G-6DSM99PBCB",
 };
firebase.initializeApp(config);
const messaging = firebase.messaging();
messaging.onBackgroundMessage((payload) => {
    const notificationTitle = payload.notification.title;
    const notificationOptions = {
        body: payload.notification.body,
        icon: '/images/default/firebase-logo.png'
    };
    self.registration.showNotification(notificationTitle, notificationOptions);
});
