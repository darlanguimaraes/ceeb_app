import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

class ModalAdmin extends StatefulWidget {
  const ModalAdmin({super.key});

  @override
  State<ModalAdmin> createState() => _ModalAdminState();
}

class _ModalAdminState extends State<ModalAdmin> {
  final _formKey = GlobalKey<FormState>();
  final _passwordEC = TextEditingController();
  String _errorMessage = '';

  void _submit() {
    setState(() {
      _errorMessage = '';
    });
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      if (_passwordEC.text == const String.fromEnvironment('password')) {
        Navigator.of(context).pop(true);
      } else {
        setState(() {
          _errorMessage = 'Acesso negado!';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.screenWidth * .6,
      height: context.screenHeight * .5,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              'Área restrita',
              textAlign: TextAlign.center,
              style: context.textStyles.textBold.copyWith(
                color: Colors.red,
                fontSize: 30,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Para acessar o formulário, informe a senha de acesso',
              textAlign: TextAlign.center,
              style: context.textStyles.textMedium.copyWith(
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            CeebField(
              label: 'Senha',
              obscureText: true,
              controller: _passwordEC,
              validator: Validatorless.required('Senha é obrigatório'),
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
                  onPressed: _submit,
                  child: const Text('Entrar'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              _errorMessage,
              style: context.textStyles.textBold
                  .copyWith(color: Colors.red, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
