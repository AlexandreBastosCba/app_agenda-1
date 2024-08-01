// ignore_for_file: prefer_final_fields, must_be_immutable

import 'package:app_agenda/models/users/users_service.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/view/view_utils.dart';
import 'package:app_agenda/util/widgets/actions/cs_popup_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  Widget? selectedPage;

  MainPage({
    super.key,
    this.selectedPage,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late double heightAppBar;
  final double deskHeightAppBar = 70;
  final double mobHeightAppBar = 70;
  final double mobileAppBarPadding = 18;
  final double deskIconSize = 24;
  final double mobIconSize = 24;
  Widget addActionsGap() {
    if (Responsive.isDesktop(context)) {
      return const Gap(15);
    } else {
      return const Gap(8);
    }
  }

  List<PopupMenuEntry<int>> defaultPopMenuItems(
      BuildContext context, UsersServices usersServices) {
    return [
      CSPopupMenuItem.add(
        context: context,
        value: 1,
        text: "Sair",
        icon: ViewUtils.defaultLogoutIcon,
        onTap: () {
          ViewUtils.instance.safeSignOut(context, usersServices.signOut);
        },
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    ViewUtils.instance.blockNonLoggedUsers(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    //Definindo a altura da appbar segundo o tamanho da tela
    Responsive.isDesktop(context)
        ? heightAppBar = deskHeightAppBar
        : heightAppBar = mobHeightAppBar;

    return Consumer<UsersServices>(builder: (context, usersServices, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(heightAppBar),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal:
                  Responsive.isDesktop(context) ? 25 : mobileAppBarPadding,
            ),
            // color: CSColors.backgroundV1.color,
            child: AppBar(
              toolbarHeight: double.maxFinite,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,

              /* ------ Leading ------ */
              leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.arrow_back_ios_outlined),
              ),

              /* ------ Title: Only for desktop !!!!!!!!!!!!!!! ------ */
              centerTitle: true,

              /* ------ Actions ------ */
              actionsIconTheme: IconThemeData(
                size:
                    Responsive.isDesktop(context) ? deskIconSize : mobIconSize,
              ),
              actions: [
                PopupMenuButton<int>(
                  tooltip: (() {
                    try {
                      // return usersServices.currentUsers!.cpf;
                    } catch(e) {
                      return "Usuário";
                    }
                  })(),
                  icon: Icon(Icons.account_circle_rounded,
                      size: Responsive.isDesktop(context)
                          ? deskIconSize * 1.4
                          : mobIconSize * 1.4),
                  itemBuilder: (context) =>
                      defaultPopMenuItems(context, usersServices),
                  offset: const Offset(0, 5),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: widget.selectedPage,
        ),
      );
    });
  }
}
