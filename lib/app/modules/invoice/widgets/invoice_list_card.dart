import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_formatter.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InvoiceListCard extends StatelessWidget {
  final InvoiceModel invoice;

  const InvoiceListCard({
    super.key,
    required this.invoice,
  });

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('dd/MM/yyyy').format(invoice.date);
    final value = TextFormatter.formatReal(invoice.value);
    return Card(
      elevation: 5,
      child: Container(
        color: Colors.grey[100],
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          title: Text(
            '${invoice.categoryName} - $value',
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Text('$date - ${invoice.paymentType}'),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_INVOICE_FORM,
              arguments: invoice,
            ),
          ),
        ),
      ),
    );
  }
}
