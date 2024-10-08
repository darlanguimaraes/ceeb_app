import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:flutter/material.dart';

class ReaderListCard extends StatelessWidget {
  final ReaderModel reader;

  const ReaderListCard({
    super.key,
    required this.reader,
  });

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
            reader.name,
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Text(reader.phone),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_READER_FORM,
              arguments: reader,
            ),
          ),
        ),
      ),
    );
  }
}
