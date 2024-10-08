import 'package:ceeb_app/app/core/helpers/constants.dart';
import 'package:ceeb_app/app/core/ui/base_state/base_state.dart';
import 'package:ceeb_app/app/core/ui/widgets/ceeb_app_bar.dart';
import 'package:ceeb_app/app/modules/synchronize/cubit/synchronize_cubit.dart';
import 'package:flutter/material.dart';

class SynchronizePage extends StatefulWidget {
  const SynchronizePage({super.key});

  @override
  State<SynchronizePage> createState() => _SynchronizePageState();
}

class _SynchronizePageState
    extends BaseState<SynchronizePage, SynchronizeCubit> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        Navigator.of(context).pushNamedAndRemoveUntil(
          Constants.ROUTE_MENU,
          (Route<dynamic> route) => false,
        );
      },
      child: Scaffold(
        appBar: CeebAppBar(
          title: 'Sincronizar Dados',
        ),
        body: Container(),
      ),
    );
  }
}
