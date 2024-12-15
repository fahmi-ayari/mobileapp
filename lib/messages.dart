import 'package:flutter/material.dart';

class MessageForumPage extends StatefulWidget {
  const MessageForumPage({Key? key}) : super(key: key);

  @override
  _MessageForumPageState createState() => _MessageForumPageState();
}

class _MessageForumPageState extends State<MessageForumPage> {
  bool isMessagesSelected = true; // To toggle between Messages and Forum

  // Fake conversation data
  final List<String> fakeMessages = ["Ahmed", "Oussema", "Adam", "Anis"];
  final List<String> fakeForumThreads = [
    "Camping Tips",
    "Best Places to Camp",
    "Share Your Gear",
    "Ask for Help"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Messages & Forum",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          // Horizontal Row for Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        isMessagesSelected ? Colors.yellow : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      isMessagesSelected = true;
                    });
                  },
                  child: const Text(
                    "Messages",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor:
                        isMessagesSelected ? Colors.black : Colors.yellow,
                  ),
                  onPressed: () {
                    setState(() {
                      isMessagesSelected = false;
                    });
                  },
                  child: const Text(
                    "Forum",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),

          // Dynamic Content
          Expanded(
            child: isMessagesSelected
                ? ListView.builder(
                    itemCount: fakeMessages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 24,
                          backgroundImage: AssetImage(
                              'assets/images/${fakeMessages[index]}.jpg'),
                          backgroundColor: Colors
                              .grey[300], // Fallback if image is unavailable
                        ),
                        title: Text(
                          fakeMessages[index],
                          style: TextStyle(color: Colors.white),
                        ),
                        subtitle: const Text(
                          "Tap to chat...",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatPage(
                                      userName: fakeMessages[index],
                                    )),
                          );
                        },
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: fakeForumThreads.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: const Icon(Icons.forum, color: Colors.yellow),
                        title: Text(fakeForumThreads[index],
                            style: TextStyle(color: Colors.white)),
                        subtitle: const Text("Join the discussion!"),
                        onTap: () {
                          // You can enhance this to open threaded discussions
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Forum thread: '${fakeForumThreads[index]}' clicked."),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class ChatPage extends StatefulWidget {
  final String userName;

  const ChatPage({Key? key, required this.userName}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController messageController = TextEditingController();
  final List<String> messages = []; // Store sent messages

  // Function to send a message
  void _sendMessage() {
    if (messageController.text.isNotEmpty) {
      setState(() {
        messages.add(messageController.text); // Add message to the list
        messageController.clear(); // Clear the input field
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            // User's Photo
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(
                'assets/images/${widget.userName}.jpg',
              ),
              backgroundColor: Colors.grey[700], // Fallback color
            ),
            const SizedBox(width: 12.0),
            // User's Name
            Text(
              widget.userName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              reverse: true, // Start from the bottom
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: Alignment.centerRight, // Align to the right
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.yellow[700], // Yellow bubble color
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                        bottomLeft: Radius.circular(16.0),
                      ),
                    ),
                    child: Text(
                      messages[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Input Field and Send Button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return Align(
                        alignment:
                            Alignment.centerRight, // Align message to the right
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.yellow[700], // Message bubble color
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                              bottomLeft: Radius.circular(16.0),
                            ),
                          ),
                          child: Text(
                            messages[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.yellow),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
