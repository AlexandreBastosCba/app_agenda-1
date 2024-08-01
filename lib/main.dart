import 'package:app_agenda/pages/authentication/login/login_page.dart';
import 'package:app_agenda/pages/contact/contact_search.dart';
import 'package:app_agenda/pages/main/main_page.dart';
import 'package:app_agenda/util/picked_image/picked_image_service.dart';
import 'package:app_agenda/util/styles/cs_dark_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:app_agenda/models/users/users_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UsersServices(),
          lazy: false,
        ),
        ChangeNotifierProvider<PickedImageService>(
          create: (context) => PickedImageService(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'App Agenda',
        debugShowCheckedModeBanner: false,
        theme: CSDarkTheme.themeData(context),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en'),
          Locale('es'),
        ],
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/contacts':(context) => MainPage(selectedPage: const ContactSearch()),
        },
      ),
    );
  }
}


