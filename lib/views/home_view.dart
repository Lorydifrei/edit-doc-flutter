import 'package:flutter/material.dart';
import '../viewmodels/documentos_viewmodel.dart';

class HomeView extends StatelessWidget {
  final DocumentosViewModel documentosViewModel;

  const HomeView({super.key, required this.documentosViewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Documentos'),
        actions: [
          IconButton(
            tooltip: 'Atualizar',
            icon: const Icon(Icons.refresh),
            onPressed: documentosViewModel.carregarDocumentos,
          ),
          IconButton(
            tooltip: 'Sair',
            icon: const Icon(Icons.logout),
            onPressed: () =>
                Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false),
          ),
        ],
      ),
      body: ListenableBuilder(
        listenable: documentosViewModel,
        builder: (context, _) {
          if (documentosViewModel.carregando) {
            return const Center(child: CircularProgressIndicator());
          }

          if (documentosViewModel.mensagem != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      documentosViewModel.mensagem!,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: documentosViewModel.carregarDocumentos,
                      child: const Text('Tentar novamente'),
                    ),
                  ],
                ),
              ),
            );
          }

          final docs = documentosViewModel.documentos;

          if (docs.isEmpty) {
            return const Center(child: Text('Nenhum documento disponível.'));
          }

          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (_, _) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final doc = docs[i];
              return ListTile(
                leading: const Icon(Icons.description, color: Colors.indigo),
                title: Text(doc.titulo),
                subtitle: Text(
                  doc.conteudo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: () =>
                    Navigator.pushNamed(context, '/editor', arguments: doc),
              );
            },
          );
        },
      ),
    );
  }
}