import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_formatter.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/modules/category/form/cubit/category_form_cubit.dart';
import 'package:ceeb_app/app/modules/category/form/cubit/category_form_state.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class CategoryFormPage extends StatefulWidget {
  const CategoryFormPage({super.key});

  @override
  State<CategoryFormPage> createState() => _CategoryFormPageState();
}

class _CategoryFormPageState
    extends BaseState<CategoryFormPage, CategoryFormCubit> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _priceEC = TextEditingController();
  final _formatterPrice = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
    turnOffGrouping: true,
  );
  int? _id;

  @override
  void onReady() {
    super.onReady();

    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      final category = args as CategoryModel;
      _id = category.id;
      _nameEC.text = category.name;
      _priceEC.text = TextFormatter.formatReal(category.price);
      _formatterPrice.formatEditUpdate(
          TextEditingValue.empty, TextEditingValue(text: _priceEC.text));
    }
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _priceEC.dispose();
    super.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      controller.save(
        _id,
        _nameEC.text.trim(),
        _formatterPrice.getUnformattedValue().toDouble(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CategoryFormCubit, CategoryFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_CATEGORY_LIST, (Route<dynamic> route) => false);
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
              Constants.ROUTE_CATEGORY_LIST, (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: CeebAppBar(
            title: 'Cadastro de Categoria',
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Nome',
                    controller: _nameEC,
                    validator: Validatorless.required('Nome é obrigatório'),
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Preço',
                    controller: _priceEC,
                    validator: Validatorless.required('Preço é obrigatório'),
                    inputFormatters: [_formatterPrice],
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                Constants.ROUTE_CATEGORY_LIST,
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
