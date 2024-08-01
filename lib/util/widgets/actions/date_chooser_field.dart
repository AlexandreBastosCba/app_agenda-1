import 'package:brasil_fields/brasil_fields.dart';
import 'package:app_agenda/util/widgets/actions/cs_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DateChooserField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final String? Function(String?)? validator;

  const DateChooserField({
    super.key,
    required this.controller,
    this.labelText,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CSTextFormField(
      controller: controller,
      labelText: labelText,
      helperText: '',
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        DataInputFormatter(),
      ],
      validator: validator,
      suffixIcon: IconButton(
        onPressed: () {
          showDatePicker(
            context: context,
            locale: const Locale('pt', 'BR'),
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          ).then((value) {
            if (value != null) {
              controller.text = DateFormat("dd/MM/yyyy").format(value);
            }
          });
        },
        icon: const Icon(Icons.edit_calendar_outlined),
      ),
    );
  }
}
