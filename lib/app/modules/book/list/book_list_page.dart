import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_field.dart';
import 'package:ceeb_app/app/modules/book/list/cubit/book_list_cubit.dart';
import 'package:ceeb_app/app/modules/book/list/cubit/book_list_state.dart';
import 'package:ceeb_app/app/modules/book/widgets/book_list_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({super.key});

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends BaseState<BookListPage, BookListCubit> {
  final _filterEC = TextEditingController();

  @override
  void onReady() {
    super.onReady();
    controller.list(null);
  }

  @override
  void dispose() {
    _filterEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          Constants.ROUTE_MENU,
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: CeebAppBar(
          title: 'Livros',
        ),
        body: BlocConsumer<BookListCubit, BookListState>(
          listener: (context, state) {
            state.status.matchAny(
              any: () => hideLoader(),
              loading: () => showLoader(),
              error: () {
                hideLoader();
                showError('Erro ao buscar os livros');
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
                                  .pushNamed(Constants.ROUTE_BOOK_FORM),
                              label: const Text('Novo'),
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            SizedBox(
                              height: 50,
                              width: context.percentWidth(0.6),
                              child: CeebField(
                                label: 'Filtro',
                                controller: _filterEC,
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {
                                controller.list(_filterEC.text.trim());
                              },
                              child: const Text('Filtrar'),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: state.books.length,
                      (context, index) {
                        final book = state.books[index];
                        return BookListCard(book: book);
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
