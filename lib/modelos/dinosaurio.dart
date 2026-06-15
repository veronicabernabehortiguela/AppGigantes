class Dinosaurio {

  final Map<String, dynamic> nombre;

  final Map<String, dynamic> descripcion;

  final Map<String, dynamic> audio;

  final Map<String, dynamic> zona;

  Dinosaurio({

    required this.nombre,

    required this.descripcion,

    required this.audio,

    required this.zona,
  });

  // =====================================
  // FIRESTORE → OBJETO
  // =====================================

  factory Dinosaurio.fromFirestore(
      Map<String, dynamic> datos,
      ) {

    return Dinosaurio(

      nombre:
      datos["nombre"] ?? {},

      descripcion:
      datos["descripcion"] ?? {},

      audio:
      datos["audio"] ?? {},

      zona:
      datos["zona"] ?? {},
    );
  }
}