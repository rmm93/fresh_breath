import 'package:flutter/material.dart';

import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:bubble/bubble.dart';

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
    AuthGoogle authGooglee =
        await AuthGoogle(fileJson: "assets/first-hpxaok-9db5da2dba28.json")
            .build();
    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/first-hpxaok-359644c56ff9.json")
            .build();
    //await AuthGoogle(fileJson: "assets/first-hpxaok-359644c56ff9.json")
    Dialogflow dialogFlow =
        await Dialogflow(authGoogle: authGoogle, language: Language.english);
    AIResponse aiResponse = await dialogFlow.detectIntent(query);

    //print(aiResponse.getListMessage()[0]["text"]["text"][0]);
    setState(() {
      messages.insert(0, {
        "data": 0,
        "message": aiResponse.getListMessage()[0]["text"]["text"][0].toString(),
      });
    });
  }

  final messageInsert = TextEditingController();
  List<Map> messages = List();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Know About Your AQI',
          ),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                  child: ListView.builder(
                      reverse: true,
                      padding: EdgeInsets.all(10.0),
                      itemCount: messages.length,
                      itemBuilder: (context, index) => chat(
                          messages[index]["message"].toString(),
                          messages[index]["data"]))),
              Divider(
                height: 3.0,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                          child: TextField(
                        controller: messageInsert,
                        decoration: InputDecoration.collapsed(
                            hintText: "Send your message",
                            hintStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18.0)),
                      )),
                      Container(
                        padding: EdgeInsets.only(bottom: 15.0),
                        margin: EdgeInsets.symmetric(horizontal: 4.0),
                        child: IconButton(
                          icon: Icon(
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
          ),
        ));
  }
}

Widget chat(String message, int data) {
  return Padding(
    padding: EdgeInsets.all(10.0),
    child: Bubble(
        radius: Radius.circular(15.0),
        color: data == 0 ? Colors.blue : Colors.purple,
        elevation: 0.0,
        alignment: data == 0 ? Alignment.topLeft : Alignment.topRight,
        nip: data == 0 ? BubbleNip.leftBottom : BubbleNip.rightTop,
        child: Padding(
          padding: EdgeInsets.all(2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: data == 0 ? Colors.white : Colors.white,
                // backgroundImage: AssetImage(
                //     data == 0 ? "assets/bot.png" : "assets/user.png"),
              ),
              SizedBox(
                width: 10.0,
              ),
              Flexible(
                  child: Text(
                message,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ))
            ],
          ),
        )),
  );
}
