import 'package:flutter/material.dart';

class LoadingPage extends StatefulWidget {
  final Future<bool> Function()? condition;
  final void Function()? onSucess;
  final void Function()? onFail;

  const LoadingPage({
    super.key,
    this.condition,
    this.onSucess,
    this.onFail,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    if (widget.condition != null && await widget.condition!()) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        widget.onSucess?.call();
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2000), () {
        widget.onFail?.call();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Carregando...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            LinearProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
