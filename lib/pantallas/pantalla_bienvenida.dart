import 'package:flutter/material.dart';

// Datos idiomas
import '../datos/idiomas.dart';

// Modelo idioma
import '../modelos/idioma.dart';

// Pantalla siguiente
import '../pantallas/pantalla_inicio.dart';

// Servicio global
import '../servicios/servicio_idioma.dart';

// Widget personalizado
import '../widgets/boton_idioma.dart';

// Fuentes
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_state.dart';

// =====================================
// PANTALLA BIENVENIDA
// =====================================

class PantallaBienvenida
    extends StatefulWidget {

  const PantallaBienvenida({
    super.key,
  });

  @override
  State<PantallaBienvenida>
  createState() =>

      _PantallaBienvenidaState();
}

// =====================================
// ESTADO PANTALLA
// =====================================

class _PantallaBienvenidaState
    extends State<PantallaBienvenida> {

  // ===================================
  // IDIOMA SELECCIONADO
  // ===================================

  Idioma? idiomaSeleccionado;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SafeArea(

        child: Container(

          width: double.infinity,

          padding:
          const EdgeInsets.all(
            20,
          ),

          // =========================
          // FONDO
          // =========================

          decoration: const BoxDecoration(

            image: DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_dino.png",
              ),

              fit: BoxFit.cover,
            ),
          ),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.spaceEvenly,

            children: [

              // =========================
              // LOGO
              // =========================

              Image.asset(

                "assets/logo/logo.png",

                width: 400,
              ),

              // =========================
              // TEXTO BIENVENIDA
              // =========================

              Text(

                idiomaSeleccionado == null

                    ? "¡BIENVENIDO!"

                    : idiomaSeleccionado!
                    .textos[
                "bienvenida"
                ]!,

                textAlign:
                TextAlign.center,

                style:
                GoogleFonts.luckiestGuy(

                  fontSize: 42,

                  color:
                  const Color(
                    0xFFF1CC0D,
                  ),

                  letterSpacing: 2.0,

                  shadows: [

                    // CONTORNO

                    const Shadow(

                      offset:
                      Offset(-3, -3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(3, -3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(3, 3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(-3, 3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(0, -3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(0, 3),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(-3, 0),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),

                    const Shadow(

                      offset:
                      Offset(3, 0),

                      color:
                      Color(
                        0xFF421D12,
                      ),
                    ),
                  ],
                ),
              ),

              // =========================
              // BOTÓN CONTINUAR
              // =========================

              GestureDetector(

                onTap:
                idiomaSeleccionado == null

                    ? null

                    : () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) =>

                          PantallaInicio(

                            idioma:
                            idiomaSeleccionado!,
                          ),
                    ),
                  );
                },

                child: Opacity(

                  opacity:

                  idiomaSeleccionado == null

                      ? 0.5

                      : 1,

                  child: Container(

                    width: 460,
                    height: 210,

                    decoration:
                    const BoxDecoration(

                      image:
                      DecorationImage(

                        image: AssetImage(

                          "assets/fondos/boton_continuar.png",
                        ),

                        fit: BoxFit.cover,
                      ),
                    ),

                    alignment:
                    Alignment.center,

                    child: Text(

                      idiomaSeleccionado == null

                          ? "Continuar"

                          : idiomaSeleccionado!
                          .textos[
                      "continuar"
                      ]!,

                      style:
                      const TextStyle(

                        fontSize: 28,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        Colors.brown,
                      ),
                    ),
                  ),
                ),
              ),

              // =========================
              // BOTONES IDIOMAS
              // =========================

              Wrap(

                alignment:
                WrapAlignment.center,

                spacing: 15,

                runSpacing: 15,

                children:

                idiomas.map((idioma) {

                  return SizedBox(

                    width: 95,

                    child: BotonIdioma(

                      idioma: idioma,

                      alPulsar: () {

                        setState(() {

                          idiomaSeleccionado =
                              idioma;

                          // =================
                          // GUARDAR IDIOMA
                          // =================

                          AppState.selectedLanguage =
                              idioma.codigo;
                        });

                        // =================
                        // CAMBIAR IDIOMA
                        // =================

                        ServicioIdioma
                            .cambiarIdioma(
                          idioma,
                        );
                      },
                    ),
                  );

                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}