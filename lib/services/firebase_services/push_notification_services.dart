import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

import '../../app/screens/home_page/home_page.dart';
import '../../main.dart';

class PushNotificationServices {
  static String pushNotificationUrl =
      'https://fcm.googleapis.com/v1/projects/gymfluence-bca9c/messages:send';
  //static final GetServerKey getServerKey = GetServerKey();
  static final PushNotificationServices _instance =
      PushNotificationServices._internal();
  factory PushNotificationServices() => _instance;
  PushNotificationServices._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();

  /// Initial Firebase Notification Service
  Future<void> init() async {
    // Request permissions (iOS & Android 13+)
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    debugPrint('User granted permission: ${settings.authorizationStatus}');

    // Initialize local notification settings
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings();
    const initSettings =
        InitializationSettings(android: androidInit, iOS: iosInit);

    await _local.initialize(initSettings,
        onDidReceiveNotificationResponse: (response) {
      debugPrint("Notification tapped with payload: ${response.payload}");
    });

    // Foreground handler
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Foreground message: ${message.notification?.title}");
      _showLocalNotification(message);
    });

    // Background/terminated - when notification is tapped
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint(
          "App opened from background via notification: ${message.notification?.title}");

      _handleNotificationClick(message);
    });

    // Handle when the app is launched by a notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print('App opened by notification: ${message.data}');
        _handleNotificationClick(message);
      }
    });

    // Background handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Token print (can save to Firestore)
    String? token = await _fcm.getToken();
    debugPrint("FCM Token: $token");
  }

// Handle notification click
  void _handleNotificationClick(RemoteMessage message) {
    if (message.data.containsKey('page')) {
      String page = message.data['page'];

      switch (page) {
        case 'ProductDetailPage':
          if (message.data.containsKey('productId')) {
            String productId = message.data['productId'];
            String productSubCatId = message.data['productSubCatId'] ?? '';

            // Navigate to the ProductDetailPage
            MyApp.navigatorKey.currentState?.push(
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else {
            print(
                'Missing productId in notification data for ProductDetailPage.');
          }
          break;

        case 'NotificationFromAdminPage':
          MyApp.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
          break;

        case 'UsersAllSupportMsgPage':
          MyApp.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
          break;

        case 'HomePage':
        default:
          MyApp.navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
          break;
      }
    } else {
      print('No page information found in notification data.');
      MyApp.navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    }
  }

  void _showLocalNotification(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _local.show(
        notification.hashCode,
        notification.title,
        notification.body,
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'General Notifications',
            channelDescription: 'Used for general notifications',
            importance: Importance.max,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        payload: 'example_payload',
      );
    }
  }

  static Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    debugPrint("Handling background message: ${message.messageId}");
  }

  /// save device token into firebase
  Future<void> saveTokenToFireStore(String token) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'fcmToken': token});
        print('FCM token updated successfully for user ${user.uid}');
      } catch (error) {
        print('Failed to update FCM token: $error');
      }
    }
  }

  /// Send notification to a specific FCM token
  // static Future<void> sendNotificationToToken(String token) async {
  //   String accessApiKey = await getServerKey.getServerKeyToken();
  //
  //   var response = await http.post(
  //     Uri.parse(pushNotificationUrl),
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $accessApiKey',
  //     },
  //     body: jsonEncode({
  //       "message": {
  //         "token": token,
  //         "notification": {
  //           "title": 'New Message',
  //           "body": 'body Message',
  //         },
  //         "data": {
  //           "click_action": "FLUTTER_NOTIFICATION_CLICK",
  //           "message": "Sample Notification Message",
  //         },
  //       }
  //     }),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     debugPrint("✅ Notification sent successfully");
  //   } else {
  //     debugPrint("❌ Failed to send notification: ${response.statusCode}");
  //     debugPrint("🔍 Response: ${response.body}");
  //   }
  // }

  /// If user Subscribe then get notification topic wise
  void _subscribeUserToTopic(
      {required String categoryName, required bool isSelected}) {
    if (isSelected) {
      _fcm.subscribeToTopic(categoryName).then((_) {
        print('User subscribed to topic: $categoryName');

        /*Fluttertoast.showToast(
          msg: 'Subscribed notification to topic: $categoryName',
          backgroundColor: Colors.green,
        );*/
      }).catchError((e) {
        print('Error subscribing to topic: $e');
      });
    } else {
      _fcm.unsubscribeFromTopic(categoryName).then((_) {
        /*Fluttertoast.showToast(
          msg: 'Unsubscribed notification to topic: $categoryName',
          backgroundColor: Colors.red,
        );*/
        print('User unsubscribed to topic: $categoryName');
      }).catchError((e) {
        print('Error subscribing to topic: $e');
      });
    }
  }
}
