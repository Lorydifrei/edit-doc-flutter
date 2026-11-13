
class Documento {
  final String id;
  String titulo;
  String conteudo;
  final DateTime dataCriacao;
  DateTime dataAtualizacao;

  Documento({
    required this.id,
    required this.titulo,
    required this.conteudo,
    DateTime? dataCriacao,
    DateTime? dataAtualizacao,
  })  : dataCriacao = dataCriacao ?? DateTime.now(),
        dataAtualizacao = dataAtualizacao ?? DateTime.now();
}
