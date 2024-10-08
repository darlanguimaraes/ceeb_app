import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LeadingListCard extends StatelessWidget {
  final LeadingModel leading;

  const LeadingListCard({
    super.key,
    required this.leading,
  });

  bool isLate() {
    final DateTime actual = DateTime.now();
    final value = leading.expectedDate.compareTo(actual);
    return value < 0;
  }

  Icon leadingIcon() {
    if (leading.returned) {
      const Icon(
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        color: Colors.grey[100],
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          title: Text(
            leading.readerName ?? '',
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(leading.bookName!),
              Text(
                  'Data de entrega: ${DateFormat('dd/MM/yyyy').format(leading.expectedDate)}')
            ],
          ),
          leading: leadingIcon(),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_LEADING_FORM,
              arguments: leading,
            ),
          ),
        ),
      ),
    );
  }
}
