import 'package:ceeb_app/app/app_widget.dart';
import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
import 'package:ceeb_app/app/core/logger/logger_app_logger_impl.dart';
import 'package:ceeb_app/app/core/rest_client/dio/dio_rest_client.dart';
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
        Provider(
          create: (context) => LoggerAppLoggerImpl(),
          lazy: false,
        ),
        Provider(
          create: (context) => DioRestClient(log: LoggerAppLoggerImpl()),
          lazy: false,
        ),
      ],
      child: const AppWidget(),
    );
  }
}
