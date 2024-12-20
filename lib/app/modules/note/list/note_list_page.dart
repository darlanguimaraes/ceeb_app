import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/modules/note/list/cubit/note_list_cubit.dart';
import 'package:ceeb_app/app/modules/note/list/cubit/note_list_state.dart';
import 'package:ceeb_app/app/modules/note/widgets/note_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends BaseState<NoteListPage, NoteListCubit> {
  bool _open = true;

  @override
  void onReady() {
    super.onReady();
    controller.list(false);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
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
          title: 'Anotações',
        ),
        body: BlocConsumer<NoteListCubit, NoteListState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              updated: () {
                hideLoader();
                showSuccess('Anotação atualizada com sucesso');
              },
              error: () {
                hideLoader();
                showError('Erro ao buscar os dados');
              },
            );
          },
          buildWhen: (previous, current) => current.status.matchAny(
            any: () => false,
            initial: () => true,
            loaded: () => true,
          ),
          builder: (context, state) {
            return Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 120,
                    toolbarHeight: 120,
                    backgroundColor: Colors.white,
                    title: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton.icon(
                              label: const Text('Voltar'),
                              onPressed: () =>
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                Constants.ROUTE_MENU,
                                (Route<dynamic> route) => false,
                              ),
                              icon: const Icon(
                                Icons.home,
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed(Constants.ROUTE_NOTE_FORM),
                              label: const Text('Novo'),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Em aberto',
                                  style: context.textStyles.textMedium
                                      .copyWith(fontSize: 14),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Switch(
                                  value: _open,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      _open = value;
                                      controller.list(!value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.notes.length,
                      (context, index) {
                        final note = state.notes[index];
                        return NoteListCard(
                          note: note,
                          controller: controller,
                          status: _open,
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
