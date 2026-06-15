import 'package:flutter_tts/flutter_tts.dart';

class ServicioAudio {

  // =====================================
  // INSTANCIA TTS
  // =====================================

  static final FlutterTts flutterTts =
  FlutterTts();

  // =====================================
  // INICIALIZAR
  // =====================================

  static Future inicializar()
  async {

    await flutterTts.setSpeechRate(
      0.45,
    );

    await flutterTts.setPitch(
      1.0,
    );
  }

  // =====================================
  // REPRODUCIR TEXTO
  // =====================================

  static Future reproducirTexto(
      String texto,
      ) async {

    await flutterTts.stop();

    await flutterTts.speak(
      texto,
    );
  }

  // =====================================
  // DETENER AUDIO
  // =====================================

  static Future detenerAudio()
  async {

    await flutterTts.stop();
  }
}