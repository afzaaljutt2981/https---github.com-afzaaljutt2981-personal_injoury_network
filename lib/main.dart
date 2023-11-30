import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:personal_injury_networking/ui/authentication/controller/auth_controller.dart';
import 'package:personal_injury_networking/ui/events/controller/events_controller.dart';
import 'package:personal_injury_networking/ui/myProfile/controller/my_profile_controller.dart';
import 'package:personal_injury_networking/ui/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

import 'package:rxdart/rxdart.dart';

// used to pass messages from event handler to the UI
// final _messageStreamController = BehaviorSubject<RemoteMessage>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();

    if (kDebugMode) {
      print("Handling a background message: ${message.messageId}");
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  await fMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  var pref = await SharedPreferences.getInstance();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    if (kDebugMode) {
      showOverlayNotification(navigatorKey.currentContext!, message);
    }

    // _messageStreamController.sink.add(message);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    if (kDebugMode) {
      showOverlayNotification(navigatorKey.currentContext!, message);
    }
  });
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => AuthController()),
    ChangeNotifierProvider(create: (_) => MyProfileController()),
    ChangeNotifierProvider(create: (_) => EventsController())
  ], child: MyApp()));
}

void showOverlayNotification(BuildContext context, RemoteMessage message) {
  if (message.notification!.body!.contains("Cancel") ||
      message.notification!.body!.contains("Started")) {
    Provider.of<MyProfileController>(context, listen: false).updateUserNotification(true);
  }
  showSimpleNotification(
      Text(
        message.notification?.title ?? '',
        style:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        message.notification?.body ?? '',
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      background: Colors.white,
      duration: const Duration(seconds: 3),
      position: NotificationPosition.top,
      leading: Image(
        height: 20.sp,
        width: 20.sp,
        image: const AssetImage('assets/images/logo_gif_final.gif'),
      ),
      context: context);
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: const MaterialColor(
          0xFF212E73,
          <int, Color>{
            50: Color(0xFF212E73),
            100: Color(0xFF212E73),
            200: Color(0xFF212E73),
            300: Color(0xFF212E73),
            400: Color(0xFF212E73),
            500: Color(0xFF212E73),
            600: Color(0xFF212E73),
            700: Color(0xFF212E73),
            800: Color(0xFF212E73),
            900: Color(0xFF212E73),
          },
        )),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: const SplashScreen(),
      ),
    );
  }
}
