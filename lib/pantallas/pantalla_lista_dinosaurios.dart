import 'package:flutter/material.dart';

import '../dao/dinosaurios_dao.dart';

import '../modelos/dinosaurio.dart';

import '../servicios/servicio_audio.dart';

import '../servicios/servicio_idioma.dart';

import '../servicios/tts_service.dart';

import '../utils/app_languages.dart';

import '../utils/app_state.dart';

class PantallaListaDinosaurios
    extends StatefulWidget {

  const PantallaListaDinosaurios({
    super.key,
  });

  @override
  State<PantallaListaDinosaurios>
  createState() =>
      _PantallaListaDinosauriosState();
}

class _PantallaListaDinosauriosState
    extends State<PantallaListaDinosaurios> {

  // =====================================
  // TTS
  // =====================================

  final TTSService tts = TTSService();

  // =====================================
  // PÁGINA ACTUAL
  // =====================================

  int paginaActual = 0;

  // =====================================
  // DINO REPRODUCIÉNDOSE
  // =====================================

  int? dinosaurioReproduciendo;

  // =====================================
  // DINOS POR PÁGINA
  // =====================================

  final int dinosauriosPorPagina = 3;

  @override
  void initState() {

    super.initState();

    tts.init();
  }

  @override
  Widget build(BuildContext context) {

    final DinosaurioDAO dinosaurioDAO =
    DinosaurioDAO();

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

          child: StreamBuilder<
              List<Dinosaurio>>(

            stream:
            dinosaurioDAO
                .obtenerDinosaurios(),

            builder:
                (context, snapshot) {

              if (!snapshot.hasData) {

                return const Center(

                  child:
                  CircularProgressIndicator(),
                );
              }

              final dinosaurios =
              snapshot.data!;

              if (dinosaurios.isEmpty) {

                return const Center(

                  child: Text(

                    "No hay dinosaurios",

                    style: TextStyle(
                      fontSize: 25,
                    ),
                  ),
                );
              }

              final totalPaginas =

              (dinosaurios.length /
                  dinosauriosPorPagina)
                  .ceil();

              final inicio =
                  paginaActual *
                      dinosauriosPorPagina;

              final fin =
              (inicio +
                  dinosauriosPorPagina)
                  .clamp(
                0,
                dinosaurios.length,
              );

              final dinosauriosPagina =
              dinosaurios.sublist(
                inicio,
                fin,
              );

              return Padding(

                padding:
                const EdgeInsets.all(20),

                child: Column(

                  children: [

                    const SizedBox(
                      height: 20,
                    ),

                    Expanded(

                      child: ListView.builder(

                        itemCount:
                        dinosauriosPagina.length,

                        itemBuilder:
                            (context, index) {

                          final dinosaurio =
                          dinosauriosPagina[index];

                          return Padding(

                            padding:
                            const EdgeInsets.only(
                              bottom: 30,
                            ),

                            child:
                            construirDinosaurio(
                              dinosaurio,
                            ),
                          );
                        },
                      ),
                    ),

                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,

                      children: [

                        GestureDetector(

                          onTap: () {

                            if (paginaActual >
                                0) {

                              setState(() {

                                paginaActual--;
                              });
                            }
                          },

                          child: Image.asset(

                            "assets/iconos/flecha_izquierda.png",

                            width: 120,
                          ),
                        ),

                        Text(

                          "${paginaActual + 1} / $totalPaginas",

                          style:
                          const TextStyle(

                            fontSize: 28,

                            fontWeight:
                            FontWeight.bold,

                            color:
                            Colors.brown,
                          ),
                        ),

                        GestureDetector(

                          onTap: () {

                            if (paginaActual <
                                totalPaginas - 1) {

                              setState(() {

                                paginaActual++;
                              });
                            }
                          },

                          child: Image.asset(

                            "assets/iconos/flecha_derecha.png",

                            width: 120,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // =====================================
  // TEXTO ZONA
  // =====================================

  String obtenerTextoZona(
      String idioma,
      ) {

    switch (idioma) {

      case "en":
        return "Zone";

      case "fr":
        return "Zone";

      case "es":
      default:
        return "Zona";
    }
  }

  // =====================================
  // BLOQUE DINOSAURIO
  // =====================================

  Widget construirDinosaurio(
      Dinosaurio dinosaurio,
      ) {

    final idioma =
        ServicioIdioma
            .idiomaSeleccionado
            ?.codigo ?? "es";

    final nombre =
        dinosaurio.nombre[
        idioma] ?? "";

    final descripcion =
        dinosaurio.descripcion[
        idioma] ?? "";

    final audio =
        dinosaurio.audio[
        idioma] ?? "";

    return Column(

      children: [

        Container(

          width: double.infinity,

          padding:
          const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),

          decoration: BoxDecoration(

            image: const DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_titulos_dinos.png",
              ),

              fit: BoxFit.cover,
            ),

            borderRadius:
            BorderRadius.circular(30),
          ),

          child: Center(

            child: Text(

              nombre,

              textAlign:
              TextAlign.center,

              style: const TextStyle(

                fontSize: 24,

                fontWeight:
                FontWeight.bold,

                color: Colors.black,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        Container(

          width: double.infinity,

          padding:
          const EdgeInsets.all(25),

          decoration: BoxDecoration(

            image: const DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_texto_dinos.png",
              ),

              fit: BoxFit.cover,
            ),

            borderRadius:
            BorderRadius.circular(35),
          ),

          child: Row(

            children: [

              Expanded(

                child: Column(

                  crossAxisAlignment:
                  CrossAxisAlignment.start,

                  children: [

                    Text(

                      descripcion,

                      style:
                      const TextStyle(

                        fontSize: 20,

                        fontWeight:
                        FontWeight.w600,

                        color:
                        Colors.black,
                      ),
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(

                      "${obtenerTextoZona(idioma)}: ${dinosaurio.zona[idioma]}",

                      style:
                      const TextStyle(

                        fontSize: 18,

                        color:
                        Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 20),

              GestureDetector(

                onTap: () async {

                  // =====================
                  // PAUSAR
                  // =====================

                  if (dinosaurioReproduciendo ==
                      dinosaurio.nombre.hashCode) {

                    await ServicioAudio
                        .detenerAudio();

                    setState(() {

                      dinosaurioReproduciendo =
                      null;
                    });

                    return;
                  }

                  // =====================
                  // REPRODUCIR
                  // =====================

                  setState(() {

                    dinosaurioReproduciendo =
                        dinosaurio.nombre.hashCode;
                  });

                  ServicioAudio
                      .reproducirTexto(
                    audio,
                  );
                },

                child: Image.asset(

                  dinosaurioReproduciendo ==
                      dinosaurio.nombre.hashCode

                      ? "assets/iconos/pause.png"

                      : "assets/iconos/play.png",

                  width: 95,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}