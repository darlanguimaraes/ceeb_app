import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/modules/lending/widgets/lending_modal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LendingListCard extends StatelessWidget {
  final LendingModel lending;
  final Future<void> Function(int) renewLending;
  final Future<void> Function(int) returnLending;
  final GlobalKey keyModal;

  const LendingListCard({
    super.key,
    required this.lending,
    required this.renewLending,
    required this.returnLending,
    required this.keyModal,
  });

  bool isLate() {
    final DateTime actual = DateTime.now();
    final value = lending.expectedDate.compareTo(actual);
    return value < 0;
  }

  int penalty() {
    final DateTime actual = DateTime.now();
    if (actual.millisecondsSinceEpoch <
        lending.expectedDate.millisecondsSinceEpoch) return 0;
    final value = lending.expectedDate.compareTo(actual);
    if (value > 0) return value;
    return 0;
  }

  Icon leadingIcon() {
    if (lending.returned) {
      return const Icon(
        Icons.check,
        color: Colors.green,
        size: 40,
      );
    }

    if (isLate()) {
      return const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 40,
      );
    }

    return const Icon(
      Icons.warning,
      color: Colors.amber,
      size: 40,
    );
  }

  void _showModal(BuildContext context, LendingModel lending, bool renew) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            key: keyModal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: LendingModal(
              lending: lending,
              renew: renew,
              renewLending: renewLending,
              returnLending: returnLending,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        children: [
          Container(
            color: Colors.grey[100],
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              title: Text(
                lending.readerName ?? '',
                style: context.textStyles.textBold.copyWith(fontSize: 20),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${lending.bookName!} (${lending.bookCode})'),
                  Text(
                      'Previsão entrega: ${DateFormat('dd/MM/yyyy').format(lending.expectedDate)}'),
                  if (lending.deliveryDate != null)
                    Text(
                        'Data de entrega: ${DateFormat('dd/MM/yyyy').format(lending.deliveryDate!)}'),
                  if (!lending.returned &&
                      lending.deliveryDate == null &&
                      penalty() > 0)
                    Text(
                      'MULTA: ${penalty()}',
                      style: context.textStyles.textBold.copyWith(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                    )
                ],
              ),
              leading: leadingIcon(),
              trailing: IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                ),
                onPressed: () => Navigator.of(context).pushNamed(
                  Constants.ROUTE_LENDING_FORM,
                  arguments: lending,
                ),
              ),
            ),
          ),
          if (!lending.returned)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _showModal(context, lending, true),
                  child: const Text('Renovar'),
                ),
                ElevatedButton(
                  onPressed: () => _showModal(context, lending, false),
                  child: const Text('Devolver'),
                ),
              ],
            ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
