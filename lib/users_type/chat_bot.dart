import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  final String buyerId;
  final String sellerId;

  const ChatPage({required this.buyerId, required this.sellerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'),
      ),
      body: ChatScreen(buyerId: buyerId, sellerId: sellerId),
    );
  }
}

class ChatScreen extends StatelessWidget {
  final String buyerId;
  final String sellerId;
  final TextEditingController _textController = TextEditingController();

  ChatScreen({required this.buyerId, required this.sellerId});

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      FirebaseFirestore.instance.collection('messages').add({
        'senderId': buyerId,
        'receiverId': sellerId,
        'message': message,
        'timestamp': Timestamp.now(),
      });
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .where('senderId', isEqualTo: buyerId)
                .where('receiverId', isEqualTo: sellerId)
                .orderBy('timestamp', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var message = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(
                        message['message'],
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: () => _sendMessage(_textController.text),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
