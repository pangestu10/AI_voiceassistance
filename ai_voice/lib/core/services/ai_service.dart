import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AiService {
  final Dio _dio = Dio();

  // ignore: non_constant_identifier_names
  static final GROQ_API_KEY = dotenv.env['GROQ_API_KEY'];


  Future<String> getResponse(String message) async {
    try {
      final response = await _dio.post(
        "https://api.groq.com/openai/v1/chat/completions",
        options: Options(
          headers: {
            "Authorization": "Bearer $apiKey",
            "Content-Type": "application/json",
          },
        ),
        data: {
          "model": "llama-3.1-8b-instant",
          "messages": [
            {"role": "user", "content": message},
          ],
          "max_tokens": 1000,
          "temperature": 0.7,
        },
      );

      if (response.statusCode == 200) {
        return response.data["choices"][0]["message"]["content"];
      } else {
        throw Exception("API Error: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("AI Service Error: $e");
      return "Sorry, I encountered an error: ${e.toString()}";
    }
  }
}
