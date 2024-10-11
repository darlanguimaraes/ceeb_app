import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/modules/home/widgets/menu_button.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CeebAppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuButton(
                    title: 'Empréstimos de Livros',
                    route: Constants.ROUTE_LENDING_LIST,
                    iconData: Icons.library_books,
                  ),
                  SizedBox(width: 10),
                  MenuButton(
                    title: 'Contas',
                    route: Constants.ROUTE_INVOICE_LIST,
                    iconData: Icons.monetization_on_outlined,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuButton(
                    title: 'Livros',
                    route: Constants.ROUTE_BOOK_LIST,
                    iconData: Icons.menu_book,
                  ),
                  SizedBox(width: 10),
                  MenuButton(
                    title: 'Leitores',
                    route: Constants.ROUTE_READER_LIST,
                    iconData: Icons.person,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MenuButton(
                    title: 'Categorias',
                    route: Constants.ROUTE_CATEGORY_LIST,
                    iconData: Icons.grid_view,
                  ),
                  SizedBox(width: 10),
                  MenuButton(
                    title: 'Anotações',
                    route: Constants.ROUTE_NOTE_LIST,
                    iconData: Icons.note,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MenuButton(
                    title: 'Sincronizar',
                    route: Constants.ROUTE_SYNC,
                    iconData: Icons.sync,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
