import 'dart:async';

import 'package:abrar_portfolio/app/screens/splash_screen/splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'app/constants/globals/size_config.dart';
import 'app/screens/home_page/home_page.dart';
import 'app/screens/home_page/home_page_provider.dart';
import 'firebase_options.dart';
import 'network_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  //
  // // Registers a background message handler to process messages when the app is in the background
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Requests the user's permission for displaying notifications
  await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // for Login Save
  /*SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString(AppKeys.loginSave);

  Widget initialPage = token != null ? HomePage() : const LoginPage();*/

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HomePageProvider()),
      ],
      child: MyApp(initialPage: HomePage()),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Widget initialPage;

  const MyApp({super.key, required this.initialPage});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isConnected = false;
  bool _isCheckingConnection = true;

  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    super.initState();

    initConnectivity();

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen(_updateConnectionStatus);

    // Listen for foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground notification: ${message.notification?.title}');
    });

    // Listen for notification clicks (background or foreground)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification clicked: ${message.data}');
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
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> initConnectivity() async {
    setState(() {
      _isCheckingConnection = true;
    });

    List<ConnectivityResult> result;

    try {
      result = await Connectivity().checkConnectivity();
    } catch (e) {
      print('Could\'t check connection status : $e');
      result = [ConnectivityResult.none];
    }

    return _updateConnectionStatus(result);
  }

  Widget? _lastPage;

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    bool newConnectionStatus = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);

    if (mounted) {
      setState(() {
        _isConnected = newConnectionStatus;
        _isCheckingConnection = false;
      });

      if (!_isConnected) {
        // Save the current route before navigating to NetworkPage
        _lastPage = ModalRoute.of(MyApp.navigatorKey.currentContext!)
                ?.settings
                .arguments as Widget? ??
            widget.initialPage;

        MyApp.navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => NetworkPage(onRetry: _retryConnection),
          ),
        );
      } else {
        // Navigate back to the last page before network disconnection
        MyApp.navigatorKey.currentState?.pushReplacement(
          MaterialPageRoute(
            builder: (context) => _lastPage ?? widget.initialPage,
          ),
        );
      }
    }
  }

  void _retryConnection() {
    initConnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 829),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: MyApp.navigatorKey,
          title: 'Abrar Portfolio',
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          home: Builder(
            builder: (context) {
              if (_isCheckingConnection) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else {
                SizeConfig.init(context);
                return _isConnected
                    ? widget.initialPage
                    : NetworkPage(onRetry: _retryConnection);
              }
            },
          ),
        );
      },
    );
  }
}

// Background message handler to process notifications when the app is closed or in the background
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
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
