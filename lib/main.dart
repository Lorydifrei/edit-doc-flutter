import 'package:flutter/material.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/documentos_viewmodel.dart';
import 'views/login_view.dart';
import 'views/cadastro_view.dart';
import 'views/home_view.dart';
import 'views/editor_view.dart';

void main() => runApp(const MeusDocumentosApp());

class MeusDocumentosApp extends StatefulWidget {
  const MeusDocumentosApp({super.key});

  @override
  State<MeusDocumentosApp> createState() => _MeusDocumentosAppState();
}

class _MeusDocumentosAppState extends State<MeusDocumentosApp> {
  final _authViewModel = AuthViewModel();
  final _documentosViewModel = DocumentosViewModel();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Documentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
      initialRoute: '/',
      routes: {
        '/': (_) => LoginView(authViewModel: _authViewModel),
        '/cadastro': (_) => CadastroView(authViewModel: _authViewModel),
        '/home': (_) => HomeView(documentosViewModel: _documentosViewModel),
        '/editor': (_) => const EditorView(),
      },
    );
  }
}