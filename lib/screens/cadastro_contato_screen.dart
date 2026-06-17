import 'package:flutter/material.dart';
import '../database/dao_contatos.dart'; 

class CadastroContatoScreen extends StatefulWidget {
  final int usuarioId; 

  const CadastroContatoScreen({Key? key, required this.usuarioId}) : super(key: key);

  @override
  State<CadastroContatoScreen> createState() => _CadastroContatoScreenState();
}

class _CadastroContatoScreenState extends State<CadastroContatoScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _telefoneController = TextEditingController();
  
  final DaoContatos _daoContatos = DaoContatos();

  void _salvarContato() async {
    String nome = _nomeController.text;
    String telefone = _telefoneController.text;

    if (nome.isNotEmpty && telefone.isNotEmpty) {

      await _daoContatos.salvarContato(nome, telefone, widget.usuarioId);
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Contato salvo com sucesso!'),
            backgroundColor: Colors.green,
          ),
        );
        // Fecha a tela e volta para a Home
        Navigator.pop(context);
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Preencha nome e telefone!'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Contato'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome do Contato',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _telefoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Telefone',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _salvarContato,
                child: const Text('Salvar Contato', style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}