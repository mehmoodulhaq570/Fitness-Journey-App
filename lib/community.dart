import 'package:flutter/material.dart';

class CommunityChatScreen extends StatefulWidget {
  @override
  _CommunityChatScreenState createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  List<Map<String, dynamic>> messages = [
    {"user": "Alice", "message": "Hey everyone! 👋", "isMe": false},
    {"user": "Bob", "message": "Hello Alice! How are you?", "isMe": true},
    {"user": "Charlie", "message": "Nice to see you all here! 😃", "isMe": false},
  ];

  final TextEditingController _messageController = TextEditingController();

  void sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          "user": "Me",
          "message": _messageController.text,
          "isMe": true,
        });
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    theme: ThemeData.dark();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.black26,
              child: Image.asset('assets/fitness_image.png'),
            ),
            SizedBox(width: 10),
            Text(" Fit Community Group", style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  user: messages[index]["user"],
                  message: messages[index]["message"],
                  isMe: messages[index]["isMe"],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[900],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                GestureDetector(
                  onTap: sendMessage,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.send, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String user;
  final String message;
  final bool isMe;

  ChatBubble({required this.user, required this.message, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              user,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70),
            ),
            SizedBox(height: 5),
            Text(
              message,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}



