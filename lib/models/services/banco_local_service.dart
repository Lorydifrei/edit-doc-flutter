import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../usuario.dart';
import '../documento.dart';

class BancoLocalService {
  static const String _chaveUsuarios = 'usuarios_salvos';
  static const String _chaveDocumentos = 'documentos_salvos';

  final List<Usuario> _usuarios = [];
  final List<Documento> _documentos = [];

  Future<void> inicializar() async {
    final prefs = await SharedPreferences.getInstance();

    final usuariosJson = prefs.getString(_chaveUsuarios);
    final documentosJson = prefs.getString(_chaveDocumentos);

    if (usuariosJson != null) {
      _usuarios
        ..clear()
        ..addAll(
          (jsonDecode(usuariosJson) as List).map(
            (item) => Usuario(
              nome: item['nome'],
              email: item['email'],
              senha: item['senha'],
            ),
          ),
        );
    }

    if (documentosJson != null) {
      _documentos
        ..clear()
        ..addAll(
          (jsonDecode(documentosJson) as List).map(
            (item) => Documento(
              id: item['id'],
              titulo: item['titulo'],
              conteudo: item['conteudo'],
              dataCriacao: DateTime.parse(item['dataCriacao']),
              dataAtualizacao: DateTime.parse(item['dataAtualizacao']),
            ),
          ),
        );
    } else {
      _documentos.addAll([
        Documento(
          id: '1',
          titulo: 'Relatório de Estágio',
          conteudo: 'Conteúdo do relatório de estágio.',
        ),
        Documento(
          id: '2',
          titulo: 'Anotações da Aula',
          conteudo: 'Anotações e conteúdos estudados.',
        ),
        Documento(
          id: '3',
          titulo: 'Lista de Ideias',
          conteudo: 'Minhas ideias e projetos.',
        ),
      ]);

      await _salvarDocumentos();
    }
  }

  Future<void> _salvarUsuarios() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _chaveUsuarios,
      jsonEncode(
        _usuarios.map((u) => {
          'nome': u.nome,
          'email': u.email,
          'senha': u.senha,
        }).toList(),
      ),
    );
  }

  Future<void> _salvarDocumentos() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _chaveDocumentos,
      jsonEncode(
        _documentos.map((d) => {
          'id': d.id,
          'titulo': d.titulo,
          'conteudo': d.conteudo,
          'dataCriacao': d.dataCriacao.toIso8601String(),
          'dataAtualizacao': d.dataAtualizacao.toIso8601String(),
        }).toList(),
      ),
    );
  }

  bool cadastrarUsuario(Usuario usuario) {
    final emailExiste = _usuarios.any(
      (u) => u.email.toLowerCase() == usuario.email.toLowerCase(),
    );

    if (emailExiste) return false;

    _usuarios.add(usuario);
    _salvarUsuarios();
    return true;
  }

  Usuario? autenticarUsuario(String email, String senha) {
    for (final usuario in _usuarios) {
      if (usuario.email.toLowerCase() == email.toLowerCase() &&
          usuario.senha == senha) {
        return usuario;
      }
    }
    return null;
  }

  bool existeUsuario(String email) {
    return _usuarios.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
  }

  List<Documento> listarDocumentos() {
    return List.unmodifiable(_documentos);
  }

  Future<void> atualizarDocumento(Documento documento) async {
    final index = _documentos.indexWhere((d) => d.id == documento.id);

    if (index != -1) {
      _documentos[index] = documento;
      documento.dataAtualizacao = DateTime.now();
      await _salvarDocumentos();
    }
  }
}