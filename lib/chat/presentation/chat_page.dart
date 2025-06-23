import 'package:chatbot/chat/components/my_send_button.dart';
import 'package:chatbot/chat/components/my_text_field.dart';
import 'package:chatbot/chat/presentation/chat_bubble.dart';
import 'package:chatbot/chat/presentation/chat_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Stack(
          children: [
            // Main UI
            Column(
              children: [
                // top Section : chat messages
                Expanded(
                  child: Consumer<ChatProvider>(
                    builder: (context, chatProvider, child) {
                      if (chatProvider.messages.isEmpty) {
                        return Center(
                          child: Text(
                            'Start a Conversation...',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                      return ListView.builder(
                        itemCount: chatProvider.messages.length,
                        itemBuilder: (context, index) {
                          final message = chatProvider.messages[index];
                          return ChatBubble(message: message);
                        },
                      );
                    },
                  ),
                ),

                // user input box
                Padding(
                  padding: const EdgeInsets.only(
                    left: 15.0,
                    right: 15.0,
                    bottom: 15.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(child: MyTextField(controller: _controller)),
                      IconButton(
                        onPressed: () {
                          if (_controller.text.isNotEmpty) {
                            final chatProvider = context.read<ChatProvider>();
                            chatProvider.sendMessage(_controller.text);
                            _controller.clear();
                          }
                        },
                        icon: MySendButton(),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // Centered Loading Spinner Overlay
            Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                if (chatProvider.isLoading) {
                  return Center(child: CircularProgressIndicator());
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
