import 'package:flutter/material.dart';

import '../dao/taller_dao.dart';
import '../modelos/taller.dart';
import '../servicios/servicio_idioma.dart';

class PantallaTalleres extends StatelessWidget {

  const PantallaTalleres({super.key});

  @override
  Widget build(BuildContext context) {

    final TallerDAO tallerDAO =
    TallerDAO();

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

          child: StreamBuilder<List<Taller>>(

            stream: tallerDAO.obtenerTalleres(),

            builder: (context, snapshot) {

              // =========================
              // CARGANDO
              // =========================

              if (!snapshot.hasData) {

                return const Center(

                  child: CircularProgressIndicator(),
                );
              }

              final talleres =
              snapshot.data!;

              // =========================
              // LISTA TALLERES
              // =========================

              return ListView.separated(

                padding: const EdgeInsets.all(20),

                itemCount: talleres.length,

                separatorBuilder:
                    (context, index) {

                  return const Padding(

                    padding: EdgeInsets.symmetric(
                      vertical: 25,
                    ),

                    child: Divider(

                      color: Colors.black,

                      thickness: 2,
                    ),
                  );
                },

                itemBuilder: (context, index) {

                  final taller =
                  talleres[index];

                  return crearTarjetaTaller(
                    context,
                    taller,
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // =====================================
  // TARJETA TALLER
  // =====================================

  Widget crearTarjetaTaller(
      BuildContext context,
      Taller taller,
      ) {

    // =============================
    // IDIOMA ACTUAL
    // =============================

    final idioma =
        ServicioIdioma
            .idiomaSeleccionado
            ?.codigo ?? "es";

    // =============================
    // TEXTOS SEGÚN IDIOMA
    // =============================

    final titulo =
        taller.titulo[idioma] ?? "";

    final descripcion =
        taller.descripcion[idioma] ?? "";

    return Column(

      children: [

        // =================================
        // TABLA NOMBRE
        // =================================

        Container(

          width: double.infinity,

          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(25),

            image: const DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_taller.png",
              ),

              fit: BoxFit.cover,
            ),
          ),

          child: Center(

            child: Text(

              titulo,

              textAlign: TextAlign.center,

              style: const TextStyle(

                fontSize: 24,

                fontWeight: FontWeight.bold,

                color: Colors.black,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),

        // =================================
        // TABLA DESCRIPCIÓN
        // =================================

        Container(

          width: double.infinity,

          padding: const EdgeInsets.all(25),

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(35),

            image: const DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_taller.png",
              ),

              fit: BoxFit.cover,
            ),
          ),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              // HORARIO

              Text(

                taller.horario,

                style: const TextStyle(

                  fontSize: 20,

                  fontWeight: FontWeight.bold,

                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 15),

              // DESCRIPCIÓN

              Text(

                descripcion,

                style: const TextStyle(

                  fontSize: 18,

                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // =================================
        // TABLA IMAGEN
        // =================================

        Container(

          width: double.infinity,

          height: 220,

          decoration: BoxDecoration(

            borderRadius:
            BorderRadius.circular(35),

            image: const DecorationImage(

              image: AssetImage(
                "assets/fondos/fondo_taller.png",
              ),

              fit: BoxFit.cover,
            ),
          ),

          child: Padding(

            padding: const EdgeInsets.all(15),

            child: ClipRRect(

              borderRadius:
              BorderRadius.circular(25),

              child: GestureDetector(

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) => Scaffold(

                        backgroundColor: Colors.black,

                        body: SafeArea(

                          child: Stack(

                            children: [

                              Center(

                                child: InteractiveViewer(

                                  minScale: 1,
                                  maxScale: 5,

                                  child: Image.asset(

                                    taller.imagen,

                                    fit: BoxFit.contain,

                                    errorBuilder:
                                        (
                                        context,
                                        error,
                                        stackTrace,
                                        ) {

                                      return const Center(

                                        child: Text(

                                          "Imagen no encontrada",

                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),

                              // BOTÓN CERRAR

                              Positioned(

                                top: 10,
                                right: 10,

                                child: IconButton(

                                  onPressed: () {

                                    Navigator.pop(context);
                                  },

                                  icon: const Icon(

                                    Icons.close,

                                    color: Colors.black,

                                    size: 35,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },

                child: Image.asset(

                  taller.imagen,

                  fit: BoxFit.cover,

                  errorBuilder:
                      (context, error, stackTrace) {

                    return const Center(

                      child: Text(

                        "Imagen no encontrada",

                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}