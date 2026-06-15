class Contenido {
  final String codigo;
  final String idioma;
  final String titulo;
  final String descripcion;
  final String audio;
  final String img;

  Contenido({
    required this.codigo,
    required this.idioma,
    required this.titulo,
    required this.descripcion,
    required this.audio,
    required this.img,
  });

  factory Contenido.fromMap(Map<String, dynamic> map) {
    return Contenido(
      codigo: map['codigo'].toString(),
      idioma: map['idioma'],
      titulo: map['titulo'],
      descripcion: map['descripcion'],
      audio: map['audio'],
      img: map['img'],
    );
  }
}