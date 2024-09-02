import 'package:app_agenda/util/styles/cs_dark_theme.dart';
import 'package:flutter/material.dart';

class CSSearchBar extends StatefulWidget {
  final void Function(String)? onQueryChanged;
  final TextEditingController? textEditingController;

  const CSSearchBar({
    this.onQueryChanged,
    this.textEditingController,
    super.key,
  });

  @override
  State<CSSearchBar> createState() => _CSSearchBarState();
}

class _CSSearchBarState extends State<CSSearchBar> {
  String query = '';

  void onQueryChanged(String newQuery) {
    setState(() {
      query = newQuery;
    });
    widget.onQueryChanged?.call(query);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(0),
      height: 45,
      child: TextField(
        controller: widget.textEditingController,
        onChanged: onQueryChanged,
        decoration: const InputDecoration(
          labelText: 'Buscar',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(100)),
          ),
          prefixIcon: Icon(Icons.search),
        ).applyDefaults(CSDarkTheme.specificInputDecorationTheme),
      ),
    );
  }
}
