import 'package:app_agenda/models/users/users_service.dart';
import 'package:app_agenda/util/widgets/actions/cs_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

class ViewUtils {
  // Singleton
  static ViewUtils? _instance;

   ViewUtils._();

  static ViewUtils get instance {
    _instance ??= ViewUtils._();
    return _instance!;
  }

  // Constants
  static const String defaultUnexpectedErrorMessage = 'Ocorreu um erro inesperado. Tente novamente mais tarde, permanecendo o erro, entre em contato com o suporte.';
  static const String allProductQuery = 'Todos';
  static const IconData defaultOrdersIcon = LineIcons.box;
  static const IconData defaultUserIcon = Icons.person_outline_outlined;
  static const IconData defaultFavoriteIcon = Icons.favorite_border_outlined;
  static const IconData defaultNotificationsIcon = Icons.notifications_none_outlined;
  static const IconData defaultHelpIcon = Icons.help_outline_outlined;
  static const IconData defaultLogoutIcon = Icons.logout_outlined;
  static const IconData defaultDeleteIcon = Icons.delete_outline_outlined;
  static const IconData defaultFilterIcon = Icons.tune_outlined;
  static const IconData defaultPaymentIcon = Icons.credit_card_outlined;
  static const double defaultContentWidth = 780;
  static const double defaultMobileContentHorizontalPadding = 15;
  static const double defaultDesktopContentHorizontalPadding = defaultMobileContentHorizontalPadding * 2;
  static const double formsGapSize = 24;

  // Methods
  static final brazilianCurrencyFormat = NumberFormat("#,##0.00", "pt_BR");
  static String formatDoubleToCurrency(double value) {
    return "R\$ ${ViewUtils.brazilianCurrencyFormat.format(value)}";
  }

  static String? validateRequiredField(String? value) {
    if(value == null || value.isEmpty) {
      return 'Campo obrigatório.';
    }
    return null;
  }

  /* 
    Methods to redirect logged users to home page 
    and block non logged users from accessing pages
  */
  bool enableRedirectLoggedUsersToHome = true;
  bool enableBlockNonLoggedUsers = true;

  void redirectLoggedUsersToHome({
    required BuildContext context,
    String? message
  }) {
    var usersServices = Provider.of<UsersServices>(context);
     WidgetsBinding.instance.addPostFrameCallback((_) {
      if(usersServices.currentUsers != null && instance.enableRedirectLoggedUsersToHome) {
        Navigator.pushReplacementNamed(context, '/contacts');
        ScaffoldMessenger.of(context).showSnackBar(
          CSSnackBar(
            text: message ?? 'Você já está logado! Caso queira trocar de conta, faça logout primeiro.',
            actionType: CSSnackBarActionType.info,
          ),
        );
      }
    });
  }

  void blockNonLoggedUsers(BuildContext context) {
    var usersServices = Provider.of<UsersServices>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(usersServices.currentUsers == null && instance.enableBlockNonLoggedUsers) {
        Navigator.pushReplacementNamed(context, '/');
        ScaffoldMessenger.of(context).showSnackBar(
          CSSnackBar(
            text: 'Você precisa estar logado para acessar esta página!',
            actionType: CSSnackBarActionType.error,
          ),
        );
      }
    });
  }

  void safeSignIn(BuildContext context) {
    instance.enableRedirectLoggedUsersToHome = false;
    instance.enableBlockNonLoggedUsers = false;
    Navigator.pushReplacementNamed(context, '/contacts');
    Future.delayed(const Duration(milliseconds: 1500), () {
      instance.enableRedirectLoggedUsersToHome = true;
      instance.enableBlockNonLoggedUsers = true;
    });
  }

  void safeSignOut(BuildContext context, Function? signOut) {
    instance.enableRedirectLoggedUsersToHome = false;
    instance.enableBlockNonLoggedUsers = false;
    signOut!();
    Navigator.pushReplacementNamed(context, '/');
    Future.delayed(const Duration(milliseconds: 1000), () { 
      instance.enableRedirectLoggedUsersToHome = true;
      instance.enableBlockNonLoggedUsers = true;
    });
  }

  static void hasReachedAddressesLimitScaffoldMessenger(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      CSSnackBar(
        text: 'Você atingiu o limite(10) de endereços cadastrados!',
        actionType: CSSnackBarActionType.error,
      )
    );
  }
}
