import 'package:ceeb_app/app/app_widget.dart';
import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppModule extends StatelessWidget {
  const AppModule({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => SqliteConnectionFactory(),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
