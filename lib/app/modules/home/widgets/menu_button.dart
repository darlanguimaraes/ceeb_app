import 'package:ceeb_app/app/core/ui/extensions/size_extensions.dart';
import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String _title;
  final String _route;
  final IconData _iconData;

  const MenuButton({
    super.key,
    required String title,
    required String route,
    required IconData iconData,
  })  : _title = title,
        _route = route,
        _iconData = iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushReplacementNamed(_route),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: context.percentWidth(.45),
        height: 200,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _iconData,
              color: Colors.white,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              _title,
              softWrap: true,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
