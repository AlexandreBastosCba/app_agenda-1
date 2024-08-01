// ignore_for_file: must_be_immutable

import 'package:app_agenda/util/styles/cs_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class CSDropdownButton extends StatefulWidget {
  final double menuHeight;
  String? selectedItem;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;

  CSDropdownButton({
    super.key,
    this.menuHeight = 245,
    required this.items,
    this.selectedItem,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    required this.onChanged,
    this.validator,
  });

  @override
  State<CSDropdownButton> createState() => _CSDropdownButtonState();
}

class _CSDropdownButtonState extends State<CSDropdownButton> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, constraints) {
      return SizedBox(
        /* Com o height definido, a mensagem de erro que aparece abaixo
        do input ao validar o formulário quebra o formato do input*/
        height: widget.validator == null
            ? CSDarkTheme.inputHeight
            : null,
        // height: CSDarkTheme.inputHeight,
        child: DropdownButtonFormField(
          value: widget.selectedItem,
          items: widget.items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value.toString()),
                );
              }).toList(),
          onChanged: widget.onChanged,
          validator: widget.validator,
          alignment: Alignment.center,
          isExpanded: true,
          menuMaxHeight: widget.items.length <= 5
                  ? null
                  : widget.menuHeight,
          icon: const Icon(
            LineIcons.angleDown,
            size: 18.0,
          ),
          focusColor: Colors.transparent,
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            helperText: widget.helperText,
            counterText: '',
            focusColor: Colors.transparent,
          ).applyDefaults(CSDarkTheme.specificInputDecorationTheme),
        ),
      );
    });
  }
}
