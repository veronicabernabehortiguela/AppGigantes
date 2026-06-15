import 'package:sqflite/sqflite.dart';

import '../modelos/contenido.dart';

class ContenidoDAO {
  final Database db;

  ContenidoDAO(this.db);

  Future<Contenido?> obtenerContenido(
      String codigo,
      String idioma,
      ) async {

    print('====================================');
    print('CODIGO BUSCADO: [$codigo]');
    print('IDIOMA BUSCADO: [$idioma]');
    print('====================================');

    final todasLasFilas = await db.query(
      'textos',
    );

    print('TOTAL FILAS EN LA BD: ${todasLasFilas.length}');
    print('TODAS LAS FILAS:');
    print(todasLasFilas);

    final resultado = await db.query(
      'textos',
      where: 'codigo = ? AND idioma = ?',
      whereArgs: [
        codigo,
        idioma,
      ],
      limit: 1,
    );

    print('====================================');
    print('RESULTADO CONSULTA:');
    print(resultado);
    print('====================================');

    if (resultado.isEmpty) {

      print('NO SE ENCONTRO NINGUN REGISTRO');

      return null;
    }

    print('CONTENIDO ENCONTRADO:');
    print(resultado.first);

    return Contenido.fromMap(
      resultado.first,
    );
  }
}