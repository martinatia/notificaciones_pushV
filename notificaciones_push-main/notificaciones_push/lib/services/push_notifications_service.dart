//SHA1: A8:96:E6:FD:43:1A:DE:C0:46:56:E9:7A:7A:1A:44:A6:37:A5:80:CB



import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService{

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;


  static Future<void> _backgroundHandler (RemoteMessage message)async{
    //print('onBackground Handler ${ message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto']?? 'No data');
  }

  static Future<void> _onMessageHandler (RemoteMessage message)async{
    //print('On Message Handler ${ message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto']?? 'No data');

  }
  static Future<void> _onOpenMessageOpenApp(RemoteMessage message)async{
    //print('onMessageIoenApp Handler ${ message.messageId}');
    print(message.data);
    _messageStream.add(message.data['producto']?? 'No data');

  }

  static Future initializeApp()async {
    //push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print(token);


    //handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onOpenMessageOpenApp);



    //local notifications
  }

  static closeStreams(){
    _messageStream.close();
  }
}