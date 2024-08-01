class Contact {
  final int idPessoa;
  final String cpf;
  final String nome;
  final DateTime dtNascimento;
  final String telefone;
  final int idLotacao;
  final String departamento;
  final String sigla;

  Contact({
    required this.idPessoa,
    required this.cpf,
    required this.nome,
    required this.dtNascimento,
    required this.telefone,
    required this.idLotacao,
    required this.departamento,
    required this.sigla,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      idPessoa: json['id_pessoa'],
      cpf: json['cpf'],
      nome: json['nome'],
      dtNascimento: DateTime.parse(json['dt_nascimento']),
      telefone: json['telefone'],
      idLotacao: json['id_lotacao'],
      departamento: json['departamento'],
      sigla: json['sigla'],
    );
  }
}