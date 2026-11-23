import 'package:flutter_test/flutter_test.dart';

import 'package:edit_doc_flutter/main.dart';
import 'package:edit_doc_flutter/models/services/banco_local_service.dart';
import 'package:edit_doc_flutter/views/login_view.dart';

void main() {
  testWidgets('Login vazio não avança para a Home', (tester) async {
    final banco = BancoLocalService();

    await tester.pumpWidget(
      MeusDocumentosApp(banco: banco),
    );

    expect(find.byType(LoginView), findsOneWidget);

    await tester.tap(find.text('Entrar'));
    await tester.pump();

    expect(find.byType(LoginView), findsOneWidget);
  });

testWidgets('Navega do login para o cadastro', (tester) async {
    final banco = BancoLocalService();

    await tester.pumpWidget(
      MeusDocumentosApp(banco: banco),
    );

    await tester.tap(find.text('Não tem uma conta? Cadastre-se'));
    await tester.pumpAndSettle();

    expect(find.text('Criar conta'), findsOneWidget);
  });}
