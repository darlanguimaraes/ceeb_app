import 'package:ceeb_app/app/core/module/ceeb_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';

abstract class CeebModule {
  final Map<String, WidgetBuilder> _router;
  final List<SingleChildWidget>? _bindings;

  CeebModule(
      {required Map<String, WidgetBuilder> router,
      required List<SingleChildWidget>? bindings})
      : _router = router,
        _bindings = bindings;

  Map<String, WidgetBuilder> get routers {
    return _router.map(
      (key, pageBuilder) => MapEntry(
        key,
        (_) => CeebPage(
          bindings: _bindings,
          page: pageBuilder,
        ),
      ),
    );
  }

  Widget getPage(String path, BuildContext context) {
    final widgetBuilder = _router[path];
    if (widgetBuilder != null) {
      return CeebPage(
        page: widgetBuilder,
        bindings: _bindings,
      );
    }
    throw Exception();
  }
}
