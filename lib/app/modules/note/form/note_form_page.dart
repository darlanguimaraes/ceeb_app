import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/extensions/theme_extensions.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/models/node/note_model.dart';
import 'package:ceeb_app/app/modules/note/form/cubit/note_form_cubit.dart';
import 'package:ceeb_app/app/modules/note/form/cubit/note_form_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:validatorless/validatorless.dart';

class NoteFormPage extends StatefulWidget {
  const NoteFormPage({super.key});

  @override
  State<NoteFormPage> createState() => _NoteFormPageState();
}

class _NoteFormPageState extends BaseState<NoteFormPage, NoteFormCubit> {
  final _formKey = GlobalKey<FormState>();
  final _dateEC = TextEditingController();
  final _textEC = TextEditingController();
  bool _complete = false;

  int? _id;

  @override
  void onReady() {
    super.onReady();

    final args = ModalRoute.of(context)!.settings.arguments;

    if (args != null) {
      final note = args as NoteModel;
      _id = note.id;
      _dateEC.text = DateFormat('dd/MM/yyyy').format(note.date);
      _textEC.text = note.text;
      _complete = note.complete;
    } else {
      _dateEC.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
    }
  }

  void _submit() {
    final valid = _formKey.currentState?.validate() ?? false;
    if (valid) {
      final note = NoteModel(
        id: _id,
        date: DateFormat('dd/MM/yyyy').parse(_dateEC.text),
        text: _textEC.text,
        complete: _complete,
        updatedAt: DateTime.now(),
      );
      controller.save(note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NoteFormCubit, NoteFormState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          loading: () => showLoader(),
          success: () {
            hideLoader();
            showSuccess('Dados registrados com sucesso');
            Navigator.of(context).pushNamedAndRemoveUntil(
                Constants.ROUTE_NOTE_LIST, (Route<dynamic> route) => false);
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
              Constants.ROUTE_NOTE_LIST, (Route<dynamic> route) => false);
        },
        child: Scaffold(
          appBar: CeebAppBar(title: 'Anotação'),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Data',
                    controller: _dateEC,
                    enabled: false,
                  ),
                  const SizedBox(height: 20),
                  CeebField(
                    label: 'Texto',
                    controller: _textEC,
                    validator: Validatorless.required('Texto é obrigatório'),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: context.primaryColor,
                        value: _complete,
                        onChanged: (value) {
                          setState(() {
                            _complete = value!;
                          });
                        },
                      ),
                      const Text('Completo'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(Constants.ROUTE_NOTE_LIST,
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
