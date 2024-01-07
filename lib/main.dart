import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_client/screens/chat_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:http/http.dart' as http;

void main() async {


  /*

    to use this project you run the nodejs server on the next branch

    and the flutter client app on the chrome

    Thank you...

  */
  //
  // Map<String, dynamic> options = {
  //   'transports': ['websocket'],
  //   'autoConnect': false
  // };
  //
  // IO.Socket socket = IO.io('http://localhost:3000/', options);
  // socket.connect();
  //
  // socket.onConnect((data) {
  //   if (kDebugMode) {
  //     print('connected with the server');
  //   }
  //
  // });

  // socket.onDisconnect((_) {
  //   if (kDebugMode) {
  //     print('disconnected with the server') ;
  //   }
  // });


  // socket.emit('message', {
  //  'name' : 'ahmad' ,
  //   'age' : 23
  // });
  //
  // socket.on('response', (data){
  //   if (kDebugMode) {
  //     print(data) ;
  //   }
  // });


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Socket Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: ChatScreen()
    );
  }
}
