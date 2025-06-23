import 'dart:convert';

import 'package:http/http.dart' as http;

class ClaudeApiService {
  // API Constants
  static const String _baseUrl = 'https://api.anthropic.com/v1/messages';
  static const String _apiVersion = '2023-06-01';
  static const String _model = 'claude-3-opus-20240229';
  static const int _maxTokens = 1024;

  // Store the API Key securely
  final String _apiKey;

  // Require API Key
  ClaudeApiService({required String apiKey}) : _apiKey = apiKey;

  // Send message to Claude API & return the response

  Future<String> sendMessage(String content) async {
    try {
      // Make POST Request to claude API
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: _getHeaders(),
        body: _getRequestBody(content),
      );

      // Check if request was successful
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final textContent = data['content']?[0]?['text'];
        if (textContent != null) {
          return textContent;
        } else {
          throw Exception('Invalid response format: ${response.body}');
        }
      }
      // handle unsuccessful response
      else {
        throw Exception(
          'Failed to get response from Claude: ${response.statusCode} ',
        );
      }
    } catch (e) {
      // handle any errors during api call
      throw Exception('API Error: $e');
    }
  }

  // create required headers for Claude API
  Map<String, String> _getHeaders() => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $_apiKey',
    'anthropic-version': _apiVersion,
  };

  // format request body according to Claude API specific
  String _getRequestBody(String content) => jsonEncode({
    'model': _model,
    'messages': [
      // format messages in Claude's required structure
      {'role': 'user', 'content': content},
    ],
    'max_tokens': _maxTokens,
  });
}
