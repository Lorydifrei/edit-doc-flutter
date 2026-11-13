
import '../usuario.dart';
import '../documento.dart';

class BancoLocalService {
  // Armazenamento temporário dos usuários em memória.
  // Na Etapa 5 implementaremos a persistência definitiva.
  final List<Usuario> _usuarios = [];

  // Lista inicial de documentos do aplicativo.
  final List<Documento> _documentos = [
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
  ];

  // Cadastra um novo usuário.
  bool cadastrarUsuario(Usuario usuario) {
    final emailExiste = _usuarios.any(
      (u) => u.email.toLowerCase() == usuario.email.toLowerCase(),
    );

    if (emailExiste) {
      return false;
    }

    _usuarios.add(usuario);
    return true;
  }

  // Realiza a autenticação do usuário.
  Usuario? autenticarUsuario(String email, String senha) {
    try {
      return _usuarios.firstWhere(
        (usuario) =>
            usuario.email.toLowerCase() == email.toLowerCase() &&
            usuario.senha == senha,
      );
    } catch (e) {
      return null;
    }
  }

  // Verifica se existe um usuário cadastrado.
  bool existeUsuario(String email) {
    return _usuarios.any(
      (usuario) =>
          usuario.email.toLowerCase() == email.toLowerCase(),
    );
  }

  // Retorna a lista de documentos disponíveis.
  List<Documento> listarDocumentos() {
    return List.unmodifiable(_documentos);
  }
}
