import 'package:flutter/material.dart';
import 'package:app_agenda/pages/authentication/login/login_page_content.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final double _desktopContainerWidth = 580;
  late final double _desktopContainerHeight = _desktopContainerWidth * 1.00;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        desktop: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                CSColors.backgroundV1.color,
                CSColors.background.color,
                CSColors.background.color,
                CSColors.lightBackground.color,
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Container(
              width: _desktopContainerWidth,
              height: _desktopContainerHeight,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CSColors.lightBackground.color,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              ),
              child: const LoginPageContent(),
            ),
          ),
        ),
        mobile: Container(
          color: CSColors.lightBackground.color,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(30),
              child: const LoginPageContent(),
            ),
          ),
        ),
      ),
    );
  }
}
