import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:flutter/material.dart';

class BookListCard extends StatelessWidget {
  final BookModel book;

  const BookListCard({
    super.key,
    required this.book,
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
            book.name,
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Text(
            book.code,
          ),
          leading: book.borrow
              ? const Icon(
                  Icons.error,
                  color: Colors.red,
                )
              : const Icon(
                  Icons.check,
                  color: Colors.green,
                ),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_BOOK_FORM,
              arguments: book,
            ),
          ),
        ),
      ),
    );
  }
}
