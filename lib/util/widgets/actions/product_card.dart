// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:app_agenda/util/view/view_utils.dart';
import 'package:app_agenda/util/widgets/actions/card_icon_button.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  // static const double legendHHeight1200 = 96;
  static const double legendHeight1000 = 120;
  // static const double legendHeight630 = 79;
  //Tamanho antigo não era suficiente para o texto
  static const double legendHeight630 = 100;
  static const double legendHeight375 = 130;
  static const double legendHeight310 = 150;
  static const double legendHeighBelow310 = 173;
  // static const double adaptivePoint1200 = 1200;
  static const double adaptivePoint1000 = 1000;
  static const double adaptivePoint630 = 630;
  static const double adaptivePoint375 = 375;
  static const double adaptivePoint310 = 310;
  String? imageUrl;
  String? description;
  String? category;  
  double? unitPrice;
  bool? isDeleted;
  bool displayEditButtons;
  void Function()? onEditPressed;
  void Function()? onConfirmDisable;
  void Function()? onConfirmEnable;
  void Function()? onCardTap;

  ProductCard({
    super.key,
    this.imageUrl,
    this.description,
    this.category,
    this.unitPrice = 0,
    this.isDeleted = false,
    this.displayEditButtons = false,
    this.onEditPressed,
    this.onConfirmDisable,
    this.onConfirmEnable,
    this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return InkWell(
          onTap: onCardTap ?? () {},
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Column(
            children: [
              SizedBox.square(
                dimension: constraints.maxWidth,
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image(
                        image: CachedNetworkImageProvider(
                          imageUrl ?? '',
                          maxWidth: constraints.maxWidth.toInt(),
                          maxHeight: constraints.maxWidth.toInt(),
                        ),
                        width: constraints.maxWidth,
                        height: constraints.maxWidth,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        errorBuilder: (context, error, stackTrace) {
                          return Center(
                            child: Text('Erro ao carregar a imagem!',
                              textAlign: TextAlign.center,
                              style: CSTextSyles.alertText(context),
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Center(
                            child: CircularProgressIndicator(
                              color: CSColors.secondaryV1.color,
                            ),
                          );
                        },
                      ),
                    ),
                    displayEditButtons
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CardIconButton(
                            context,
                            icon: Icons.edit_outlined,
                            onPressed: onEditPressed,
                          ),
                          isDeleted!
                              ? CardIconButton(
                                context,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Ativar produto'),
                                        content: const Text('Tem certeza que deseja ativar este produto?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              if(onConfirmEnable != null) onConfirmEnable!.call();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ativar'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancelar'),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                icon: Icons.check_circle_outline_outlined,
                              )
                              : CardIconButton(
                                context,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Desativar produto'),
                                        content: const Text('Tem certeza que deseja desativar este produto?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () async {
                                              if(onConfirmDisable != null) onConfirmDisable!.call();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Desativar'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(context),
                                            child: const Text('Cancelar'),
                                          ),
                                        ],
                                      );
                                    }
                                  );
                                },
                                icon: Icons.cancel_outlined,
                              ),
                        ],
                      )
                      : const SizedBox.shrink()
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.width > adaptivePoint1000
                        ? legendHeight1000
                        : MediaQuery.of(context).size.width > adaptivePoint630
                            ? legendHeight630
                            : MediaQuery.of(context).size.width > adaptivePoint375
                                ? legendHeight375
                                : MediaQuery.of(context).size.width > adaptivePoint310
                                    ? legendHeight310
                                    : legendHeighBelow310,
                padding: MediaQuery.of(context).size.width > adaptivePoint1000
                    ? const EdgeInsets.only(top: 16)
                    : const EdgeInsets.only(
                      top: 8,
                      left: 8,
                      right: 8,
                    ),
                alignment: Alignment.topLeft,
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: CSColors.primary.color,
                      fontSize: MediaQuery.of(context).size.width > adaptivePoint1000 ? 16 : 14,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                    ),
                    children: [
                      TextSpan(
                        text: description,
                      ),
                      TextSpan(
                        text: isDeleted! ? ' - ' : '',
                      ),
                      TextSpan(
                        text: isDeleted! ? 'Produto Desativado' : '',
                        style: TextStyle(
                          color: CSColors.errorText.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      TextSpan(
                        text: '\n$category',
                        style: TextStyle(
                          color: CSColors.secondaryV1.color,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: '\n${ViewUtils.formatDoubleToCurrency(unitPrice!)}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
