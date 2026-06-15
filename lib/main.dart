//main.dart

import 'package:flutter/material.dart';

import 'pantallas/pantalla_bienvenida.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'pantallas/pantalla_qr.dart';

import 'servicios/servicio_audio.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // =====================================
  // FIREBASE
  // =====================================

  await Firebase.initializeApp(

    options:
    DefaultFirebaseOptions
        .currentPlatform,
  );

  // =====================================
  // INICIALIZAR TTS
  // =====================================

  await ServicioAudio.inicializar();

  // =====================================
  // APP
  // =====================================

  runApp(
    const DinoApp(),
  );
}

class DinoApp extends StatelessWidget {

  const DinoApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      title: 'Gigantes',

      theme: ThemeData(

        primarySwatch:
        Colors.brown,

        scaffoldBackgroundColor:
        const Color(0xFFE2C18F),
      ),

      home:
      const PantallaBienvenida(),
    );
  }
}