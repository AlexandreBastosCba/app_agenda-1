import 'package:app_agenda/models/users/users_service.dart';
import 'package:app_agenda/util/view/view_utils.dart';
import 'package:app_agenda/util/widgets/actions/cs_snack_bar.dart';
import 'package:app_agenda/util/widgets/actions/date_chooser_field.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:app_agenda/util/widgets/actions/cs_text_form_field.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LoginPageContent extends StatefulWidget {
  static const double width = 350;
  static const double height = width * 1.00;

  const LoginPageContent({super.key});

  @override
  State<LoginPageContent> createState() => _LoginPageContentState();
}

class _LoginPageContentState extends State<LoginPageContent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _birthday = TextEditingController();
  final double _gapSize = 16;

  @override
  void didChangeDependencies() {
    ViewUtils.instance.redirectLoggedUsersToHome(context: context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersServices>(builder: (context, usersServices, child) {
      return SizedBox(
        height: LoginPageContent.height,
        width: LoginPageContent.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // SvgPicture.asset('/images/logos/main/main_logo.svg', width: LoginPageContent.width),
            Text(
              'Bem-Vindo de Volta!',
              textAlign: TextAlign.center,
              style: CSTextSyles.decoratedTitle(context),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CSTextFormField(
                    controller: _cpf,
                    labelText: 'CPF',
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter(),
                    ],
                    validator: UsersServices.validateCpf,
                  ),
                  Gap(1.3 * _gapSize),
                  DateChooserField(
                    labelText: 'Data de nascimento',
                    controller: _birthday,
                    validator: UsersServices.validateBirthday,
                  ),
                  Gap(2 * _gapSize),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        if (await usersServices.signIn(
                          _cpf.text,
                          DateFormat("dd/MM/yyyy").parse(_birthday.text),
                        )) {
                          // ignore: use_build_context_synchronously
                          ViewUtils.instance.safeSignIn(context);
                        } else {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            CSSnackBar(
                              text: 'Credenciais inválidas!',
                              actionType: CSSnackBarActionType.error,
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CSColors.primarySwatchV2.color,
                    ),
                    child: const Text('Entrar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
