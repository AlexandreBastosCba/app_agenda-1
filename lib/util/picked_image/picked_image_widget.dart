// ignore_for_file: must_be_immutable

import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/widgets/actions/card_icon_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class PickedImageWidget extends StatefulWidget {
    static const double defaultDimension = 300;
    Color? borderColor;
    final double? dimension;
    Image? image;
    final VoidCallback? readImage;
    String? validateMessage;

  PickedImageWidget({
    super.key,
    this.borderColor,
    this.dimension = defaultDimension,
    this.image,
    this.readImage,
    this.validateMessage,
  });

  @override
  State<PickedImageWidget> createState() => _PickedImageWidgetState();
}

class _PickedImageWidgetState extends State<PickedImageWidget> {
  @override
  Widget build(BuildContext context) {
    widget.borderColor ??= CSColors.border.color;

    return SizedBox.square(
      dimension: widget.dimension,
      child: DottedBorder(
        dashPattern: const [8, 4],
        color: widget.image == null
            ? widget.validateMessage != null
                ? CSColors.error.color
                : widget.borderColor!
            : Colors.transparent,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: widget.image ??
                  Text(
                    widget.validateMessage ??
                        'Clique no ícone acima para adicionar uma imagem',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: widget.validateMessage != null
                          ? CSColors.errorText.color
                          :CSColors.secondaryV1.color,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ),
            Container(
              alignment: Alignment.topRight,
              child: CardIconButton(
                context,
                icon: widget.image == null
                    ? Icons.image_search_rounded
                    : Icons.edit_outlined,
                onPressed: widget.readImage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
