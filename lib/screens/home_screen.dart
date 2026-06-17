import 'package:flutter/material.dart';
import 'cadastro_contato_screen.dart';
import '../database/dao_contatos.dart';

class HomeScreen extends StatefulWidget {
  final String nomeUsuario;
  final int usuarioId;

  const HomeScreen({
    Key? key,
    required this.nomeUsuario,
    required this.usuarioId,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DaoContatos _daoContatos = DaoContatos();

  void _mostrarCaixaEdicao(BuildContext context, Map<String, dynamic> contato) {
    final TextEditingController nomeController = TextEditingController(text: contato['nome']);
    final TextEditingController telefoneController = TextEditingController(text: contato['telefone']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Editar Contato'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
              TextField(controller: telefoneController, decoration: const InputDecoration(labelText: 'Telefone')),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
            ElevatedButton(
              onPressed: () async {
                await _daoContatos.atualizarContato(contato['id'], nomeController.text, telefoneController.text);
                if (mounted) {
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deletarContato(int idContato) async {
    await _daoContatos.excluirContato(idContato);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda de ${widget.nomeUsuario}'),
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _daoContatos.buscarContatosDoUsuario(widget.usuarioId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final contatos = snapshot.data ?? [];

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  color: Colors.blue.shade50,
                  child: ListTile(
                    leading: const Icon(Icons.contacts, color: Colors.blue),
                    title: const Text('Total de contatos'),
                    trailing: Text(
                      '${contatos.length}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: contatos.isEmpty
                    ? const Center(child: Text('Nenhum contato adicionado.'))
                    : ListView.builder(
                        itemCount: contatos.length,
                        itemBuilder: (context, index) {
                          final contato = contatos[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            child: ListTile(
                              leading: const CircleAvatar(child: Icon(Icons.person)),
                              title: Text(contato['nome']),
                              subtitle: Text(contato['telefone']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () => _mostrarCaixaEdicao(context, contato),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deletarContato(contato['id']),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroContatoScreen(usuarioId: widget.usuarioId)),
          );
          setState(() {});
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}