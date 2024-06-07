import 'package:flutter/material.dart';
import 'package:provider/single_child_widget.dart';
import 'package:provider/provider.dart';

class CeebPage extends StatelessWidget {
  final List<SingleChildWidget>? _bindings;
  final WidgetBuilder _page;

  const CeebPage(
      {super.key,
      required WidgetBuilder page,
      List<SingleChildWidget>? bindings})
      : _bindings = bindings,
        _page = page;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: _bindings ?? [Provider(create: (_) => Object())],
      child: Builder(
        builder: (context) => _page(context),
      ),
    );
  }
}
