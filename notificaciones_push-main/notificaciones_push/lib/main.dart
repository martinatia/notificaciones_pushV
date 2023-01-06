import 'package:flutter/material.dart';
import 'package:notificaciones_push/screens/screens.dart';
import 'package:notificaciones_push/services/push_notifications_service.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    // Context
    PushNotificationService.messageStream.listen((message) { 
      // print('MyApp: $message');
      navigatorKey.currentState?.pushNamed('message',arguments: message);
      final snackBar = SnackBar(content: Text(message));
      messengerKey.currentState?.showSnackBar(snackBar);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,//Navegar
      scaffoldMessengerKey: messengerKey,//Snacks
      routes: {
        'home': ( _ ) => HomeScreen(),
        'message':( _ ) =>MessageScreen()
      },
    );
  }
}