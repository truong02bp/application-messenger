// void showNotification(RemoteNotification remoteNotification) async {
//   AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
//     Platform.isAndroid ? 'com.dfa.flutterchatdemo' : 'com.duytq.flutterchatdemo',
//     'Flutter chat demo',
//     'your channel description',
//     playSound: true,
//     enableVibration: true,
//     importance: Importance.max,
//     priority: Priority.high,
//   );
//   IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
//   NotificationDetails platformChannelSpecifics =
//   NotificationDetails(android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
//
//   print(remoteNotification);
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     remoteNotification.title,
//     remoteNotification.body,
//     platformChannelSpecifics,
//     payload: null,
//   );
// }