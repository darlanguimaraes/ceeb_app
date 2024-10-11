import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/modules/category/list/cubit/category_list_cubit.dart';
import 'package:ceeb_app/app/modules/category/list/cubit/category_list_state.dart';
import 'package:ceeb_app/app/modules/category/widgets/category_list_card.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/modules/category/widgets/modal_admin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryListPage extends StatefulWidget {
  const CategoryListPage({super.key});

  @override
  State<CategoryListPage> createState() => _CategoryListPageState();
}

class _CategoryListPageState
    extends BaseState<CategoryListPage, CategoryListCubit> {
  final _keyModal = GlobalKey();

  @override
  void onReady() {
    super.onReady();
    controller.list();
  }

  Future<void> _showRestrictedModal() async {
    final authorized = await showDialog(
      context: context,
      builder: (context) {
        return Material(
          color: Colors.black26,
          child: Dialog(
            key: _keyModal,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.white,
            elevation: 10,
            child: const ModalAdmin(),
          ),
        );
      },
    );

    if (authorized) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushNamed(Constants.ROUTE_CATEGORY_FORM);
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
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
          title: 'Categorias',
        ),
        body: BlocConsumer<CategoryListCubit, CategoryListState>(
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
                          onPressed: _showRestrictedModal,
                          label: const Text('Novo'),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.categories.length,
                      (context, index) {
                        final category = state.categories[index];
                        return CategoryListCard(
                          category: category,
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
