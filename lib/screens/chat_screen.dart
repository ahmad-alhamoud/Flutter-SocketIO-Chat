import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  IO.Socket? socket;
  TextEditingController? msg;

  List<String> msgs = [];

  @override
  void initState() {
    msg = TextEditingController();
    initTheSocket();
    super.initState();
  }

  Map<String, dynamic> options = {
    'transports': ['websocket'],
    'autoConnect': false
  };

  initTheSocket() {
    socket = IO.io('http://localhost:3000/', options);
    socket!.connect();

    socket!.onConnect((data) {
      if (kDebugMode) {
        print('Connected with the Server');
      }
    });

    socket!.on('response', (data) {
      msgs.add(data);
      setState(() {});
    });
  }

  @override
  void dispose() {
    msg!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(msgs);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App Socket'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: height * 0.04,
          ),
          Expanded(
              child: Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: width * 0.40,
              child: ListView.builder(
                  itemCount: msgs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: width * 0.15),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          msgs[index],
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  }),
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: width * 0.45,
                height: height * 0.15,
                child: TextFormField(
                  controller: msg,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.text,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Colors.blue.withOpacity(0.5),
                      filled: true,
                      hintText: 'Write a message',
                      hintStyle: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.normal)),
                ),
              ),
              SizedBox(
                width: 20,
              ) ,
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.06),
                child: FloatingActionButton(
                  onPressed: () {
                    socket!.emit('message', msg!.text);
                    msg!.clear();
                  },
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
