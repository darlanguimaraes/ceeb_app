import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/modules/book/form/cubit/book_form_cubit.dart';
import 'package:ceeb_app/app/modules/book/form/cubit/book_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:validatorless/validatorless.dart';

class BookFormPage extends StatefulWidget {
  const BookFormPage({super.key});

  @override
  State<BookFormPage> createState() => _BookFormPageState();
}

class _BookFormPageState extends BaseState<BookFormPage, BookFormCubit> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _authorEC = TextEditingController();
  final _writerEC = TextEditingController();
  final _codeEC = TextEditingController();

  int? _id;
  bool _borrow = false;

  @override
  void onReady() {
    super.onReady();

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null) {
      final book = args as BookModel;
      _id = book.id;
      _nameEC.text = book.name;
      _authorEC.text = book.author;
      _writerEC.text = book.writer ?? '';
      _codeEC.text = book.code;
      _borrow = book.borrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameEC.dispose();
    _authorEC.dispose();
    _codeEC.dispose();
    _writerEC.dispose();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      final book = BookModel(
        id: _id,
        name: _nameEC.text,
        author: _authorEC.text,
        code: _codeEC.text,
        borrow: _borrow,
        sync: false,
      );
      controller.save(book);
    }
  }

  @override
  Widget build(BuildContext context) {
    final codeMask = MaskTextInputFormatter(
      mask: '#AA## - AA.##',
    );

    return BlocListener<BookFormCubit, BookFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso!');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_BOOK_LIST, (Route<dynamic> route) => false);
          },
          error: () {
            hideLoader();
            showError('Não foi possível registrar os dados');
          },
        );
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) return;
          Navigator.pop(context);
        },
        child: Scaffold(
          appBar: CeebAppBar(
            title: 'Cadastro de Livro',
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
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
                    const SizedBox(height: 15),
                    CeebField(
                      label: 'Autor',
                      controller: _authorEC,
                      validator: Validatorless.required('Autor é obrigatório'),
                    ),
                    const SizedBox(height: 15),
                    CeebField(
                      label: 'Escritor',
                      controller: _writerEC,
                    ),
                    const SizedBox(height: 15),
                    CeebField(
                      label: 'Código',
                      controller: _codeEC,
                      validator: Validatorless.required('Código é obrigatório'),
                      inputFormatters: [codeMask],
                      capitalize: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamedAndRemoveUntil(
                                  Constants.ROUTE_BOOK_LIST,
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
