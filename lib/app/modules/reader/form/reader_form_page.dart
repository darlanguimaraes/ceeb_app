import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/modules/reader/form/cubit/reader_form_cubit.dart';
import 'package:ceeb_app/app/modules/reader/form/cubit/reader_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class ReaderFormPage extends StatefulWidget {
  const ReaderFormPage({super.key});

  @override
  State<ReaderFormPage> createState() => _ReaderFormPageState();
}

class _ReaderFormPageState extends BaseState<ReaderFormPage, ReaderFormCubit> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  bool? _openLoan;
  final _nameEC = TextEditingController();
  final _phoneEC = TextEditingController();
  final _addressEC = TextEditingController();
  final _cityEC = TextEditingController();
  final _emailEC = TextEditingController();

  @override
  void onReady() {
    super.onReady();

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      final reader = args as ReaderModel;
      _id = reader.id;
      _openLoan = reader.openLoan;
      _nameEC.text = reader.name;
      _phoneEC.text = reader.phone ?? '';
      _addressEC.text = reader.address ?? '';
      _cityEC.text = reader.city ?? '';
      _emailEC.text = reader.email ?? '';
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _phoneEC.dispose();
    _addressEC.dispose();
    _cityEC.dispose();
    _emailEC.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      final reader = ReaderModel(
        id: _id,
        name: _nameEC.text,
        phone: _phoneEC.text,
        address: _addressEC.text,
        city: _cityEC.text,
        email: _emailEC.text,
        sync: false,
        openLoan: _openLoan ?? false,
        updatedAt: DateTime.now(),
      );
      controller.save(reader);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReaderFormCubit, ReaderFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso!');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_READER_LIST, (Route<dynamic> route) => false);
          },
          error: () {
            hideLoader();
            showError('Não foi possível registrar os dados');
          },
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
              Constants.ROUTE_READER_LIST, (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: CeebAppBar(
            title: 'Cadastro de Leitor',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Name',
                    controller: _nameEC,
                    validator: Validatorless.required('Nome é obrigatório'),
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Telefone',
                    controller: _phoneEC,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'E-mail',
                    controller: _emailEC,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Endereço',
                    controller: _addressEC,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Cidade',
                    controller: _cityEC,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                Constants.ROUTE_READER_LIST,
                                (Route<dynamic> route) => false),
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: _submit,
                        child: const Text('Salvar'),
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
