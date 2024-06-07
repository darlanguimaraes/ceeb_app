import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_formatter.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:flutter/material.dart';

class CategoryListCard extends StatelessWidget {
  final CategoryModel category;

  const CategoryListCard({
    super.key,
    required this.category,
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
            category.name,
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Text(
            TextFormatter.formatReal(category.price),
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => Navigator.of(context).pushNamed(
              Constants.ROUTE_CATEGORY_FORM,
              arguments: category,
            ),
          ),
        ),
      ),
    );
  }
}
