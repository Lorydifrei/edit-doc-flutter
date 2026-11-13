
import 'package:flutter_test/flutter_test.dart';

import 'package:edit_doc_flutter/main.dart';
import 'package:edit_doc_flutter/views/login_view.dart';

void main() {
  testWidgets('Login vazio não avança para a Home', (tester) async {
    await tester.pumpWidget(const MeusDocumentosApp());

    expect(find.byType(LoginView), findsOneWidget);

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    // Continua na tela de login porque a validação bloqueou.
    expect(find.byType(LoginView), findsOneWidget);
  });

  testWidgets('Navega do login para o cadastro', (tester) async {
    await tester.pumpWidget(const MeusDocumentosApp());

    await tester.tap(find.text('Não tem uma conta? Cadastre-se'));
    await tester.pumpAndSettle();

    expect(find.text('Criar conta'), findsOneWidget);
  });
}