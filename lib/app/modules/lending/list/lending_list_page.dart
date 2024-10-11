// ignore_for_file: use_build_context_synchronously

import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/helpers/text_styles.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/modules/lending/list/cubit/lending_list_cubit.dart';
import 'package:ceeb_app/app/modules/lending/list/cubit/lending_list_state.dart';
import 'package:ceeb_app/app/modules/lending/widgets/lending_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LendingListPage extends StatefulWidget {
  const LendingListPage({super.key});

  @override
  State<LendingListPage> createState() => _LendingListPageState();
}

class _LendingListPageState
    extends BaseState<LendingListPage, LendingListCubit> {
  final _filterEC = TextEditingController();
  bool _open = true;
  final _keyModal = GlobalKey();

  @override
  void onReady() {
    super.onReady();
    controller.list(null, false);
  }

  @override
  void dispose() {
    _filterEC.dispose();
    super.dispose();
  }

  Future<void> _renewLending(int id) async {
    final executed = await controller.renewLending(id);
    if (executed) {
      showSuccess('Livro renovado com sucesso!');
      await controller.list(_filterEC.text, !_open);
      if (_keyModal.currentContext != null) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } else {
      showError('Erro ao renovar o livro');
    }
  }

  Future<void> _returnLending(int id) async {
    final executed = await controller.returnLending(id);
    if (executed) {
      showSuccess('Livro devolvido com sucesso!');
      await controller.list(_filterEC.text, !_open);
      if (_keyModal.currentContext != null) {
        Navigator.of(context, rootNavigator: true).pop();
      }
    } else {
      showError('Erro ao devolver o livro');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        if (_keyModal.currentContext != null) {
          Navigator.of(context, rootNavigator: true).pop();
        }
        Navigator.of(context).pushNamedAndRemoveUntil(
          Constants.ROUTE_MENU,
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: CeebAppBar(
          title: 'Empréstimos e Devoluções',
        ),
        body: BlocConsumer<LendingListCubit, LendingListState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
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
                                  .pushNamed(Constants.ROUTE_LENDING_FORM),
                              label: const Text('Novo'),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: context.percentWidth(0.55),
                              child: CeebField(
                                label: 'Filtro',
                                controller: _filterEC,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              children: [
                                Text(
                                  'Em aberto',
                                  style: context.textStyles.textMedium
                                      .copyWith(fontSize: 14),
                                ),
                                Switch(
                                  value: _open,
                                  activeColor: Colors.blue,
                                  onChanged: (value) {
                                    setState(() {
                                      _open = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              onPressed: () {
                                controller.list(_filterEC.text, !_open);
                              },
                              icon: const Icon(
                                Icons.filter_alt,
                                size: 32,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.lendings.length,
                      (context, index) {
                        final lending = state.lendings[index];
                        return LendingListCard(
                          lending: lending,
                          renewLending: _renewLending,
                          returnLending: _returnLending,
                          keyModal: _keyModal,
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
