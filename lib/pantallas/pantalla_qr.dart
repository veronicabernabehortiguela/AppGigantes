import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../dao/contenido_dao.dart';
import '../modelos/contenido.dart';
import '../servicios/database_service.dart';
import 'pantalla_escaneada.dart';
import '../modelos/idioma.dart';

class PantallaEscanear extends StatefulWidget {
  final Idioma idioma;

  const PantallaEscanear({
    super.key,
    required this.idioma,
  });

  @override
  State<PantallaEscanear> createState() => _PantallaEscanearState();
}

class _PantallaEscanearState extends State<PantallaEscanear> {
  bool qrLeido = false;
  bool cargandoBD = true;

  late ContenidoDAO contenidoDAO;

  final MobileScannerController controller =
  MobileScannerController(
    detectionSpeed:
    DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  @override
  void initState() {
    super.initState();
    inicializarDAO();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> inicializarDAO() async {

    try {

      print("PASO 1");

      final db =
      await DatabaseService.getDatabase();

      print("PASO 2");

      contenidoDAO =
          ContenidoDAO(db);

      print("PASO 3");

      if (mounted) {

        setState(() {

          cargandoBD = false;

        });
      }

    } catch (e) {

      print("ERROR BD: $e");

    }
  }

  String textoIdioma() {
    return widget.idioma.nombre;
  }

  String idiomaBD() {
    return widget.idioma.codigo;
  }

  Future<void> procesarQR(String codigoQR) async {
    try {
      final Contenido? contenido =
      await contenidoDAO.obtenerContenido(
        codigoQR,
        idiomaBD(),
      );

      if (!mounted) return;

      if (contenido == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                widget.idioma.textos["qrNoEncontrado"]!,
              ),
            ),
          );

        qrLeido = false;
        return;
      }

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PantallaEscaneada(
            contenido: contenido,
            idioma: widget.idioma,
          ),
        ),
      ).then((_) {
        qrLeido = false;
      });
    } catch (e) {
      qrLeido = false;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cargandoBD) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFADD8E6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 40,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),

                  const Spacer(),

                  Text(
                    textoIdioma(),
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              widget.idioma.textos["escanearQR"]!,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      MobileScanner(
                        controller: controller,

                        errorBuilder: (
                            BuildContext context,
                            MobileScannerException error,
                            ) {
                          return Container(
                            color: Colors.black,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Text(
                                  '''
ERROR MOBILE SCANNER

Código:
${error.errorCode}

Mensaje:
${error.errorDetails?.message ?? "Sin mensaje"}
''',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },

                        onDetect: (capture) async {
                          if (qrLeido) return;

                          final codigoQR =
                              capture.barcodes.first.rawValue;

                          if (codigoQR == null) return;

                          qrLeido = true;

                          await procesarQR(codigoQR);
                        },
                      ),

                      IgnorePointer(
                        child: Center(
                          child: Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white,
                                width: 5,
                              ),
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 30,
                        left: 20,
                        right: 20,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius:
                            BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.idioma.textos["cargando"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}