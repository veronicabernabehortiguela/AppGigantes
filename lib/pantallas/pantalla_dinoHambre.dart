import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:math';

class PantallaDinoHambre extends StatefulWidget {
  const PantallaDinoHambre({super.key});

  @override
  State<PantallaDinoHambre> createState() =>
      _PantallaDinoHambreState();
}

class _PantallaDinoHambreState
    extends State<PantallaDinoHambre> {

  bool gameStarted = false;
  bool gameOver = false;

  List<String> skins = [];

  String? selectedSkin;

  int puntos = 0;
  int vidas = 3;

  bool dinoGolpeado = false;

  double dinoX = 0;

  Timer? gameLoop;
  Timer? spawnLoop;

  final Random random = Random();

  List<Map<String, dynamic>> objetos = [];

  final List<String> positivos = [
    "assets/hambre/chuleton.png",
    "assets/hambre/tarta.png",
    "assets/hambre/ensalada.png",
  ];

  final List<String> negativos = [
    "assets/hambre/serpiente.png",
    "assets/hambre/meteorito.png",
    "assets/hambre/tornillo.png",
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
      overlays: [],
    );
    cargarSkins();
  }

  Future<void> cargarSkins() async {

    try {

      final manifestContent =
      await rootBundle.loadString(
        'AssetManifest.json',
      );

      final Map<String, dynamic> manifestMap =
      json.decode(
        manifestContent,
      );

      final encontrados =
      manifestMap.keys
          .where(
            (path) =>
        path.contains(
            'assets/hambre/') &&
            path.endsWith('.png'),
      )
          .toList();

      encontrados.sort();

      debugPrint(
        "SKINS ENCONTRADAS:",
      );

      for (final skin
      in encontrados) {

        debugPrint(skin);
      }

      setState(() {

        skins = encontrados;

        if (skins.isNotEmpty) {

          selectedSkin =
              skins.first;
        }
      });

    } catch (e) {

      debugPrint(
        "ERROR CARGANDO SKINS: $e",
      );
    }
  }

  void crearObjeto() {

    final esPositivo =
        random.nextInt(100) < 70;

    final imagen =
    esPositivo
        ? positivos[
    random.nextInt(
      positivos.length,
    )
    ]
        : negativos[
    random.nextInt(
      negativos.length,
    )
    ];

    objetos.add({
      "x": random.nextDouble() *
          (MediaQuery.of(context)
              .size
              .width -
              60),

      "y": -60.0,

      "imagen": imagen,

      "positivo": esPositivo,
    });
  }

  void comenzarPartida() {

    puntos = 0;
    vidas = 3;

    objetos.clear();

    gameStarted = true;
    gameOver = false;

    spawnLoop?.cancel();
    gameLoop?.cancel();

    spawnLoop = Timer.periodic(
      const Duration(milliseconds: 900),
          (_) {

        if (!mounted || gameOver) {
          return;
        }

        setState(() {
          crearObjeto();
        });
      },
    );

    gameLoop = Timer.periodic(
      const Duration(milliseconds: 16),
          (_) {

        if (!mounted || gameOver) {
          return;
        }

        setState(() {

          final dinoRect = Rect.fromLTWH(

            dinoX + 35,

            MediaQuery.of(context)
                .size
                .height -
                150,

            75,

            75,
          );

          for (final obj in objetos) {

            obj["y"] += 4.0;

            final objRect = Rect.fromLTWH(

              obj["x"] + 10,

              obj["y"] + 10,

              40,

              125,
            );

            if (dinoRect.overlaps(objRect)) {

              if (obj["positivo"]) {

                puntos++;

              } else {

                vidas--;

                mostrarGolpe();

                if (vidas <= 0) {

                  terminarPartida();
                }
              }

              obj["eliminar"] = true;
            }
          }

          objetos.removeWhere(
                (obj) =>
            obj["eliminar"] == true ||
                obj["y"] >
                    MediaQuery.of(context)
                        .size
                        .height,
          );
        });
      },
    );

    setState(() {});
  }


  Future<void> mostrarGolpe() async {

    for (int i = 0; i < 3; i++) {

      setState(() {
        dinoGolpeado = true;
      });

      await Future.delayed(
        const Duration(milliseconds: 80),
      );

      if (!mounted) return;

      setState(() {
        dinoGolpeado = false;
      });

      await Future.delayed(
        const Duration(milliseconds: 80),
      );
    }
  }

  void terminarPartida() {

    gameLoop?.cancel();
    spawnLoop?.cancel();

    setState(() {
      gameOver = true;
    });
  }

  void volverASeleccion() {

    setState(() {

      gameStarted = false;
      gameOver = false;

      puntos = 0;
      vidas = 3;
    });
  }

  @override
  Widget build(BuildContext context) {

    if (!gameStarted) {
      return pantallaSeleccion();
    }

    if (gameOver) {
      return pantallaFinal();
    }

    return pantallaJuego();
  }

  Widget pantallaSeleccion() {

    return Scaffold(
      backgroundColor:
      const Color(0xFF0C1016),

      body: Column(
        children: [

          const SizedBox(height: 30),

          const Text(
            "Selecciona tu dinosaurio",

            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight:
              FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: ListView.builder(

              scrollDirection:
              Axis.horizontal,

              itemCount: 15,

              itemBuilder:
                  (context, index) {

                final skin =
                    "assets/hambre/${index + 1}.png";

                final selected =
                    skin ==
                        selectedSkin;

                return GestureDetector(

                  onTap: () {

                    setState(() {
                      selectedSkin =
                          skin;
                    });
                  },

                  child: Container(

                    width: 160,

                    margin:
                    const EdgeInsets.all(
                        12),

                    decoration:
                    BoxDecoration(

                      border:
                      Border.all(
                        color: selected
                            ? Colors.green
                            : Colors.white,
                        width: 4,
                      ),

                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),

                    child:
                    Image.asset(
                      skin,
                    ),
                  ),
                );
              },
            ),
          ),

          Padding(
            padding:
            const EdgeInsets.all(20),

            child: SizedBox(
              width: double.infinity,

              height: 70,

              child: ElevatedButton(

                onPressed:
                selectedSkin == null
                    ? null
                    : comenzarPartida,

                child:
                const Text(
                  "JUGAR",
                  style: TextStyle(
                    fontSize: 26,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget pantallaJuego() {

    return Scaffold(
        backgroundColor:
        const Color(0xFF8ED6FF),

        body: GestureDetector(

          behavior: HitTestBehavior.opaque,

          onPanUpdate: (details) {

            setState(() {

              dinoX = details.localPosition.dx - 90;

              final maxX =
                  MediaQuery.of(context).size.width - 120;

              if (dinoX < 0) dinoX = 0;
              if (dinoX > maxX) dinoX = maxX;
            });
          },

          child: SafeArea(

            child: Stack(
              children: [

                Positioned.fill(
                  child: Image.asset(
                    "assets/hambre/fondo.png",
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned(
                  top: 20,
                  left: 20,

                  child: Container(

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.black.withOpacity(0.45),

                      borderRadius:
                      BorderRadius.circular(15),

                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),

                    child: Text(
                      "⭐ $puntos",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 20,
                  right: 20,

                  child: Container(

                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(

                      color: Colors.black.withOpacity(0.45),

                      borderRadius:
                      BorderRadius.circular(15),

                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),

                    child: Text(
                      "❤️ $vidas",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ...objetos.map(
                      (obj) => Positioned(
                    left: obj["x"],
                    top: obj["y"],

                    child: Image.asset(
                      obj["imagen"],
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),

                Positioned(
                  bottom: 40,
                  left: dinoX,

                  child: Opacity(
                    opacity: dinoGolpeado ? 0.3 : 1.0,
                    child: Image.asset(
                      selectedSkin!,
                      width: 120,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget pantallaFinal() {

    return Scaffold(
      backgroundColor:
      const Color(0xFF0C1016),

      body: Center(
        child: Padding(
          padding:
          const EdgeInsets.all(24),

          child: Column(

            mainAxisAlignment:
            MainAxisAlignment.center,

            children: [

              const Text(
                "GAME OVER",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Text(
                "Puntos: $puntos",

                style:
                const TextStyle(
                  color:
                  Colors.white,
                  fontSize: 26,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              Image.asset(
                selectedSkin!,
                width: 120,
              ),

              const SizedBox(
                height: 30,
              ),

              ElevatedButton(
                onPressed:
                comenzarPartida,

                child:
                const Text(
                  "VOLVER A JUGAR",
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ElevatedButton(
                onPressed:
                volverASeleccion,

                child:
                const Text(
                  "CAMBIAR DINO",
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child: const Text(
                  "SALIR",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}