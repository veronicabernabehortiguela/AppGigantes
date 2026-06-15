import 'package:flutter/material.dart';

import '../servicios/servicio_idioma.dart';
import '../modelos/idioma.dart';

// =============================
// IMPORTS PANTALLAS
// =============================

import 'pantalla_talleres.dart';
import 'pantalla_qr.dart';
import 'pantalla_lista_dinosaurios.dart';
import 'pantalla_minijuegos.dart';

// =============================
// IMPORT IDIOMA
// =============================

import '../modelos/idioma.dart';

class PantallaInicio extends StatelessWidget {

  final Idioma idioma;

  const PantallaInicio({

    super.key,

    required this.idioma,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        width: double.infinity,

        decoration: const BoxDecoration(

          image: DecorationImage(

            image: AssetImage(
              "assets/fondos/fondo_dino.png",
            ),

            fit: BoxFit.cover,
          ),
        ),

        child: SafeArea(

          child: SingleChildScrollView(

            child: Column(

              children: [

                const SizedBox(height: 20),

                // =========================
                // BOTÓN QR
                // =========================

                crearBoton(

                  imagen:
                  "assets/fondos/boton_qr.png",

                  texto: ServicioIdioma.obtenerTexto(
                    "textoQR",
                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (_) =>

                            PantallaEscanear(
                              idioma: idioma,
                            ),
                      )
                    );
                  },
                ),

                const SizedBox(height: 5),

                // =========================
                // BOTÓN DINOSAURIOS
                // =========================

                crearBoton(

                  imagen:
                  "assets/fondos/boton_dinos.png",

                  texto: ServicioIdioma.obtenerTexto(
                    "textoDinosaurios",
                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>

                        const PantallaListaDinosaurios(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                // =========================
                // BOTÓN TALLERES
                // =========================

                crearBoton(

                  imagen:
                  "assets/fondos/boton_talleres.png",

                  texto: ServicioIdioma.obtenerTexto(
                    "textoTalleres",
                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>

                        const PantallaTalleres(),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 15),

                // =========================
                // BOTÓN MINIJUEGOS
                // =========================

                crearBoton(

                  imagen:
                  "assets/fondos/boton_minijuegos.png",

                  texto: ServicioIdioma.obtenerTexto(
                    "textoMinijuegos",
                  ),

                  onTap: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder: (context) =>

                            PantallaMinijuegos(
                              idioma: idioma,
                            ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ====================================
  // BOTÓN PERSONALIZADO
  // ====================================

  Widget crearBoton({

    required String imagen,

    required String texto,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Stack(

        alignment: Alignment.center,

        children: [

          // =========================
          // IMAGEN BOTÓN
          // =========================

          Image.asset(

            imagen,

            width: 630,
            height: 270,

            fit: BoxFit.contain,
          ),

          // =========================
          // TEXTO BOTÓN
          // =========================

          SizedBox(

            width: 220,
            height: 60,

            child: Transform.translate(

              offset: const Offset(0, -50),

              child: Center(

                child: Text(

                  texto,

                  textAlign: TextAlign.center,

                  style: const TextStyle(

                    fontSize: 22,

                    fontWeight: FontWeight.w700,

                    color: Color(0xFF4E342E),

                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}