import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_price_base_webview/home.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// // TODO: Define the background message handler
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//  await Firebase.initializeApp();

//  if (kDebugMode) {
//    print("Handling a background message: ${message.messageId}");
//    print('Message data: ${message.data}');
//    print('Message notification22222222222222222222222222222222222: ${message.notification?.title}');
//    print('Message notification222222222222222222222222222222222222222: ${message.notification?.body}');
//  }
// }

Future<void> main() async {
  // TODO: Request permission
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    //  options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }

  // TODO: Register with FCM
  // It requests a registration token for sending messages to users from your App server or other trusted server environment.
  String? token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }
  // // TODO: Set up foreground message handler
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   if (kDebugMode) {
  //     print('Handling a foreground message: ${message.messageId}');
  //     print('Message data: ${message.data}');
  //     print('Message notification11111111111111111111111111111111111111111: ${message.notification?.title}');
  //     print('Message notification1111111111111111111111111111111111111111111: ${message.notification?.body}');
  //   }
  //   showMessageAlert(message);
  // });
  // // TODO: Set up background message handler
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MaterialApp(
    navigatorKey: navigatorKey,
    debugShowCheckedModeBanner: false,
    home: const MyApp(),
  ));
}

void showMessageAlert(RemoteMessage message) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${message.notification?.title ?? ''}'),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('${message.notification?.body ?? ''}'),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: 'Webview app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.red
      ),
      home: const HomeScreen(),
    );
  }
}

