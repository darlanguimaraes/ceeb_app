import 'package:ceeb_app/app/modules/book/book_module.dart';
import 'package:ceeb_app/app/modules/category/category_module.dart';
import 'package:ceeb_app/app/modules/home/home_module.dart';
import 'package:ceeb_app/app/modules/home/home_page.dart';
import 'package:ceeb_app/app/core/ui/ui_config.dart';
import 'package:ceeb_app/app/modules/invoice/invoice_module.dart';
import 'package:ceeb_app/app/modules/lending/lending_module.dart';
import 'package:ceeb_app/app/modules/note/note_module.dart';
import 'package:ceeb_app/app/modules/reader/reader_module.dart';
import 'package:ceeb_app/app/modules/synchronize/synchronize_module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: UiConfig.title,
      theme: UiConfig.theme,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        ...GlobalMaterialLocalizations.delegates,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
        Locale('en', 'US'),
      ],
      routes: {
        ...HomeModule().routers,
        ...CategoryModule().routers,
        ...BookModule().routers,
        ...ReaderModule().routers,
        ...InvoiceModule().routers,
        ...LendingModule().routers,
        ...NoteModule().routers,
        ...SynchronizeModule().routers,
      },
      home: const HomePage(),
    );
  }
}
