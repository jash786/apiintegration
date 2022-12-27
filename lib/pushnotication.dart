import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// ignore: prefer_const_constructors
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   "High Importance Notifications", // title
// description :'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackGroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling Background message : ${message.messageId}');
  print(message.data);
}

class FirebaseNotification {
  initilize() async {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackGroundHandler);

    // await flutterLocalNotificationsPlugin
    //     .resolvePlatformSpecificImplementation<
    //         AndroidFlutterLocalNotificationsPlugin>()
    //     ?.createNotificationChannel(channel);

    var initiizationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initiizationSettingsAndroid);
    Future<String?> token = FirebaseMessaging.instance.getToken();
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    token.toString(), message.notification!.title!,
                    channelDescription: message.notification!.body!,
                    icon: android.smallIcon)));
      }
    });
  }

  Future<String?> getToken() async {
    Future<String?> token = FirebaseMessaging.instance.getToken();
    print(token);
    return token;
  }
}
