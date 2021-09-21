import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:householdexecutives_mobile/main.dart';
import 'package:householdexecutives_mobile/bloc/future-values.dart';
import 'package:householdexecutives_mobile/model/purchases.dart';
import 'package:householdexecutives_mobile/ui/home/home-screen.dart';
import 'dart:io' show Platform;

class NotificationManager {

  var flutterLocalNotificationsPlugin;

  /// Instantiating a class of the [FutureValues]
  var futureValue = FutureValues();

  /// An Instance of the Random class in the Maths library
  Random _random = Random();

  NotificationManager() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if(Platform.isIOS ){
      requestIOSPermissions();
    }
    initNotifications();
  }

  getNotificationInstance() {
    return flutterLocalNotificationsPlugin;
  }

  void requestIOSPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future configurePendingInterviewNotifications() async {
    Future<List<Purchases>> list = futureValue.getAllPendingPurchases();
    await list.then((value) {
      int purchasesLength;
      if(value.isEmpty || value.length == 0){
        purchasesLength = 0;
      }
      else if (value.length > 0){
        int val = 0;
        for(int i = 0; i < value.length; i++){
          if(value[i].candidatePlan.any((element) => !element.interviewed)) {
            val += 1;
          }
        }
        purchasesLength = val;
        if(purchasesLength > 0){
          showTaskNotification(
              _random.nextInt(10000), 'Schedule Interview',
              'A candidate must be interviewed and appointed within 30 days or payment becomes valid.',
              DateTime.now().hour,
              DateTime.now().minute
          );
        }
      }
    }).catchError((e){
      print(e);
    });
  }

  /// Initialise the plugin.
  void initNotifications() async {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future showTaskNotification(
      int id, String title, String body, int hour, int minute) async {
    var time = new Time(hour, minute, 0);
    await flutterLocalNotificationsPlugin.show(
        id, title, body, getTaskPlatformChannelSpecifics(id), payload: 'task payload');
    print('Notification Successfully Scheduled at ${time.toString()} with id of $id');
  }

  getTaskPlatformChannelSpecifics(int id) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '$id',
        'Interview notifications',
        'Notifications for user reminding them of their pending interviews',
        importance: Importance.high,
        icon: '@mipmap/ic_launcher',
        styleInformation: BigTextStyleInformation(''),
        channelShowBadge: true,
        priority: Priority.max,
        //ticker: 'Notification Reminder'
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics
    );
    return platformChannelSpecifics;
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: MyApp.navigatorKey.currentContext,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text('Ok'),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              if(payload == 'task payload'){
                //print('notification payload: ' + payload);
                await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
            },
          )
        ],
      ),
    );
    //return Future.value(1);
  }

  Future onSelectNotification(String payload) async {
    print('Notification clicked');
    if (payload == null || payload.trim().isEmpty) {
      debugPrint('notification payload: ' + payload);
    }
    else if(payload == 'task payload'){
      //print('notification payload: ' + payload);
      await Navigator.push(
        MyApp.navigatorKey.currentContext,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  Future<void> scheduleTaskReminder(String name, DateTime date, String description) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '0',
      'Schedule Interview',
      'A candidate must be interviewed and appointed within 30 days or payment becomes valid.',
      importance: Importance.high,
      icon: '@mipmap/ic_launcher',
      styleInformation: BigTextStyleInformation(''),
      channelShowBadge: true,
      priority: Priority.max,
      //ticker: 'Notification Reminder'
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics
    );
    await flutterLocalNotificationsPlugin.schedule(
        _random.nextInt(3000),
        'Schedule Interview',
        'A candidate must be interviewed and appointed within 30 days or payment becomes valid.',
        date,
        platformChannelSpecifics
    );
  }

  void removeReminder(String notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
    print('Notification with id: $notificationId been removed successfully');
  }

}