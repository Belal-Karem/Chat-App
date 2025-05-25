import 'package:belal/constants.dart';
import 'package:belal/widgets/chat_Buble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:belal/model/message.dart';

class ChatPage extends StatefulWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    print(email);
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Message> messagelist = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messagelist.add(
              Message.fromjson(
                snapshot.data!.docs[i].data() as Map<String, dynamic>,
              ),
            );
          }
          print('id: ${messagelist[1].id}');

          return Scaffold(
            appBar: AppBar(
              backgroundColor: kprimaryColor,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    klogo,
                    height: 50,
                  ),
                  Text(
                    'Chat App',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagelist.length,
                    itemBuilder: (context, index) {
                      final message = messagelist[index];
                      return message.id == email
                          ? ChatBuble(message: message)
                          : ChatBubleForFriend(message: message);
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(16),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kmessage: data,
                        kCreatedAt: DateTime.now(),
                        kid: email,
                      });
                      controller.clear();
                      _controller.animateTo(
                          // animateTo==> بتنزل بشكل ثالث     //==> = jumpTo==> مش بتعمل اسكرول لي تحت بتنط علطول لي تحت
                          0,
                          duration: Duration(seconds: 0),
                          curve: Curves.easeIn //==> الشكل و هوا نازل
                          );
                    },
                    decoration: InputDecoration(
                      hintText: 'Sent Massage',
                      suffixIcon: Icon(
                        Icons.send,
                        color: kprimaryColor,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: kprimaryColor,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return ModalBarrier(
            dismissible: true,
          );
        }
      },
    );
  }
}
