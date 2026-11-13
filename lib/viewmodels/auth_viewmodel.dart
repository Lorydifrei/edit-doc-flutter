
import 'package:flutter/material.dart';

import '../models/usuario.dart';
import '../models/services/banco_local_service.dart';

class AuthViewModel extends ChangeNotifier {
  final BancoLocalService _banco;

  AuthViewModel({BancoLocalService? banco})
      : _banco = banco ?? BancoLocalService();

  Usuario? _usuarioAtual;
  String? _mensagem;
  bool _carregando = false;

  Usuario? get usuarioAtual => _usuarioAtual;
  String? get mensagem => _mensagem;
  bool get carregando => _carregando;

  bool get autenticado => _usuarioAtual != null;

  // Realiza o login.
  bool login(String email, String senha) {
    _mensagem = null;
    _carregando = true;
    notifyListeners();

    final usuario = _banco.autenticarUsuario(
      email.trim(),
      senha,
    );

    _carregando = false;

    if (usuario == null) {
      _mensagem = 'E-mail ou senha incorretos.';
      notifyListeners();
      return false;
    }

    _usuarioAtual = usuario;
    _mensagem = null;
    notifyListeners();

    return true;
  }

  // Realiza o cadastro.
  bool cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) {
    _mensagem = null;

    final novoUsuario = Usuario(
      nome: nome.trim(),
      email: email.trim(),
      senha: senha,
    );

    final sucesso = _banco.cadastrarUsuario(novoUsuario);

    if (!sucesso) {
      _mensagem = 'Este e-mail já está cadastrado.';
      notifyListeners();
      return false;
    }

    _mensagem = 'Usuário cadastrado com sucesso!';
    notifyListeners();

    return true;
  }

  // Encerra a sessão.
  void logout() {
    _usuarioAtual = null;
    _mensagem = null;
    notifyListeners();
  }

  // Limpa mensagens exibidas na interface.
  void limparMensagem() {
    _mensagem = null;
    notifyListeners();
  }
}

