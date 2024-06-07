import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';

mixin Messages<T extends StatefulWidget> on State<T> {
  void showError(String message) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Erro',
        message: message,
        contentType: ContentType.failure,
      ),
    );
  }

  void showModalError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: SingleChildScrollView(
              child: Container(
                width: context.screenWidth *
                    (context.screenWidth > 1200 ? .5 : .9),
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Erro',
                            textAlign: TextAlign.center,
                            style: context.textStyles.textTitle
                                .copyWith(color: Colors.red),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Icon(Icons.close),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Text(
                      message,
                      style: context.textStyles.textSemiBold
                          .copyWith(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showWarning(String message) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: message,
        contentType: ContentType.warning,
      ),
    );
  }

  void showInfo(String message) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Atenção',
        message: message,
        contentType: ContentType.help,
      ),
    );
  }

  void showSuccess(String message) {
    _showSnackBar(
      AwesomeSnackbarContent(
        title: 'Sucesso',
        message: message,
        contentType: ContentType.success,
      ),
    );
  }

  void _showSnackBar(AwesomeSnackbarContent content) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.only(top: 72),
        backgroundColor: Colors.transparent,
        content: content,
      ),
    );
  }
}
