import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PantallaAlasJurasicas extends StatefulWidget {
  final dynamic idioma;

  const PantallaAlasJurasicas({
    super.key,
    required this.idioma,
  });

  @override
  State<PantallaAlasJurasicas> createState() => _PantallaAlasJurasicasState();
}

class _PantallaAlasJurasicasState extends State<PantallaAlasJurasicas> {
  final dinosaurios = [
    "assets/alas/dino1.png",
    "assets/alas/dino2.png",
    "assets/alas/dino3.png",
  ];

  final fondos = [
    "assets/alas/fondoAmanecer.png",
    "assets/alas/fondoAmanecido.png",
    "assets/alas/fondoAtardecer.png",
    "assets/alas/fondoAtardecido.png",
    "assets/alas/fondoAnochecido.png",
  ];

  final obstaculosImg = [
    "assets/alas/roca.png",
    "assets/alas/meteorito.png",
    "assets/alas/pajaro.png",
  ];

  int dinosaurioActual = 0;
  bool juegoIniciado = false;

  int puntos = 0;
  int vidas = 3;
  int nivel = 1;
  int fondoActual = 0;

  double dinoY = 0.5;

  Timer? timer;
  final random = Random();

  final List<Map<String, dynamic>> obstaculos = [];
  bool visibleDino = true;
  bool invulnerable = false;
  bool juegoPausado = false;
  bool modoInfinito = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    //quitar botones del móvil de menú-salir y demás
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  void iniciarJuego() {
    puntos = 0;
    vidas = 3;
    modoInfinito = false;
    nivel = 1;
    fondoActual = 0;
    dinoY = 0.5;

    obstaculos.clear();

    for (int i = 0; i < 3; i++) {
      crearObstaculo(1.2 + (i * 0.8));
    }

    juegoIniciado = true;

    timer?.cancel();

    timer = Timer.periodic(
      const Duration(milliseconds: 30),
          (_) => actualizarJuego(),
    );

    setState(() {});
  }

  void crearObstaculo(double x) {
    obstaculos.add({
      "x": x,
      "y": 0.15 + random.nextDouble() * 0.65,
      "img": obstaculosImg[random.nextInt(obstaculosImg.length)],
      "hit": false,
    });
  }

  void actualizarJuego() {
    if (juegoPausado) return;

    double velocidad = 0.010 + (nivel * 0.001);

    if (modoInfinito) {
      int ciclo = ((puntos - 102) ~/ 20);
      velocidad = 0.015 + (ciclo * 0.001);
    }

    setState(() {
      if (!modoInfinito && puntos >= 102) {
        timer?.cancel();
        mostrarVictoria();
        return;
      }

      for (final o in obstaculos) {
        o["x"] -= velocidad;
      }

      final borrar = <Map<String, dynamic>>[];

      for (final o in obstaculos) {
        if (o["x"] < -0.25) {
          borrar.add(o);
          puntos++;
        }
      }

      for (final o in borrar) {
        obstaculos.remove(o);
        crearObstaculo(1.4 + random.nextDouble());
      }

      while (obstaculos.length < min(3 + nivel, 6)) {
        crearObstaculo(1.6 + random.nextDouble());
      }

      if (modoInfinito) {
        int ciclo = ((puntos - 102) ~/ 20);
        fondoActual = ciclo % 5;
        nivel = 999;
      } else if (puntos >= 77) {
        nivel = 5;
        fondoActual = 4;
      } else if (puntos >= 57) {
        nivel = 4;
        fondoActual = 3;
      } else if (puntos >= 37) {
        nivel = 3;
        fondoActual = 2;
      } else if (puntos >= 17) {
        nivel = 2;
        fondoActual = 1;
      } else {
        nivel = 1;
        fondoActual = 0;
      }

      for (final o in obstaculos) {
        if (o["hit"] == true || invulnerable) continue;

        bool choqueX = o["x"] < 0.22 && o["x"] > 0.08;

        double hitboxY = 0.07;

        bool choqueY = ((o["y"] as double) - dinoY).abs() < hitboxY;

        if (choqueX && choqueY) {
          o["hit"] = true;
          vidas--;
          invulnerable = true;

          for (int i = 0; i < 6; i++) {
            Future.delayed(Duration(milliseconds: i * 100), () {
              if (mounted) {
                setState(() {
                  visibleDino = !visibleDino;
                });
              }
            });
          }

          Future.delayed(const Duration(milliseconds: 700), () {
            if (mounted) {
              setState(() {
                visibleDino = true;
                invulnerable = false;
              });
            }
          });

          if (vidas <= 0) {
            timer?.cancel();
            mostrarGameOver();
          }
        }
      }
    });
  }



  void mostrarVictoria() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: SingleChildScrollView(
          child: SizedBox(
            width: 310,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "¡HAS GANADO!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Image.asset(
                    "assets/alas/dino${dinosaurioActual + 1}Feliz.png",
                    width: 145,
                  ),
                  const SizedBox(height: 4),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              modoInfinito = true;
                            });
                            timer?.cancel();
                            timer = Timer.periodic(
                              const Duration(milliseconds: 30),
                                  (_) => actualizarJuego(),
                            );
                          },
                          child: const Text("CONTINUAR", style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      const SizedBox(width: 8),
                      SizedBox(
                        width: 120,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            setState(() {
                              juegoIniciado = false;
                            });
                          },
                          child: const Text("REINICIAR", style: TextStyle(fontSize: 11)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: 95,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("SALIR", style: TextStyle(fontSize: 11)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  void mostrarGameOver() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: SizedBox(
          width: 310,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 28),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "¡HAS PERDIDO!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "Puntuación: $puntos",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  "assets/alas/dino${dinosaurioActual + 1}Triste.png",
                  width: 145,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            juegoIniciado = false;
                          });
                        },
                        child: const Text("REINTENTAR", style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 130,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("SALIR", style: TextStyle(fontSize: 11)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!juegoIniciado) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(fondos[0]),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: Align(
              alignment: const Alignment(0, -0.55),
              child: Container(
                width: 650,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.65),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.idioma.textos["alasJurasicas"] ?? "ALAS JURÁSICAS",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "📱 Coloca el dispositivo en horizontal",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              dinosaurioActual--;
                              if (dinosaurioActual < 0) {
                                dinosaurioActual = dinosaurios.length - 1;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        Image.asset(
                          dinosaurios[dinosaurioActual],
                          width: 160,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              dinosaurioActual++;
                              if (dinosaurioActual >= dinosaurios.length) {
                                dinosaurioActual = 0;
                              }
                            });
                          },
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),                    SizedBox(
                      width: 190,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: iniciarJuego,
                        child: const Text(
                          "START",
                          style: TextStyle(
                            fontSize: 22,
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
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onPanUpdate: juegoPausado ? null : (d) {
          double alto = MediaQuery.of(context).size.height;

          setState(() {
            dinoY += d.delta.dy / alto;
            dinoY = dinoY.clamp(0.08, 0.72);
          });
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 1200),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(fondos[fondoActual]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 15,
              left: 15,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.pause,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      juegoPausado = true;
                    });
                  },
                ),
              ),
            ),

            Positioned(
              top: 15,
              right: 15,
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Text(
                      "Puntos: $puntos  Nivel: ${modoInfinito ? "∞" : nivel}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ...List.generate(
                      vidas,
                          (_) => const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 2),
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 80,
              top: MediaQuery.of(context).size.height * dinoY,
              child: visibleDino
                  ? Image.asset(
                dinosaurios[dinosaurioActual],
                width: 110,
              )
                  : const SizedBox(width: 110),
            ),
            ...obstaculos.map(
                  (o) => Positioned(
                left: MediaQuery.of(context).size.width * (o["x"] as double),
                top: MediaQuery.of(context).size.height * (o["y"] as double),
                child: Image.asset(
                  o["img"],
                  width: 100,
                ),
              ),
            ),

            if (juegoPausado)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: Center(
                    child: IconButton(
                      iconSize: 120,
                      color: Colors.white,
                      icon: const Icon(Icons.play_circle_fill),
                      onPressed: () {
                        setState(() {
                          juegoPausado = false;
                        });
                      },
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