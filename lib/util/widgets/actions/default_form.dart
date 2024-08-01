import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:app_agenda/util/responsive/responsive.dart';
import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/widgets/actions/cs_outline_button.dart';
import 'package:app_agenda/util/widgets/layouts/flexible_line.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app_agenda/util/styles/cs_text_styles.dart';
import 'package:app_agenda/util/view/view_utils.dart';

class DefaultForm extends StatefulWidget {
  static const double buttonWidth = 150;
  final Key? formKey;
  final void Function()? onAddition;
  final void Function()? onSave;
  final void Function()? onCancel;
  final void Function()? streamOnHasNoData;
  final String title;
  final bool isListing;
  final bool isStream;
  final Stream<dynamic>? stream;
  final Widget Function(AsyncSnapshot<dynamic>) contentBuilder;
  final Widget? streamHasNoDataContent;

  const DefaultForm({
    super.key,
    this.formKey,
    required this.title,
    this.isListing = false,
    this.isStream = false,
    this.stream,
    required this.contentBuilder,
    this.streamHasNoDataContent,
    this.onAddition,
    this.onSave,
    this.onCancel,
    this.streamOnHasNoData,
  });

  @override
  State<DefaultForm> createState() => _DefaultFormState();
}

class _DefaultFormState extends State<DefaultForm> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ViewUtils.defaultContentWidth,
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.title,
                    style: CSTextSyles.largeTitle(context),
                  ),
                ),
                if(widget.isListing) Flexible(
                  child: SizedBox(
                    width: DefaultForm.buttonWidth,
                    child: CSOutlineButton(
                      onPressed: widget.onAddition,
                      text: 'Adicionar',
                    ),
                  ),
                ),
              ],
            ),
            const Gap(ViewUtils.formsGapSize * 12 / 9),
            StreamBuilder<dynamic>(
              stream: widget.stream,
              builder: (context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasError) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text('Erro ao carregar os dados! Caso o erro persista, entre em contato com o suporte.',
                        textAlign: TextAlign.center,
                        style: CSTextSyles.alertText(context),
                      ),
                    ),
                  );
                } else if(widget.isStream 
                    && (!snapshot.hasData || snapshot.data == null 
                        || (snapshot.data is QuerySnapshot && snapshot.data.docs.isEmpty)
                        || (snapshot.data is DocumentSnapshot && snapshot.data.exists == false))) {
                  if(widget.streamOnHasNoData != null) {
                    widget.streamOnHasNoData!.call();
                  }
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: widget.streamHasNoDataContent ?? const CircularProgressIndicator()
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      widget.contentBuilder.call(snapshot),
                      const Gap(ViewUtils.formsGapSize),
                      !widget.isListing ? Column(
                        children: [
                          Row(
                            children: [
                              FlexibleLine(
                                color: CSColors.inversePrimary.color,
                                tickness: 0.8
                              ),
                            ],
                          ),
                          const Gap(ViewUtils.formsGapSize),
                          Container(
                            alignment: Responsive.isDesktop(context) ? Alignment.centerRight : Alignment.center,
                            child: Wrap(
                              direction: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
                              verticalDirection: Responsive.isDesktop(context) ? VerticalDirection.down : VerticalDirection.up,
                              children: [
                                SizedBox(
                                  width: DefaultForm.buttonWidth,
                                  child: TextButton(
                                    onPressed: widget.onCancel,
                                    child: const Text('Cancelar'),
                                  ),
                                ),
                                SizedBox(
                                  width: DefaultForm.buttonWidth,
                                  child: ElevatedButton(
                                    onPressed: widget.onSave,
                                    child: const Text('Salvar'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ) : Container(),
                    ],
                  );
                }
              }
            ),
          ],
        ),
      ),
    );
  }
}
