import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/modules/reader/list/cubit/reader_list_cubit.dart';
import 'package:ceeb_app/app/modules/reader/list/cubit/reader_list_state.dart';
import 'package:ceeb_app/app/modules/reader/widgets/reader_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReaderListPage extends StatefulWidget {
  const ReaderListPage({super.key});

  @override
  State<ReaderListPage> createState() => _ReaderListPageState();
}

class _ReaderListPageState extends BaseState<ReaderListPage, ReaderListCubit> {
  @override
  void onReady() {
    super.onReady();
    controller.list(null);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          Constants.ROUTE_MENU,
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: CeebAppBar(
          title: 'Leitores',
        ),
        body: BlocConsumer<ReaderListCubit, ReaderListState>(
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
                    expandedHeight: 70,
                    backgroundColor: Colors.white,
                    title: Row(
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
                              .pushNamed(Constants.ROUTE_READER_FORM),
                          label: const Text('Novo'),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.readers.length,
                      (context, index) {
                        final reader = state.readers[index];
                        return ReaderListCard(reader: reader);
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