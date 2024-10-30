import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LendingModal extends StatefulWidget {
  final LendingModel lending;
  final bool renew;
  final Future<void> Function(int) renewLending;
  final Future<void> Function(int) returnLending;

  const LendingModal({
    super.key,
    required this.lending,
    required this.renew,
    required this.renewLending,
    required this.returnLending,
  });

  @override
  State<LendingModal> createState() => _LendingModalState();
}

class _LendingModalState extends State<LendingModal> {
  int penalty(LendingModel lending) {
    final DateTime actual = DateTime.now();
    if (actual.millisecondsSinceEpoch <
        lending.expectedDate.millisecondsSinceEpoch) return 0;
    final value = lending.expectedDate.compareTo(actual);
    if (value > 0) return value;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.renew ? 'Renovação ' : 'Devolução';
    final lending = widget.lending;
    final daysPenalty = penalty(lending);

    final styleText = context.textStyles.textMedium.copyWith(fontSize: 18);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.screenWidth * .8,
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    '$title de Livro',
                    style: context.textStyles.textBold.copyWith(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(),
                Text(
                  'Livro: ${lending.bookName} (${lending.bookCode})',
                  style: styleText,
                ),
                const SizedBox(height: 15),
                Text(
                  'Leitor: ${widget.lending.readerName}',
                  style: styleText,
                ),
                const SizedBox(height: 15),
                Text(
                  'Data de empréstimo: ${DateFormat('dd/MM/yyyy').format(lending.date)}',
                  style: styleText,
                ),
                Text(
                  'Previsão de entrega: ${DateFormat('dd/MM/yyyy').format(lending.expectedDate)}',
                  style: styleText,
                ),
                if (daysPenalty > 0)
                  Column(
                    children: [
                      const SizedBox(height: 15),
                      Text(
                        'Multa: $daysPenalty dias',
                        style: context.textStyles.textBold.copyWith(
                          color: Colors.red,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancelar'),
                    ),
                    if (widget.renew)
                      ElevatedButton(
                        onPressed: () => widget.renewLending(lending.id!),
                        child: const Text('Renovar'),
                      ),
                    if (!widget.renew)
                      ElevatedButton(
                        onPressed: () => widget.returnLending(lending.id!),
                        child: const Text('Devolver'),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
