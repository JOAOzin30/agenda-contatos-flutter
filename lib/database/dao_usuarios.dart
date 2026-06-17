import 'package:sqflite/sqflite.dart';
import 'app_database.dart';

class DaoUsuarios {
  
  // Função para cadastrar um usuário novo
  Future<int> salvar(String nome, String email, String senha) async {
    final Database db = await getDatabase();
    final Map<String, dynamic> usuarioMap = {
      'nome': nome,
      'email': email,
      'senha': senha,
    };
    return db.insert('usuarios', usuarioMap);
  }

  // Função para verificar o login
  Future<bool> verificarLogin(String email, String senha) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> resultado = await db.query(
      'usuarios',
      where: 'email = ? AND senha = ?',
      whereArgs: [email, senha],
    );
    
    return resultado.isNotEmpty;
  }
}