import 'package:chatbot/chat/data/claude_api_service.dart';
import 'package:flutter/material.dart';

import '../model/message.dart';

class ChatProvider extends ChangeNotifier {
  // Claude API Service
  final _apiService = ClaudeApiService(
    apiKey:
        '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',
  );

  // Message & loading
  final List<Message> _messages = [];
  bool _isLoading = false;

  // Getters
  List<Message> get messages => _messages;

  bool get isLoading => _isLoading;

  // Send Message
  Future<void> sendMessage(String content) async {
    // prevent empty sends
    if (content.trim().isEmpty) return;

    // user message
    final userMessage = Message(
      content: content,
      timestamp: DateTime.now(),
      isUser: true,
    );

    // add user message to chat
    _messages.add(userMessage);

    // update the UI
    notifyListeners();

    // start loading...
    _isLoading = true;

    // update UI
    notifyListeners();

    // send message & receive response
    try {
      final response = await _apiService.sendMessage(content);

      // response message from AI
      final responseMessage = Message(
        content: response,
        timestamp: DateTime.now(),
        isUser: false,
      );

      // add to chat
      _messages.add(responseMessage);
    }
    // error...
    catch (e) {
      final errorMessage = Message(
        content: 'Sorry, I encountered an issue $e',
        timestamp: DateTime.now(),
        isUser: false,
      );

      // add message to chat
      _messages.add(errorMessage);
    }

    // finished loading...
    _isLoading = false;

    // update the UI
    notifyListeners();
  }
}
