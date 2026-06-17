import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  
  final String caminhosBanco = await databaseFactory.getDatabasesPath();
  
  
  final String path = join(caminhosBanco, 'agenda_v2.db');

  return openDatabase(
    path,
    onCreate: (db, version) async { 
      
      await db.execute( 
        'CREATE TABLE usuarios('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'nome TEXT, '
        'email TEXT, '
        'senha TEXT)'
      );
      
      
      await db.execute( 
        'CREATE TABLE contatos('
        'id INTEGER PRIMARY KEY AUTOINCREMENT, '
        'nome TEXT, '
        'telefone TEXT, '
        'usuario_id INTEGER)'
      );
    },
    version: 1, 
  );
}