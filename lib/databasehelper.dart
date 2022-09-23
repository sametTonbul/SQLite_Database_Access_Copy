import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHelper {
  static final String dataBaseName = 'contacts.sqlite';
  static Future<Database> accessDataBase() async {
    String dataBaseRoad = join(await getDatabasesPath(), dataBaseName);
    if (await databaseExists(dataBaseRoad)) {
      print('DataBase already included no copy more');
    } else {
      ByteData data = await rootBundle.load('database/$dataBaseName');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dataBaseRoad).writeAsBytes(bytes, flush: true);
      print('Database Copied');
    }
    return openDatabase(dataBaseRoad);
  }
}
