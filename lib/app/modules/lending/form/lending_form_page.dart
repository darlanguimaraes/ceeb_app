import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/string_utils.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:ceeb_app/app/modules/lending/form/cubit/lending_form_cubit.dart';
import 'package:ceeb_app/app/modules/lending/form/cubit/lending_form_state.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class LendingFormPage extends StatefulWidget {
  const LendingFormPage({super.key});

  @override
  State<LendingFormPage> createState() => _LendingFormPageState();
}

class _LendingFormPageState
    extends BaseState<LendingFormPage, LendingFormCubit> {
  final _formKey = GlobalKey<FormState>();
  final _dateEC = TextEditingController();
  int? _id;
  ReaderModel? _reader;
  BookModel? _book;

  @override
  void onReady() {
    super.onReady();
    controller.loadDependencies();
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      final bookBorrow = _book!.borrow ? 'Livro emprestado' : '';
      final readerOpen =
          _reader!.openLoan ? 'Leitor já  possui um empréstimo ativo' : '';
      final message = bookBorrow + readerOpen;
      if (message.isNotEmpty) {
        showError(message);
      } else {
        final date = DateFormat('dd/MM/yyyy').parse(_dateEC.text);

        final lending = LendingModel(
          id: _id,
          bookId: _book!.id!,
          readerId: _reader!.id!,
          date: date,
          expectedDate: date.add(const Duration(days: 30)),
          returned: false,
          sync: false,
        );

        controller.save(lending);
      }
    }
  }

  bool _filterBooks(BookModel book, String text) {
    final filter = StringUtils.removeDiacritics(text.toLowerCase());
    final name = StringUtils.removeDiacritics(book.name.toLowerCase());
    final author = book.author.isNotEmpty
        ? StringUtils.removeDiacritics(book.author.toLowerCase())
        : '';
    final code = book.code.toLowerCase();
    return name.contains(filter) ||
        author.contains(filter) ||
        code.contains(filter);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LendingFormCubit, LendingFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_LENDING_LIST, (Route<dynamic> route) => false);
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
              Constants.ROUTE_LENDING_LIST, (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: CeebAppBar(
            title: 'Empréstimos',
          ),
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
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          _dateEC.text =
                              DateFormat('dd/MM/yyyy').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LendingFormCubit, LendingFormState>(
                      builder: (context, state) {
                        return DropdownSearch<ReaderModel>(
                          popupProps: PopupProps.menu(
                            searchFieldProps: const TextFieldProps(),
                            showSearchBox: true,
                            itemBuilder: (context, item, isSelected) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    item.openLoan
                                        ? const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          )
                                        : const Icon(
                                            Icons.check,
                                            color: Colors.green,
                                          ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(child: Text(item.name)),
                                  ],
                                ),
                              );
                            },
                          ),
                          filterFn: (item, filter) =>
                              StringUtils.removeDiacritics(
                                      item.name.toLowerCase())
                                  .contains(StringUtils.removeDiacritics(
                                      filter.toLowerCase())),
                          items: controller.state.readers,
                          itemAsString: (ReaderModel u) => u.name,
                          onChanged: (ReaderModel? data) => setState(() {
                            _reader = data;
                          }),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Leitor",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Leitor é obrigatório';
                            }
                            if (value.openLoan) {
                              return 'O leitor selecionado já possui um empréstimo ativo';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<LendingFormCubit, LendingFormState>(
                      builder: (context, state) {
                        return DropdownSearch<BookModel>(
                          popupProps: PopupProps.menu(
                            searchFieldProps: const TextFieldProps(),
                            showSearchBox: true,
                            itemBuilder: (context, book, isSelected) {
                              return ListTile(
                                leading: book.borrow
                                    ? const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      )
                                    : const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                title: Text(book.name),
                                subtitle: Text('${book.author} - ${book.code}'),
                              );
                            },
                          ),
                          filterFn: _filterBooks,
                          items: controller.state.books,
                          itemAsString: (BookModel u) =>
                              '${u.name} - ${u.author} - ${u.code}',
                          onChanged: (BookModel? data) => setState(() {
                            _book = data;
                          }),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              labelText: "Livro",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Livro é obrigatório';
                            }
                            return null;
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
                                  Constants.ROUTE_LENDING_LIST,
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
