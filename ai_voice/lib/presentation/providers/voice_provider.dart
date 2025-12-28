import 'package:flutter/material.dart';
import '../../core/services/speech_service.dart';
import '../../core/services/ai_service.dart';
import '../../core/services/tts_service.dart';

class VoiceProvider extends ChangeNotifier {
  final SpeechService _speech = SpeechService();
  final AiService _ai = AiService();
  final TtsService _tts = TtsService();

  bool isListening = false;
  bool isSpeaking = false;
  String userText = "";
  String aiText = "";

  Future<void> startListening() async {
    await _speech.init();
    isListening = true;
    notifyListeners();

    _speech.listen((text) {
      userText = text;
      notifyListeners();
    });
  }

  Future<void> stopListening() async {
    isListening = false;
    _speech.stop();
    notifyListeners();

    aiText = await _ai.getResponse(userText);
    notifyListeners();

    isSpeaking = true;
    notifyListeners();
    await _tts.speak(aiText);
    isSpeaking = false;
    notifyListeners();
  }

  Future<void> stopAiResponse() async {
    await _tts.stop();
    isSpeaking = false;
    notifyListeners();
  }

  void resetConversation() {
    userText = "";
    aiText = "";
    isListening = false;
    isSpeaking = false;
    _speech.stop();
    _tts.stop();
    notifyListeners();
  }
}
