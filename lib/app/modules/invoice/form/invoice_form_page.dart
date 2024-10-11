import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_formatter.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/modules/invoice/form/cubit/invoice_form_cubit.dart';
import 'package:ceeb_app/app/modules/invoice/form/cubit/invoice_form_state.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class InvoiceFormPage extends StatefulWidget {
  const InvoiceFormPage({super.key});

  @override
  State<InvoiceFormPage> createState() => _InvoiceFormPageState();
}

class _InvoiceFormPageState
    extends BaseState<InvoiceFormPage, InvoiceFormCubit> {
  final _formKey = GlobalKey<FormState>();
  int? _id;
  final _dateEC = TextEditingController();
  final _quantityEC = TextEditingController();
  final _totalEC = TextEditingController();

  final categoryValid = ValueNotifier<bool>(true);
  String? _categorySelected;
  String? _paymentType;

  final _formatterPrice = CurrencyTextInputFormatter.currency(
    locale: 'pt_BR',
    symbol: 'R\$',
    decimalDigits: 2,
    turnOffGrouping: true,
  );

  @override
  Future<void> onReady() async {
    super.onReady();
    await controller.loadDependencies();
    // ignore: use_build_context_synchronously
    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      final invoice = args as InvoiceModel;
      _categorySelected = invoice.categoryId.toString();
      controller.changeCategory(invoice.categoryId);

      _id = invoice.id;
      _dateEC.text = DateFormat('dd/MM/yyyy').format(invoice.date);
      _quantityEC.text = invoice.quantity.toString();
      _totalEC.text = TextFormatter.formatReal(invoice.value);
      _paymentType = invoice.paymentType;

      controller.setUpdateData(invoice);
    }
    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
    _dateEC.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      final category = controller.state.category;
      final quantity = category!.fixedQuantity ? 1 : controller.state.quantity;
      final value = TextFormatter.unformatReal(_totalEC.text);

      final invoice = InvoiceModel(
        id: _id,
        date: DateFormat('dd/MM/yyyy').parse(_dateEC.text),
        quantity: quantity,
        value: value,
        price: category.fixedQuantity ? value : category.price!,
        credit: true,
        paymentType: _paymentType!,
        sync: false,
        categoryId: category.id!,
      );

      controller.save(invoice);
    }
  }

  FormFieldValidator _validateTotalValue(String message) {
    return (v) {
      if (v.isNotEmpty) {
        final value = TextFormatter.unformatReal(v);
        if (value <= 0) return message;
        return null;
      }
      return message;
    };
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceFormCubit, InvoiceFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_INVOICE_LIST, (Route<dynamic> route) => false);
          },
          error: () {
            hideLoader();
            showError('Não foi possível registrar os dados');
          },
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          Navigator.of(context).pushNamedAndRemoveUntil(
              Constants.ROUTE_INVOICE_LIST, (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: CeebAppBar(title: 'Cadastro de conta'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _dateEC,
                      validator: Validatorless.required('Data é obrigatório'),
                      decoration: InputDecoration(
                        labelText: 'Data',
                        icon: const Icon(Icons.calendar_today),
                        labelStyle:
                            const TextStyle(fontSize: 15, color: Colors.black),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.red),
                        ),
                      ),
                      readOnly: true,
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(2020),
                          lastDate: DateTime.now(),
                        );
                        if (pickedDate != null) {
                          _dateEC.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<InvoiceFormCubit, InvoiceFormState>(
                      builder: (context, state) {
                        return DropdownButtonFormField<String?>(
                          validator:
                              Validatorless.required('Categoria é obrigatório'),
                          decoration: InputDecoration(
                            labelText: 'Categoria',
                            labelStyle: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          value: _categorySelected,
                          items: controller.state.categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e.id!.toString(),
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            _categorySelected = value;
                            controller.changeCategory(int.parse(value!));
                          },
                        );
                      },
                    ),
                    BlocConsumer<InvoiceFormCubit, InvoiceFormState>(
                      listener: (context, state) {
                        _quantityEC.text = state.quantity.toString();
                      },
                      builder: (context, state) {
                        if (!state.showQuantity) return const SizedBox.shrink();
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            CeebField(
                              label: 'Quantidade',
                              controller: _quantityEC,
                              keyboardType: TextInputType.number,
                              validator: Validatorless.required(
                                  'Quantidade é obrigatório'),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  controller.changeQuantity(int.parse(value));
                                } else {
                                  controller.changeQuantity(0);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocConsumer<InvoiceFormCubit, InvoiceFormState>(
                      listener: (context, state) {
                        _totalEC.text = TextFormatter.formatReal(state.total);
                      },
                      builder: (context, state) {
                        return CeebField(
                          label: 'Total',
                          enabled: controller.state.disableTotal,
                          controller: _totalEC,
                          keyboardType: TextInputType.number,
                          inputFormatters: [_formatterPrice],
                          validator: _validateTotalValue('Valor é obrigatório'),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<InvoiceFormCubit, InvoiceFormState>(
                      builder: (context, state) {
                        return DropdownButtonFormField<String?>(
                          validator: Validatorless.required(
                              'Forma de Pagamento é obrigatório'),
                          decoration: InputDecoration(
                            labelText: 'Forma de Pagamento',
                            labelStyle: const TextStyle(
                                fontSize: 15, color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(color: Colors.red),
                            ),
                          ),
                          value: _paymentType,
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text('Selecione'),
                            ),
                            DropdownMenuItem(
                              value: 'Dinheiro',
                              child: Text('Dinheiro'),
                            ),
                            DropdownMenuItem(
                              value: 'PIX',
                              child: Text('PIX'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _paymentType = value;
                            });
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  Constants.ROUTE_INVOICE_LIST,
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
      ),
    );
  }
}
