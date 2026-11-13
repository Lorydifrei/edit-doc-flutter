
class Validadores {
  static String? validarNome(String? nome) {
    if (nome == null || nome.trim().isEmpty) {
      return 'Informe seu nome.';
    }

    if (nome.trim().length < 3) {
      return 'O nome deve ter pelo menos 3 caracteres.';
    }

    return null;
  }

  static String? validarEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Informe seu e-mail.';
    }

    final emailLimpo = email.trim();

    final regex = RegExp(
      r'^[^@\s]+@[^@\s]+\.(com|com\.br)$',
      caseSensitive: false,
    );

    if (!regex.hasMatch(emailLimpo)) {
      return 'Informe um e-mail válido (.com ou .com.br).';
    }

    return null;
  }

  static String? validarSenha(String? senha) {
    if (senha == null || senha.isEmpty) {
      return 'Informe sua senha.';
    }

    if (senha.length < 6) {
      return 'A senha deve ter pelo menos 6 caracteres.';
    }

    return null;
  }
}
