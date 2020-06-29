import 'package:flutter/material.dart';

import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:bubble/bubble.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// void main() {
//   runApp(MaterialApp(
//     home: ChatBot(),
//   ));
// }

class ChatBot extends StatefulWidget {
  @override
  _ChatBotState createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  Future<void> response(query) async {
    final AuthGoogle authGooglee =
        await AuthGoogle(fileJson: "assets/first-hpxaok-9db5da2dba28.json")
            .build();
    final AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/first-hpxaok-359644c56ff9.json")
            .build();
    //await AuthGoogle(fileJson: "assets/first-hpxaok-359644c56ff9.json")
    final Dialogflow dialogFlow =
        await Dialogflow(authGoogle: authGoogle, language: Language.english);
    final AIResponse aiResponse = await dialogFlow.detectIntent(query);

    //print(aiResponse.getListMessage()[0]["text"]["text"][0]);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString(),
      });
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messages = [];

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'bot',
      child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Impact Bot',
            ),
            backgroundColor: Colors.red,
          ),
          body: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(10.0),
                  itemCount: messages.length,
                  itemBuilder: (context, index) => chat(
                      messages[index]["message"].toString(),
                      messages[index]["data"]),
                ),
              ),
              const Divider(
                height: 3.0,
              ),
              Container(
                  padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: TextField(
                        controller: messageInsert,
                        decoration: const InputDecoration.collapsed(
                            hintText: "Send your message",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                      )),
                      Container(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            size: 30.0,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            if (messageInsert.text.isEmpty) {
                              print("Empty");
                            } else {
                              setState(() {
                                messages.insert(0,
                                    {"data": 1, "message": messageInsert.text});
                              });
                              response(messageInsert.text);
                              messageInsert.clear();
                            }
                          },
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}

Widget chat(String message, int data) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Bubble(
        radius: const Radius.circular(15.0),
        color: data == 0 ? Colors.amber : Colors.deepOrangeAccent,
        elevation: 0.0,
        alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
        nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: data == 0
                    ? Colors.white.withOpacity(0.5)
                    : Colors.white.withOpacity(0.5),
                child: data == 0 ? const Icon(FontAwesomeIcons.robot) : const Icon(FontAwesomeIcons.userCircle),
                // backgroundImage: AssetImage(
                //     data == 0 ? "assets/bot.png" : "assets/user.png"),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        )),
  );
}
