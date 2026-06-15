import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../modelos/idioma.dart';

class PantallaPuzzle extends StatefulWidget {

  final Idioma idioma;

  const PantallaPuzzle({

    super.key,

    required this.idioma,
  });

  @override
  State<PantallaPuzzle> createState() =>
      _PantallaPuzzleState();
}

class _PantallaPuzzleState
    extends State<PantallaPuzzle> {

  // =====================================
  // LISTA DE PUZZLES
  // =====================================

  final List<String> puzzles = [

    "assets/puzzle/puzzle_1.png",
    "assets/puzzle/puzzle_2.png",
    "assets/puzzle/puzzle_3.png",
    "assets/puzzle/puzzle_4.png",
    "assets/puzzle/puzzle_5.png",
    "assets/puzzle/puzzle_6.png",
  ];

  // =====================================
  // PUZZLE ACTUAL
  // =====================================

  int puzzleActual = 0;

  // =====================================
  // PIEZAS
  // =====================================

  late List<int> piezas;

  // =====================================
  // SOLUCIÓN
  // =====================================

  final List<int> solucion = [

    0, 1, 2,
    3, 4, 5,
    6, 7, 8,
  ];

  // =====================================
  // IMAGEN CARGADA
  // =====================================

  ui.Image? imagen;

  // =====================================
  // PIEZA SELECCIONADA
  // =====================================

  int? piezaSeleccionada;

  @override
  void initState() {

    super.initState();

    iniciarPuzzle();

    cargarImagen();
  }

  // =====================================
  // CARGAR IMAGEN
  // =====================================

  Future<void> cargarImagen() async {

    final imagenAsset =

    AssetImage(
      puzzles[puzzleActual],
    );

    const configuracion =
    ImageConfiguration();

    final stream =

    imagenAsset.resolve(
      configuracion,
    );

    final listener =

    ImageStreamListener(

          (info, _) {

        setState(() {

          imagen = info.image;
        });
      },
    );

    stream.addListener(
      listener,
    );
  }

  // =====================================
  // INICIAR PUZZLE
  // =====================================

  void iniciarPuzzle() {

    piezas = List.generate(
      9,
          (index) => index,
    );

    piezas.shuffle(
      Random(),
    );

    while (

    listasIguales(
      piezas,
      solucion,
    )

    ) {

      piezas.shuffle(
        Random(),
      );
    }

    piezaSeleccionada = null;
  }

  // =====================================
  // SIGUIENTE PUZZLE
  // =====================================

  void siguientePuzzle() {

    setState(() {

      puzzleActual++;

      if (

      puzzleActual >=
          puzzles.length

      ) {

        puzzleActual = 0;
      }

      iniciarPuzzle();

      cargarImagen();
    });
  }

  // =====================================
  // COMPARAR LISTAS
  // =====================================

  bool listasIguales(
      List<int> a,
      List<int> b,
      ) {

    for (

    int i = 0;
    i < a.length;
    i++

    ) {

      if (a[i] != b[i]) {

        return false;
      }
    }

    return true;
  }

  // =====================================
  // ¿PIEZA CORRECTA?
  // =====================================

  bool piezaCorrecta(
      int indice,
      ) {

    return piezas[indice] == indice;
  }

  // =====================================
  // MOVER PIEZA
  // =====================================

  void moverPieza(
      int indice,
      ) {

    // =================================
    // SI YA ESTÁ BIEN
    // =================================

    if (piezaCorrecta(indice)) {

      return;
    }

    // =================================
    // PRIMER TOQUE
    // =================================

    if (piezaSeleccionada == null) {

      setState(() {

        piezaSeleccionada = indice;
      });

      return;
    }

    // =================================
    // SI LA PIEZA YA ESTÁ BIEN
    // =================================

    if (

    piezaCorrecta(
      piezaSeleccionada!,
    )

    ) {

      piezaSeleccionada = null;

      return;
    }

    // =================================
    // MISMA PIEZA
    // =================================

    if (piezaSeleccionada == indice) {

      setState(() {

        piezaSeleccionada = null;
      });

      return;
    }

    // =================================
    // INTERCAMBIO
    // =================================

    setState(() {

      final temporal =

      piezas[piezaSeleccionada!];

      piezas[piezaSeleccionada!] =
      piezas[indice];

      piezas[indice] =
          temporal;

      piezaSeleccionada = null;
    });

    // =================================
    // COMPROBAR VICTORIA
    // =================================

    if (

    listasIguales(
      piezas,
      solucion,
    )

    ) {

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

                title: Text(

                  "🧩 ${widget.idioma.textos["ganaste"]!}",

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

                content: Text(

                  widget.idioma.textos[
                  "puzzleDino"
                  ]!,

                  textAlign:
                  TextAlign.center,
                ),

                actions: [

                  Column(

                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      // =====================
                      // FILA SUPERIOR
                      // =====================

                      Row(

                        mainAxisAlignment:
                        MainAxisAlignment.spaceEvenly,

                        children: [

                          // =================
                          // REINICIAR
                          // =================

                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                              );

                              setState(() {

                                iniciarPuzzle();
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

                          // =================
                          // SIGUIENTE
                          // =================

                          ElevatedButton(

                            onPressed: () {

                              Navigator.pop(
                                context,
                              );

                              siguientePuzzle();
                            },

                            style:
                            ElevatedButton.styleFrom(

                              backgroundColor:
                              const Color(
                                0xFF6D4C41,
                              ),
                            ),

                            child: Text(

                              widget.idioma.textos[
                              "siguiente"
                              ]!,

                              style: const TextStyle(

                                color:
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      // =====================
                      // SALIR
                      // =====================

                      Center(

                        child: ElevatedButton(

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
            const EdgeInsets.all(
              20,
            ),

            child: Column(

              children: [

                const SizedBox(
                  height: 10,
                ),

                // =====================
                // TÍTULO
                // =====================

                Text(

                  widget.idioma.textos[
                  "puzzleDino"
                  ]!,

                  style: const TextStyle(

                    fontSize: 30,

                    fontWeight:
                    FontWeight.bold,

                    color:
                    Colors.brown,
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // =====================
                // TABLERO
                // =====================

                if (imagen != null)

                  Expanded(

                    child: AspectRatio(

                      aspectRatio: 1,

                      child: GridView.builder(

                        physics:
                        const NeverScrollableScrollPhysics(),

                        itemCount: 9,

                        gridDelegate:

                        const SliverGridDelegateWithFixedCrossAxisCount(

                          crossAxisCount: 3,

                          crossAxisSpacing: 4,

                          mainAxisSpacing: 4,
                        ),

                        itemBuilder:
                            (context, index) {

                          final pieza =
                          piezas[index];

                          return GestureDetector(

                            onTap: () {

                              moverPieza(
                                index,
                              );
                            },

                            child: AnimatedContainer(

                              duration:
                              const Duration(
                                milliseconds: 200,
                              ),

                              decoration: BoxDecoration(

                                border:

                                piezaSeleccionada == index

                                    ? Border.all(

                                  color:
                                  Colors.amber,

                                  width: 5,
                                )

                                    : piezaCorrecta(index)

                                    ? Border.all(

                                  color:
                                  Colors.blue,

                                  width: 4,
                                )

                                    : null,

                                borderRadius:
                                BorderRadius.circular(
                                  8,
                                ),
                              ),

                              child: CustomPaint(

                                painter:
                                PiezaPuzzlePainter(

                                  imagen!,

                                  pieza,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )

                else

                  const Expanded(

                    child: Center(

                      child:
                      CircularProgressIndicator(),
                    ),
                  ),

                const SizedBox(
                  height: 20,
                ),

                // =====================
                // REINICIAR
                // =====================

                ElevatedButton(

                  onPressed: () {

                    setState(() {

                      iniciarPuzzle();
                    });
                  },

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    Colors.brown,

                    padding:
                    const EdgeInsets.symmetric(

                      horizontal: 40,
                      vertical: 15,
                    ),
                  ),

                  child: Text(

                    widget.idioma.textos[
                    "reiniciar"
                    ]!,

                    style: const TextStyle(

                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Colors.white,
                    ),
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

// =====================================
// PAINTER PIEZA
// =====================================

class PiezaPuzzlePainter
    extends CustomPainter {

  final ui.Image imagen;

  final int pieza;

  PiezaPuzzlePainter(

      this.imagen,
      this.pieza,
      );

  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {

    final paint = Paint();

    final anchoOriginal =
        imagen.width / 3;

    final altoOriginal =
        imagen.height / 3;

    final columna =
        pieza % 3;

    final fila =
        pieza ~/ 3;

    final src = Rect.fromLTWH(

      columna * anchoOriginal,

      fila * altoOriginal,

      anchoOriginal,

      altoOriginal,
    );

    final dst = Rect.fromLTWH(

      0,

      0,

      size.width,

      size.height,
    );

    canvas.drawImageRect(

      imagen,

      src,

      dst,

      paint,
    );
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {

    return true;
  }
}