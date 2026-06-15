// servicios/servicio_idioma.dart
import '../modelos/idioma.dart';

class ServicioIdioma {
  static Idioma? idiomaSeleccionado;
  static void cambiarIdioma(Idioma idioma) {

    idiomaSeleccionado = idioma;
  }

  static String obtenerTexto(String clave) {

    return idiomaSeleccionado?.textos[clave] ?? "";
  }
}