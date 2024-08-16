import 'package:app_agenda/models/contact/contact.dart';
import 'package:app_agenda/models/contact/contact_service.dart';
import 'package:app_agenda/pages/contact/contact_detail.dart';
import 'package:app_agenda/pages/main/main_page.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:app_agenda/util/widgets/actions/cs_search_bar.dart';
import 'package:flutter/material.dart';

class ContactSearch extends StatefulWidget {
  const ContactSearch({super.key});

  @override
  State<ContactSearch> createState() => _ContactSearchState();
}

class _ContactSearchState extends State<ContactSearch> {
  final ContactService _contactService = ContactService();
  late Future<List<Contact>> _initialContactsFuture;
  late Future<List<Contact>> _actualContacts;

  @override
  void initState() {
    super.initState();
    _initialContactsFuture = _contactService.getContacts();
    _actualContacts = _initialContactsFuture;
  }

  void onQueryChanged(String query) {
    setState(() {
      if (query.isEmpty || query.trim().isEmpty) {
        _actualContacts = _initialContactsFuture;
        return;
      }
    });

    filterContacts(query);
  }

  Future<void> filterContacts(String query) async {
    // Obtém a lista atual de contatos
    List<Contact> contacts = await _actualContacts;

    // Filtra os contatos que contêm a substring fornecida no nome
    List<Contact> filteredContacts = contacts.where((contact) {
      // Converte o nome para minúsculas e verifica se a substring está presente
      return contact.nome!.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Atualiza a variável com a lista filtrada
    setState(() {
      _actualContacts = Future.value(filteredContacts);
    });
  }

  Container defaultContainer({required Widget child}) {
    return Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 40),
        child: child);
  }

  @override
  Widget build(BuildContext context) {
    var gap = SizedBox(height: Responsive.isDesktop(context) ? 15 : 10);

    return Container(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
      ),
      child: Column(
        children: <Widget>[
          gap,
          Container(
            alignment: Alignment.centerLeft,
            child: Text('Contatos', style: CSTextSyles.largeTitle(context)),
          ),
          gap,
          CSSearchBar(onQueryChanged: onQueryChanged),
          FutureBuilder<List<Contact>>(
            future: _actualContacts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                // Adiciona um delay de 0.2 segundo antes de mostrar o CircularProgressIndicator
                return FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 200)),
                  builder: (context, innerSnapshot) {
                    if (innerSnapshot.connectionState == ConnectionState.done) {
                      return defaultContainer(
                        child: const CircularProgressIndicator(),
                      );
                    } else {
                      // Retorna um Container vazio enquanto aguarda o delay
                      return Container();
                    }
                  },
                );
              }

              if (snapshot.hasError) {
                return defaultContainer(
                  child: const Text('Erro ao carregar contatos',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return defaultContainer(
                  child: const Text('Nenhum contato encontrado',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                );
              }

              final contacts = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: contacts.length,
                separatorBuilder: (context, index) =>
                    Divider(color: Colors.grey[300]), // Linha divisória cinza
                itemBuilder: (context, index) {
                  final contact = contacts[index];

                  return ListTile(
                    title: Text(contact.nome ?? 'Erro ao carregar nome!',
                        style: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 16)),
                    // subtitle:
                    //     Text(contact.phone ?? 'Erro ao carregar telefone'),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    onTap: () {
                      //Navega para a tela de detalhes do contato
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MainPage(
                          selectedPage: ContactDetail(contact: contact),
                        ),
                      ));
                    },
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
