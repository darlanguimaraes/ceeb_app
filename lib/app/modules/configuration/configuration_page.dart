import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/modules/configuration/cubit/configuration_cubit.dart';
import 'package:ceeb_app/app/modules/configuration/cubit/configuration_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState
    extends BaseState<ConfigurationPage, ConfigurationCubit> {
  final _passwordEC = TextEditingController();
  final _formKeyAuth = GlobalKey<FormState>();

  final _formKey = GlobalKey<FormState>();
  final _urlEC = TextEditingController();

  @override
  void dispose() {
    _passwordEC.dispose();
    _urlEC.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final valid = _formKeyAuth.currentState?.validate() ?? false;
    if (valid) {
      await controller.validateAuth(_passwordEC.text.trim());

      if (controller.state.configuration != null &&
          controller.state.configuration!.url != null) {
        _urlEC.text = controller.state.configuration!.url!;
      }
    }
  }

  void _submitConfiguration() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      controller.updateURL(_urlEC.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConfigurationCubit, ConfigurationState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Operação realizada');
          },
          error: () {
            hideLoader();
            showError(state.error);
          },
          authError: () {
            hideLoader();
            showError('Dados inválidos');
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
            title: 'Configuração',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: BlocConsumer<ConfigurationCubit, ConfigurationState>(
              builder: (context, state) {
                if (!state.isAuth) {
                  return Form(
                    key: _formKeyAuth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        CeebField(
                          label: 'Senha',
                          obscureText: true,
                          controller: _passwordEC,
                          validator:
                              Validatorless.required('Senha é obrigatório'),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamedAndRemoveUntil(Constants.ROUTE_MENU,
                                      (Route<dynamic> route) => false),
                              child: const Text('Cancelar'),
                            ),
                            ElevatedButton(
                              onPressed: _submit,
                              child: const Text('Entrar'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CeebField(
                        label: 'URL para sincronização dos dados',
                        controller: _urlEC,
                        validator: Validatorless.required('URL é obrigatório'),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context)
                                .pushNamedAndRemoveUntil(Constants.ROUTE_MENU,
                                    (Route<dynamic> route) => false),
                            child: const Text('Cancelar'),
                          ),
                          ElevatedButton(
                            onPressed: _submitConfiguration,
                            child: const Text('Salvar'),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              listener: (context, state) {},
            ),
          ),
        ),
      ),
    );
  }
}
