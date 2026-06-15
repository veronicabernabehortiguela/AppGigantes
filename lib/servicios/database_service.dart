import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _database;

  static Future<Database> getDatabase() async {
    if (_database != null) {
      return _database!;
    }

    final dbPath = await getDatabasesPath();

    final path = join(
      dbPath,
      'gigantes.db',
    );

    final existe = await databaseExists(path);

    if (!existe) {
      await Directory(
        dirname(path),
      ).create(
        recursive: true,
      );

      final data = await rootBundle.load(
        'assets/database/gigantes.db',
      );

      final bytes = data.buffer.asUint8List();

      await File(path).writeAsBytes(
        bytes,
        flush: true,
      );
    }

    _database = await openDatabase(path);

    return _database!;
  }
}