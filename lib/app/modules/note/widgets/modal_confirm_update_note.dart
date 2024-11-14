import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:flutter/material.dart';

class ModalConfirmUpdateNote extends StatelessWidget {
  final String status;

  const ModalConfirmUpdateNote({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: context.screenWidth * .6,
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Deseja alterar o status da nota para "$status"?',
                textAlign: TextAlign.center,
                style: context.textStyles.textBold.copyWith(
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
