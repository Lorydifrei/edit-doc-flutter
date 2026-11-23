import 'package:flutter/material.dart';

import 'models/services/banco_local_service.dart';
import 'viewmodels/auth_viewmodel.dart';
import 'viewmodels/documentos_viewmodel.dart';
import 'views/login_view.dart';
import 'views/cadastro_view.dart';
import 'views/home_view.dart';
import 'views/editor_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final banco = BancoLocalService();
  await banco.inicializar();

  runApp(MeusDocumentosApp(banco: banco));
}

class MeusDocumentosApp extends StatefulWidget {
  final BancoLocalService banco;

  const MeusDocumentosApp({super.key, required this.banco});

  @override
  State<MeusDocumentosApp> createState() => _MeusDocumentosAppState();
}

class _MeusDocumentosAppState extends State<MeusDocumentosApp> {
  late final AuthViewModel _authViewModel;
  late final DocumentosViewModel _documentosViewModel;

  @override
  void initState() {
    super.initState();
    _authViewModel = AuthViewModel(banco: widget.banco);
    _documentosViewModel = DocumentosViewModel(banco: widget.banco);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meus Documentos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
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