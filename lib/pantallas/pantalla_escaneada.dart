import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import '../dao/contenido_dao.dart';
import '../servicios/database_service.dart';
import '../modelos/idioma.dart';
import '../widgets/audio_widget.dart';

import '../modelos/contenido.dart';

class PantallaEscaneada extends StatelessWidget {
  final Contenido contenido;
  final Idioma idioma;

  const PantallaEscaneada({
    super.key,
    required this.contenido,
    required this.idioma,
  });

  @override
  Widget build(BuildContext context) {
    final String rutaImagen =
        'assets/imagenes/${contenido.img}';

    return Scaffold(
      backgroundColor: const Color(0xFFADD8E6),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Column(
            children: [
              // TÍTULO
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),

                child: Text(
                  contenido.titulo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // IMAGEN AMPLIABLE
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),

                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ImagenCompleta(
                          rutaImagen: rutaImagen,
                        ),
                      ),
                    );
                  },

                  child: Hero(
                    tag: rutaImagen,

                    child: Image.asset(
                      rutaImagen,
                      height: 220,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // AUDIO
              AudioWidget(
                audio: contenido.audio,
              ),

              const SizedBox(height: 20),

              // DESCRIPCIÓN
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 2,
                    color: Colors.black,
                  ),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idioma.textos["descripcion"]!,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    SelectableText(
                      contenido.descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImagenCompleta extends StatelessWidget {
  final String rutaImagen;

  const ImagenCompleta({
    super.key,
    required this.rutaImagen,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),

      body: Hero(
        tag: rutaImagen,

        child: PhotoView(
          imageProvider: AssetImage(rutaImagen),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 5,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}