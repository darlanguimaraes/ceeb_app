import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_cubit.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class SynchronizePage extends StatefulWidget {
  const SynchronizePage({super.key});

  @override
  State<SynchronizePage> createState() => _SynchronizePageState();
}

class _SynchronizePageState
    extends BaseState<SynchronizePage, SynchronizeCubit> {
  final _formKey = GlobalKey<FormState>();

  final _userNameEC = TextEditingController();
  final _passwordEC = TextEditingController();

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      controller.sync(_userNameEC.text, _passwordEC.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SynchronizeCubit, SynchronizeState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados sincronizados com sucesso!');
          },
          error: () {
            hideLoader();
            showError('Erro ao sincronizar os dados');
          },
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
            Constants.ROUTE_MENU,
            (Route<dynamic> route) => false,
          );
        },
        child: Scaffold(
          appBar: CeebAppBar(
            title: 'Sincronizar Dados',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Login',
                    controller: _userNameEC,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validatorless.required('Login é obrigatório'),
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Senha',
                    controller: _passwordEC,
                    obscureText: true,
                    validator: Validatorless.required('Senha é obrigatório'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                          Constants.ROUTE_MENU,
                          (Route<dynamic> route) => false,
                        ),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Sincronizar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
