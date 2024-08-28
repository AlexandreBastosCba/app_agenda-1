class Lotacao {
  final String departamento;
  final String sigla;

  Lotacao({
    required this.departamento,
    required this.sigla,
  });

  factory Lotacao.fromJson(Map<String, dynamic> json) {
    return Lotacao(
      departamento: json['departamento'],
      sigla: json['sigla'],
    );
  }
}
