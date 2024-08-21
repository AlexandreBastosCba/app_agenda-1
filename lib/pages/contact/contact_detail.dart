import 'package:app_agenda/models/contact/contact.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ContactDetail extends StatefulWidget {
  final Contact contact;

  const ContactDetail({
    super.key,
    required this.contact,
  });

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(bottom: 16.0),
            child: Text(widget.contact.nome,
                style: CSTextSyles.largeTitle(context)),
          ),
          _buildCard('Telefone', _formatPhone(widget.contact.telefone)),
          _buildCard('CPF', _formatCpf(widget.contact.cpf)),
          _buildCard(
              'Data de Nascimento', _formatDate(widget.contact.dtNascimento)),
          _buildCard('Departamento',
              '${widget.contact.departamento} - ${widget.contact.sigla}'),
        ],
      ),
    );
  }

  String _formatCpf(String cpf) {
    // Remove caracteres não numéricos do CPF
    final cleanedCpf = cpf.replaceAll(RegExp(r'\D'), '');

    // Verifica se o CPF possui o número de dígitos esperado (11)
    if (cleanedCpf.length == 11) {
      // Formata o CPF no formato XXX.XXX.XXX-XX
      return '${cleanedCpf.substring(0, 3)}.${cleanedCpf.substring(3, 6)}.${cleanedCpf.substring(6, 9)}-${cleanedCpf.substring(9, 11)}';
    }

    // Retorna o CPF sem formatação se não tiver 11 dígitos
    return cpf;
  }

  String _formatPhone(String phone) {
    // Remove caracteres não numéricos e aplica o formato
    phone = phone.replaceAll(RegExp(r'\D'), '');
    if (phone.length == 11) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 7)}-${phone.substring(7)}';
    } else if (phone.length == 10) {
      return '(${phone.substring(0, 2)}) ${phone.substring(2, 6)}-${phone.substring(6)}';
    }
    return phone; // Retorna sem formatação se o tamanho não for esperado
  }

  String _formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    return formatter.format(date);
  }

  Widget _buildCard(String title, String content) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        onTap: () {},
        title: Text(
          title,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        subtitle: Text(content,
            style: Theme.of(context).textTheme.labelLarge?.apply(
                  // Aplica a cor azul ao texto (cor padrão do tema é preta
                  color: Colors.blue[900],
                )),
      ),
    );
  }
}
