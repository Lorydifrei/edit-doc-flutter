import 'package:flutter/material.dart';
import '../models/documento.dart';

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _conteudoController = TextEditingController();

  Documento? _documento;
  bool _inicializado = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_inicializado) return;
    _inicializado = true;

    final arg = ModalRoute.of(context)?.settings.arguments;
    if (arg is Documento) {
      _documento = arg;
      _tituloController.text = arg.titulo;
      _conteudoController.text = arg.conteudo;
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    // A persistência (CRUD) será implementada na Etapa 5.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edição validada. A gravação será feita na Etapa 5.'),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    if (_documento == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Editor')),
        body: const Center(child: Text('Nenhum documento selecionado.')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar documento'),
        actions: [
          IconButton(
            tooltip: 'Salvar',
            icon: const Icon(Icons.save),
            onPressed: _salvar,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Informe um título.'
                    : null,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: TextFormField(
                  controller: _conteudoController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: const InputDecoration(
                    labelText: 'Conteúdo',
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}