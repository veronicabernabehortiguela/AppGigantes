import 'package:flutter/material.dart';

import '../modelos/idioma.dart';

import 'pantalla_memory.dart';
import 'pantalla_puzzle.dart';
import 'pantalla_excava.dart';
import 'pantalla_alasJurasicas.dart';
import 'pantalla_dinoLucha.dart';
import 'pantalla_dinoHambre.dart';

class PantallaMinijuegos
    extends StatelessWidget {

  final Idioma idioma;

  const PantallaMinijuegos({

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

          child: Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 10,
            ),

            child: Column(

              children: [

                // =====================
                // TÍTULO
                // =====================

                Text(

                  idioma.textos[
                  "textoMinijuegos"
                  ]!,

                  style: const TextStyle(

                    fontSize: 34,

                    fontWeight:
                    FontWeight.bold,

                    color: Colors.brown,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // =====================
                // GRID MINIJUEGOS
                // =====================

                Expanded(

                  child: GridView.count(

                    crossAxisCount: 2,

                    mainAxisSpacing: 20,

                    crossAxisSpacing: 20,

                    childAspectRatio: 0.78,

                    children: [

                      // =================
                      // MEMORY
                      // =================

                      tarjetaMinijuego(

                        context: context,

                        titulo:

                        idioma.textos[
                        "memoryDino"
                        ]!,

                        imagen:
                        "assets/minijuegos/memory.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  PantallaMemory(
                                    idioma: idioma,
                                  ),
                            ),
                          );
                        },
                      ),

                      // =================
                      // PUZZLE
                      // =================

                      tarjetaMinijuego(

                        context: context,

                        titulo:

                        idioma.textos[
                        "puzzleDino"
                        ]!,

                        imagen:
                        "assets/minijuegos/puzzle.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  PantallaPuzzle(
                                    idioma: idioma,
                                  ),
                            ),
                          );
                        },
                      ),

                      // =================
                      // EXCAVA
                      // =================

                      tarjetaMinijuego(

                        context: context,

                        titulo:

                        idioma.textos[
                        "excavaFosiles"
                        ]!,

                        imagen:
                        "assets/minijuegos/excava.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  PantallaExcava(
                                    idioma: idioma,
                                  ),
                            ),
                          );
                        },
                      ),

                      // =================
                      // ALAS JURÁSICAS
                      // =================

                      tarjetaMinijuego(

                        context: context,

                        titulo:

                        idioma.textos[
                        "alasJurasicas"
                        ]!,

                        imagen:
                        "assets/minijuegos/alas.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  PantallaAlasJurasicas(
                                    idioma: idioma,
                                  ),
                            ),
                          );
                        },
                      ),

                      // =================
                      // DINO LUCHA
                      // =================

                      tarjetaMinijuego(

                        context: context,

                        titulo:

                        idioma.textos[
                        "dinoLucha"
                        ]!,

                        imagen:
                        "assets/minijuegos/dinoLucha.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                                  PantallaDinoLucha(
                                    idioma: idioma,
                                  ),
                            )

                          );
                        },
                      ),

                      tarjetaMinijuego(

                        context: context,

                        titulo: "HAMBRE_JURASICA",

                        imagen:
                        "assets/minijuegos/hambre.png",

                        onTap: () {

                          Navigator.push(

                            context,

                            MaterialPageRoute(

                              builder: (_) =>

                              const PantallaDinoHambre(),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  // =====================================
  // TARJETA MINIJUEGO
  // =====================================

  Widget tarjetaMinijuego({

    required BuildContext context,

    required String titulo,

    required String imagen,

    required VoidCallback onTap,
  }) {

    return GestureDetector(

      onTap: onTap,

      child: Column(

        children: [

          // =========================
          // IMAGEN
          // =========================

          Expanded(

            child: Container(

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(
                  22,
                ),

                boxShadow: [

                  BoxShadow(

                    color:
                    Colors.black.withOpacity(
                      0.25,
                    ),

                    blurRadius: 8,

                    offset:
                    const Offset(
                      0,
                      4,
                    ),
                  ),
                ],
              ),

              child: ClipRRect(

                borderRadius:
                BorderRadius.circular(
                  22,
                ),

                child: Image.asset(

                  imagen,

                  width: double.infinity,

                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          // =========================
          // NOMBRE
          // =========================

          Text(

            titulo == "HAMBRE_JURASICA"
                ? idioma.textos["hambreJurasica"]!
                : titulo,

            textAlign: TextAlign.center,

            style: TextStyle(

              fontSize:
              titulo == "HAMBRE_JURASICA"
                  ? 15
                  : 18,

              fontWeight: FontWeight.bold,

              color: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}