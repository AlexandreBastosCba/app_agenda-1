import 'package:app_agenda/models/contact/contact.dart';
import 'package:app_agenda/models/contact/contact_service.dart';
import 'package:app_agenda/models/contact/lotacao.dart';
import 'package:app_agenda/pages/contact/contact_detail.dart';
import 'package:app_agenda/pages/main/main_page.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:app_agenda/util/widgets/actions/cs_search_bar.dart';
import 'package:flutter/material.dart';

class ContactSearch extends StatefulWidget {
  const ContactSearch({super.key});

  @override
  State<ContactSearch> createState() => _ContactSearchState();
}

class _ContactSearchState extends State<ContactSearch> {
  final TextEditingController _textEditingController = TextEditingController();
  final ContactService _contactService = ContactService();
  late Future<List<Contact>> _initialContactsFuture;
  late Future<List<Lotacao>> _lotacaoFuture;
  late Future<List<Contact>> _baseContactsList;
  late Future<List<Contact>> _actualContacts;

  List<String> _list = <String>[''];
  String? _dropdownValue;
  bool _filterLotacao = false;

  @override
  void initState() {
    super.initState();
    _initialContactsFuture = _contactService.getContacts();
    _baseContactsList = _initialContactsFuture;
    _actualContacts = _initialContactsFuture;
    _lotacaoFuture = _contactService.getLotacoes();
    defineListLotacaoDropdown();
  }

  void defineListLotacaoDropdown() async {
    List<Lotacao> lotacaoList = await _lotacaoFuture;

    setState(() {
      _list = lotacaoList.map((lotacao) => lotacao.departamento).toList();
      if (_list.isNotEmpty) {
        _dropdownValue = _list.first;
      }
    });
  }

  void onQueryChanged(String query) {
    if (query.isEmpty || query.trim().isEmpty) {
      setState(() {
        _actualContacts = _baseContactsList;
      });
    } else {
      filterContacts(query);
    }
  }

  Future<void> filterContacts(String query) async {
    // Obtém a lista atual de contatos
    List<Contact> contacts = await _baseContactsList;

    // Filtra os contatos que contêm a substring fornecida no nome
    List<Contact> filteredContacts = contacts.where((contact) {
      // Converte o nome para minúsculas e verifica se a substring está presente
      return contact.nome.toLowerCase().contains(query.toLowerCase());
    }).toList();

    // Atualiza a variável com a lista filtrada
    setState(
      () {
        _actualContacts = Future.value(filteredContacts);
      },
    );
  }

  Future<void> filterContactsByLotacao({String? lotacao}) async {
    // Obtém a lista inicial de contatos
    List<Contact> contacts = await _initialContactsFuture;

    // Filtra os contatos que contêm a lotação
    List<Contact> filteredContacts = contacts.where((contact) {
      // Converte o nome para minúsculas e verifica se a substring está presente
      return contact.departamento
          .toLowerCase()
          .contains(lotacao!.toLowerCase());
    }).toList();

    // Atualiza a lista de contatos com a lista filtrada
    setState(
      () {
        _baseContactsList = Future.value(filteredContacts);
      },
    );
    onQueryChanged(_textEditingController.text);
  }

  void refreshBaseList() async {
    List<Contact> contacts = await _initialContactsFuture;
    setState(() {
      _baseContactsList = Future.value(contacts);
    });
    onQueryChanged(_textEditingController.text);
  }

  Container defaultContainer({required Widget child}) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 40),
      child: child,
    );
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
            child: Text(
              'Contatos',
              style: CSTextSyles.largeTitle(context),
            ),
          ),
          gap,
          CSSearchBar(
            onQueryChanged: onQueryChanged,
            textEditingController: _textEditingController,
          ),
          gap,
          Row(
            children: [
              DropdownMenu<String>(
                leadingIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _filterLotacao = !_filterLotacao;
                    });
                    if (_filterLotacao) {
                      filterContactsByLotacao(
                        lotacao: _dropdownValue,
                      );
                    } else {
                      refreshBaseList();
                    }
                  },
                  icon: _filterLotacao
                      ? const Icon(Icons.filter_alt_off)
                      : const Icon(Icons.filter_alt),
                ),
                label: const Text('Lotação'),
                width: 190,
                initialSelection: _dropdownValue,
                onSelected: (String? value) {
                  setState(() {
                    _dropdownValue = value!;
                  });
                  // This is called when the user selects an item.
                  if (_filterLotacao) {
                    filterContactsByLotacao(lotacao: _dropdownValue);
                  }
                },
                dropdownMenuEntries: _list.map<DropdownMenuEntry<String>>(
                  (String value) {
                    return DropdownMenuEntry<String>(
                      value: value,
                      label: value,
                    );
                  },
                ).toList(),
              ),
            ],
          ),
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
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Nome: ${contact.nome}",
                                  // style: const TextStyle(
                                  //   fontWeight: FontWeight.w700,
                                  //   fontSize: 16,
                                  // ),
                                  style: CSTextSyles.alertText(context),
                                ),
                                Text(
                                  // "(${contact.telefone.substring(0, 2)}) ${contact.telefone.substring(2, 7)}-${contact.telefone.substring(7, 11)}",
                                  contact.telefone,
                                  style: CSTextSyles.alertText(context),
                                ),
                                Text(
                                  "Lotação: ${contact.departamento}",
                                  style: CSTextSyles.alertText(context),
                                ),
                              ],
                            ),
                            Icon(
                              Icons.account_box_sharp,
                              color: CSColors.appGreen.color,
                              size: 100,
                            ),
                          ],
                        ),
                      ],
                    ),
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
