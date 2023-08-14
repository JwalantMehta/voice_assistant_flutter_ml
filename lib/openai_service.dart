import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_assistant_flutter_ml/secret.dart';

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try{
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OpenAiKey",
        },
        body: jsonEncode({
          "model": "text-davinci-003",
          // "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'system',
              'content': 'Does this message want to generate anything related to image, art, or anything similar? $prompt . Simply answer yes or no',
            },
            {
              'role': 'user',
              'content': 'Hello!',
            },
          ],
        }),
      );
      print(res.body);
      if(res.statusCode == 200) {
        print("api executed");
      }else {
        print("API request failed with status code: ${res.statusCode}");
        print("Response body: ${res.body}");
        // Handle other error cases as needed
      }
      return "AI";
    }catch(e) {
      return e.toString();
    }
  }
  Future<String> chatGPT(String prompt) async {
    return "chatGPT";
  }
  Future<String> dallEAPI(String prompt) async {
    return "dallEAPI";
  }
}