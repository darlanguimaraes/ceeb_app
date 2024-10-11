import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_formatter.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/modules/category/widgets/modal_admin.dart';
import 'package:flutter/material.dart';

class CategoryListCard extends StatelessWidget {
  final CategoryModel category;
  final GlobalKey keyModal;

  const CategoryListCard({
    super.key,
    required this.category,
    required this.keyModal,
  });

  Future<void> _showRestrictedModal(BuildContext context) async {
    final authorized = await showDialog(
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
            child: const ModalAdmin(),
          ),
        );
      },
    );

    if (authorized) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(
        Constants.ROUTE_CATEGORY_FORM,
        arguments: category,
      );
    }
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
            category.name,
            style: context.textStyles.textBold.copyWith(fontSize: 20),
          ),
          subtitle: Text(
            category.price != null
                ? TextFormatter.formatReal(category.price!)
                : '',
          ),
          trailing: IconButton(
            icon: const Icon(
              Icons.edit,
              size: 30,
            ),
            onPressed: () => _showRestrictedModal(context),
          ),
        ),
      ),
    );
  }
}
