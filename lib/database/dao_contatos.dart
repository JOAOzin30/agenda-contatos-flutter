import 'package:sqflite/sqflite.dart';
import 'app_database.dart'; 

class DaoContatos {
  
  // 1. CREATE (Salvar)
  Future<int> salvarContato(String nome, String telefone, int usuarioId) async {
    Database db = await getDatabase(); 
    Map<String, dynamic> dadosContato = {
      'nome': nome,
      'telefone': telefone,
      'usuario_id': usuarioId,
    };
    return await db.insert('contatos', dadosContato);
  }

  // 2. READ (Buscar)
  Future<List<Map<String, dynamic>>> buscarContatosDoUsuario(int usuarioId) async {
    Database db = await getDatabase();
    return await db.query(
      'contatos',
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
    );
  }

  // 3. UPDATE (Editar) - NOVO!
  Future<int> atualizarContato(int id, String nome, String telefone) async {
    Database db = await getDatabase();
    Map<String, dynamic> dadosAtualizados = {
      'nome': nome,
      'telefone': telefone,
    };
    return await db.update(
      'contatos',
      dadosAtualizados,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // 4. DELETE (Excluir) - NOVO!
  Future<int> excluirContato(int id) async {
    Database db = await getDatabase();
    return await db.delete(
      'contatos',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
} 