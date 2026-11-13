
import 'package:flutter/material.dart';

import '../models/documento.dart';
import '../models/services/banco_local_service.dart';

class DocumentosViewModel extends ChangeNotifier {
  final BancoLocalService _banco;

  DocumentosViewModel({BancoLocalService? banco})
      : _banco = banco ?? BancoLocalService() {
    carregarDocumentos();
  }

  List<Documento> _documentos = [];

  bool _carregando = false;
  String? _mensagem;

  List<Documento> get documentos =>
      List.unmodifiable(_documentos);

  bool get carregando => _carregando;

  String? get mensagem => _mensagem;

  // Carrega os documentos disponíveis.
  void carregarDocumentos() {
    _carregando = true;
    _mensagem = null;
    notifyListeners();

    try {
      _documentos = _banco.listarDocumentos();
    } catch (e) {
      _mensagem = 'Não foi possível carregar os documentos.';
    }

    _carregando = false;
    notifyListeners();
  }

  // Limpa mensagens de erro.
  void limparMensagem() {
    _mensagem = null;
    notifyListeners();
  }
}
