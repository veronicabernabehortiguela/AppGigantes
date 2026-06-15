import 'package:flutter/material.dart';

import '../modelos/idioma.dart';

class PantallaExcava extends StatefulWidget {

  final Idioma idioma;

  const PantallaExcava({

    super.key,

    required this.idioma,
  });

  @override
  State<PantallaExcava> createState() =>
      _PantallaExcavaState();
}

class _PantallaExcavaState
    extends State<PantallaExcava> {

  // =====================================
  // KEY EXCAVACIÓN
  // =====================================

  final GlobalKey zonaKey =
  GlobalKey();

  // =====================================
  // PUNTOS EXCAVADOS
  // =====================================

  final List<Offset> puntos = [];

  // =====================================
  // PROGRESO
  // =====================================

  double progreso = 0;

  // =====================================
  // ¿COMPLETADO?
  // =====================================

  bool excavacionCompletada = false;

  // =====================================
  // EXCAVACIÓN ACTUAL
  // =====================================

  int excavacionActual = 0;

  // =====================================
  // LISTA EXCAVACIONES
  // =====================================

  final List<Map<String, String>>
  excavaciones = [

    {
      "huella":
      "assets/excava/huella_1.png",

      "polaroid":
      "assets/excava/polaroid_1.png",
    },

    {
      "huella":
      "assets/excava/huella_2.png",

      "polaroid":
      "assets/excava/polaroid_2.png",
    },

    {
      "huella":
      "assets/excava/huella_3.png",

      "polaroid":
      "assets/excava/polaroid_3.png",
    },

    {
      "huella":
      "assets/excava/huella_4.png",

      "polaroid":
      "assets/excava/polaroid_4.png",
    },

    {
      "huella":
      "assets/excava/huella_5.png",

      "polaroid":
      "assets/excava/polaroid_5.png",
    },
  ];

  // =====================================
  // AÑADIR PUNTO
  // =====================================

  void agregarPunto(
      Offset punto,
      ) {

    if (excavacionCompletada) {
      return;
    }

    setState(() {

      puntos.add(
        punto,
      );

      progreso =
          puntos.length / 1100;

      if (progreso > 1) {

        progreso = 1;
      }

      // ================================
      // COMPLETADO
      // ================================

      if (progreso >= 0.58) {

        excavacionCompletada =
        true;

        mostrarVentanaFinal();
      }
    });
  }

  // =====================================
  // VENTANA FINAL
  // =====================================

  void mostrarVentanaFinal() {

    Future.delayed(

      const Duration(
        milliseconds: 400,
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

              content: Column(

                mainAxisSize:
                MainAxisSize.min,

                children: [

                  // =================
                  // TEXTO
                  // =================

                  Text(

                    "🎉 ${widget.idioma.textos["ganaste"]!}",

                    textAlign:
                    TextAlign.center,

                    style: const TextStyle(

                      fontSize: 24,

                      fontWeight:
                      FontWeight.bold,

                      color:
                      Color(
                        0xFF5D4037,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  // =================
                  // POLAROID
                  // =================

                  ClipRRect(

                    borderRadius:
                    BorderRadius.circular(
                      15,
                    ),

                    child: Image.asset(

                      excavaciones[
                      excavacionActual
                      ]["polaroid"]!,

                      height: 260,

                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // =================
                  // BOTONES
                  // =================

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

                          reiniciarJuego();
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
                      // SIGUIENTE
                      // ===============

                      ElevatedButton(

                        onPressed: () {

                          Navigator.pop(
                            context,
                          );

                          siguienteExcavacion();
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

                  // =================
                  // SALIR
                  // =================

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
            );
          },
        );
      },
    );
  }

  // =====================================
  // REINICIAR
  // =====================================

  void reiniciarJuego() {

    setState(() {

      puntos.clear();

      progreso = 0;

      excavacionCompletada =
      false;
    });
  }

  // =====================================
  // SIGUIENTE EXCAVACIÓN
  // =====================================

  void siguienteExcavacion() {

    setState(() {

      excavacionActual++;

      if (

      excavacionActual >=
          excavaciones.length

      ) {

        excavacionActual = 0;
      }

      puntos.clear();

      progreso = 0;

      excavacionCompletada =
      false;
    });
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
            const EdgeInsets.all(20),

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
                  "tituloExcava"
                  ]!,

                  style: const TextStyle(

                    fontSize: 34,

                    fontWeight:
                    FontWeight.bold,

                    color: Colors.brown,
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // =====================
                // ZONA EXCAVACIÓN
                // =====================

                Center(

                  child: Container(

                    width: 320,
                    height: 320,

                    decoration: BoxDecoration(

                      borderRadius:
                      BorderRadius.circular(
                        25,
                      ),

                      border: Border.all(

                        color:
                        Colors.brown.shade700,

                        width: 5,
                      ),

                      boxShadow: [

                        BoxShadow(

                          color:
                          Colors.black.withOpacity(
                            0.25,
                          ),

                          blurRadius: 10,

                          offset:
                          const Offset(
                            0,
                            5,
                          ),
                        ),
                      ],
                    ),

                    child: ClipRRect(

                      borderRadius:
                      BorderRadius.circular(
                        20,
                      ),

                      child: LayoutBuilder(

                        builder:
                            (context, constraints) {

                          return Stack(

                            children: [

                              // =================
                              // HUELLA
                              // =================

                              Positioned.fill(

                                child: Image.asset(

                                  excavaciones[
                                  excavacionActual
                                  ]["huella"]!,

                                  fit: BoxFit.cover,
                                ),
                              ),

                              // =================
                              // ARENA
                              // =================

                              GestureDetector(

                                onPanUpdate:
                                    (details) {

                                  final RenderBox box =

                                  zonaKey
                                      .currentContext!
                                      .findRenderObject()
                                  as RenderBox;

                                  final puntoLocal =

                                  box.globalToLocal(
                                    details.globalPosition,
                                  );

                                  agregarPunto(
                                    puntoLocal,
                                  );
                                },

                                child: RepaintBoundary(

                                  key: zonaKey,

                                  child: CustomPaint(

                                    size: Size.infinite,

                                    painter:
                                    ArenaPainter(
                                      puntos,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
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

// =========================================
// PAINTER ARENA
// =========================================

class ArenaPainter
    extends CustomPainter {

  final List<Offset> puntos;

  ArenaPainter(
      this.puntos,
      );

  @override
  void paint(
      Canvas canvas,
      Size size,
      ) {

    canvas.saveLayer(

      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),

      Paint(),
    );

    final arena = Paint()

      ..color =
      const Color(0xFFD2B48C);

    canvas.drawRect(

      Rect.fromLTWH(
        0,
        0,
        size.width,
        size.height,
      ),

      arena,
    );

    final borrar = Paint()

      ..blendMode = BlendMode.clear

      ..strokeCap = StrokeCap.round

      ..strokeWidth = 55;

    for (

    int i = 0;
    i < puntos.length - 1;
    i++

    ) {

      canvas.drawLine(

        puntos[i],
        puntos[i + 1],

        borrar,
      );
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(
      covariant CustomPainter oldDelegate,
      ) {

    return true;
  }
}