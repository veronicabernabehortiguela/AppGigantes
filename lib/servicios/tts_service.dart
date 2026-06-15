import 'package:flutter_tts/flutter_tts.dart';

class TTSService {

  static final TTSService _instance =
  TTSService._internal();

  factory TTSService() => _instance;

  TTSService._internal();

  final FlutterTts _tts = FlutterTts();

  bool _isSpeaking = false;

  bool get isSpeaking => _isSpeaking;

  Future<void> init() async {

    await _tts.setSpeechRate(0.45);

    await _tts.setVolume(1.0);

    await _tts.setPitch(1.0);

    _tts.setStartHandler(() {

      _isSpeaking = true;
    });

    _tts.setCompletionHandler(() {

      _isSpeaking = false;
    });

    _tts.setCancelHandler(() {

      _isSpeaking = false;
    });
  }

  Future<void> speak({
    required String text,
    required String languageCode,
  }) async {

    bool disponible =
    await _tts.isLanguageAvailable(languageCode);

    // fallback automático

    if (!disponible) {

      languageCode = "en-US";
    }

    // parar audio anterior

    await _tts.stop();

    await _tts.setLanguage(languageCode);

    await _tts.speak(text);
  }

  Future<void> stop() async {

    await _tts.stop();

    _isSpeaking = false;
  }
}