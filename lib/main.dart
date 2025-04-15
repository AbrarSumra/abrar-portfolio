import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
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
