
class Users {
  String? cpf;
  DateTime? birthday;

  Users({
    this.cpf,
    this.birthday,
  });

  //Método para converter o objeto em um documento
  Map<String, dynamic> toJson() {
    return {
      "cpf": cpf,
      "birthday": birthday,
    };
  }
}