import 'package:app_agenda/util/styles/cs_colors.dart';
import 'package:app_agenda/util/view/view_utils.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AddressCard extends StatelessWidget {
  static const double iconSize = 20;
  final Color iconColor = CSColors.secondaryV1.color;
  final Function()? onEdit;
  final Function()? onConfirmDelete;
  final String? addressIdentification;
  final String? address;
  final String? number;
  final String? complement;
  final String? neighborhood;
  final String? city;
  final String? stateAcronym;
  final String? zipCode;

  AddressCard({
    super.key,
    this.onEdit,
    this.onConfirmDelete,
    required this.addressIdentification,
    this.address = '',
    this.number = '',
    this.complement = '',
    this.neighborhood = '',
    this.city = '',
    this.stateAcronym = '',
    this.zipCode = '',
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              addressIdentification!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 18,
                letterSpacing: 0.75,
                color: CSColors.primary.color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Gap(10),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
                '$address, $number${complement!.isNotEmpty ? ' - $complement\n' : '\n'}'
                '$neighborhood - $city - $stateAcronym\n'
                'Cep: $zipCode',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.3,
                  color: CSColors.secondaryV1.color,
                )),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: onEdit ?? () {},
                tooltip: 'Editar',
                icon: Icon(
                  Icons.edit_outlined,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
              IconButton(  
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Excluir endereço'),
                        content: const Text('Tem certeza que deseja excluir este endereço?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              if(onConfirmDelete != null) onConfirmDelete!.call();
                              Navigator.pop(context);
                            },
                            child: const Text('Excluir'),
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
                tooltip: 'Excluir',
                icon: Icon(
                  ViewUtils.defaultDeleteIcon,
                  size: iconSize,
                  color: iconColor,
                ),
              ),
            ],
          )
        ],
      ),
    ));
  }
}
