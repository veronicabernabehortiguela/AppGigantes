class Taller {

  final Map<String, dynamic> titulo;

  final Map<String, dynamic> descripcion;

  final String horario;

  final String imagen;

  Taller({

    required this.titulo,

    required this.descripcion,

    required this.horario,

    required this.imagen,
  });

  // =====================================
  // FIRESTORE → OBJETO
  // =====================================

  factory Taller.fromFirestore(
      Map<String, dynamic> datos,
      ) {

    return Taller(

      titulo:
      datos["titulo"] ?? {},

      descripcion:
      datos["descripcion"] ?? {},

      horario:
      datos["horario"] ?? "",

      imagen:
      datos["imagen"] ?? "",
    );
  }
}