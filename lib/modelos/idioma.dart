class Idioma {

  final String codigo;
  final String nombre;
  final String bandera;
  final Map<String, String> textos;

  Idioma({ //constructor con lo siguiente OBLIGATORIO
    required this.codigo,
    required this.nombre,
    required this.bandera,
    required this.textos,
  });
}