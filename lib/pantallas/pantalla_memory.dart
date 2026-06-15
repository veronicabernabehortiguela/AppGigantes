import 'dart:math';

import 'package:flutter/material.dart';

import '../modelos/idioma.dart';

class PantallaMemory extends StatefulWidget {

  final Idioma idioma;

  const PantallaMemory({

    super.key,

    required this.idioma,
  });

  @override
  State<PantallaMemory> createState() =>
      _PantallaMemoryState();
}

class _PantallaMemoryState
    extends State<PantallaMemory> {

  // =====================================
  // DINOSAURIOS BASE
  // =====================================

  final List<Map<String, String>>
  dinosauriosBase = [

    {
      "nombre": "Braquiosaurio",

      "imagen":
      "assets/memory/braquiosaurio.png",
    },

    {
      "nombre": "T-Rex",

      "imagen":
      "assets/memory/trex.png",
    },

    {
      "nombre": "Estegosaurio",

      "imagen":
      "assets/memory/estegosaurio.png",
    },

    {
      "nombre": "Triceratops",

      "imagen":
      "assets/memory/triceratops.png",
    },

    {
      "nombre": "Parasaurolophus",

      "imagen":
      "assets/memory/parasaurolophus.png",
    },

    {
      "nombre": "Ankylosaurus",

      "imagen":
      "assets/memory/ankylosaurus.png",
    },
  ];

  // =====================================
  // TABLERO
  // =====================================

  late List<Map<String, String>>
  cartas;

  // =====================================
  // CARTAS DESTAPADAS
  // =====================================

  List<int> cartasDestapadas = [];

  // =====================================
  // CARTAS ENCONTRADAS
  // =====================================

  List<int> cartasEncontradas = [];

  @override
  void initState() {

    super.initState();

    prepararTablero();
  }

  // =====================================
  // PREPARAR TABLERO
  // =====================================

  void prepararTablero() {

    cartas = [

      ...dinosauriosBase,
      ...dinosauriosBase,
    ];

    cartas.shuffle(
      Random(),
    );
  }

  // =====================================
  // PULSAR CARTA
  // =====================================

  void pulsarCarta(
      int indice,
      ) {

    if (cartasDestapadas.contains(
      indice,
    )) {
      return;
    }

    if (cartasEncontradas.contains(
      indice,
    )) {
      return;
    }

    if (cartasDestapadas.length >= 2) {
      return;
    }

    setState(() {

      cartasDestapadas.add(
        indice,
      );
    });

    // =================================
    // COMPROBAR PAREJA
    // =================================

    if (cartasDestapadas.length == 2) {

      Future.delayed(

        const Duration(
          milliseconds: 700,
        ),

            () {

          final primera =
          cartasDestapadas[0];

          final segunda =
          cartasDestapadas[1];

          final nombrePrimera =

          cartas[primera]["nombre"];

          final nombreSegunda =

          cartas[segunda]["nombre"];

          // ===========================
          // SI SON IGUALES
          // ===========================

          if (nombrePrimera ==
              nombreSegunda) {

            cartasEncontradas.addAll([
              primera,
              segunda,
            ]);

            // ===========================
            // ¿MEMORY COMPLETADO?
            // ===========================

            if (cartasEncontradas.length ==
                cartas.length) {

              Future.delayed(

                const Duration(
                  milliseconds: 300,
                ),

                    () {

                  showDialog(

                    context: context,

                    barrierDismissible:
                    false,

                    builder: (_) {

                      return AlertDialog(

                        backgroundColor:
                        const Color(
                          0xFFE6C79C,
                        ),

                        shape:
                        RoundedRectangleBorder(

                          borderRadius:
                          BorderRadius.circular(
                            20,
                          ),
                        ),

                        // ===================
                        // TÍTULO
                        // ===================

                        title: Text(

                          "🎉 ${widget.idioma.textos["ganaste"]!}",

                          textAlign:
                          TextAlign.center,

                          style: const TextStyle(

                            fontWeight:
                            FontWeight.bold,

                            color:
                            Color(
                              0xFF5D4037,
                            ),
                          ),
                        ),

                        // ===================
                        // CONTENIDO
                        // ===================

                        content: Text(

                          widget.idioma.textos[
                          "memoryDino"
                          ]!,

                          textAlign:
                          TextAlign.center,

                          style: const TextStyle(

                            color:
                            Color(
                              0xFF5D4037,
                            ),

                            fontSize: 16,
                          ),
                        ),

                        // ===================
                        // BOTONES
                        // ===================

                        actions: [

                          Row(

                            mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly,

                            children: [

                              // ===============
                              // REINICIAR
                              // ===============

                              ElevatedButton(

                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                  );

                                  setState(() {

                                    cartasDestapadas
                                        .clear();

                                    cartasEncontradas
                                        .clear();

                                    prepararTablero();
                                  });
                                },

                                style:
                                ElevatedButton.styleFrom(

                                  backgroundColor:
                                  const Color(
                                    0xFF8D6E63,
                                  ),
                                ),

                                child: Text(

                                  widget.idioma.textos[
                                  "reiniciar"
                                  ]!,

                                  style: const TextStyle(

                                    color:
                                    Colors.white,
                                  ),
                                ),
                              ),

                              // ===============
                              // SALIR
                              // ===============

                              ElevatedButton(

                                onPressed: () {

                                  Navigator.pop(
                                    context,
                                  );

                                  Navigator.pop(
                                    context,
                                  );
                                },

                                style:
                                ElevatedButton.styleFrom(

                                  backgroundColor:
                                  const Color(
                                    0xFFA1887F,
                                  ),
                                ),

                                child: Text(

                                  widget.idioma.textos[
                                  "salir"
                                  ]!,

                                  style: const TextStyle(

                                    color:
                                    Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              );
            }
          }

          setState(() {

            cartasDestapadas.clear();
          });
        },
      );
    }
  }

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

              horizontal: 6,
              vertical: 2,
            ),

            child: Column(

              children: [

                const SizedBox(
                  height: 2,
                ),

                // =====================
                // TÍTULO
                // =====================

                Text(

                  widget.idioma.textos[
                  "memoryDino"
                  ]!,

                  style: const TextStyle(

                    fontSize: 22,

                    fontWeight:
                    FontWeight.bold,

                    color: Colors.brown,
                  ),
                ),

                const SizedBox(
                  height: 4,
                ),

                // =====================
                // TABLERO
                // =====================

                Expanded(

                  child: GridView.builder(

                    physics:
                    const NeverScrollableScrollPhysics(),

                    padding: EdgeInsets.zero,

                    itemCount:
                    cartas.length,

                    gridDelegate:

                    const SliverGridDelegateWithFixedCrossAxisCount(

                      crossAxisCount: 3,

                      crossAxisSpacing: 6,

                      mainAxisSpacing: 10,

                      childAspectRatio: 0.70,
                    ),

                    itemBuilder:
                        (context, index) {

                      final carta =
                      cartas[index];

                      final estaDestapada =

                      cartasDestapadas
                          .contains(
                        index,
                      );

                      final encontrada =

                      cartasEncontradas
                          .contains(
                        index,
                      );

                      final mostrarCarta =

                          estaDestapada ||
                              encontrada;

                      return GestureDetector(

                        onTap: () {

                          pulsarCarta(
                            index,
                          );
                        },

                        child: ClipRRect(

                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),

                          child: mostrarCarta

                              ? Image.asset(

                            carta["imagen"]!,

                            fit: BoxFit.contain,
                          )

                              : Image.asset(

                            "assets/memory/huevo.png",

                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}