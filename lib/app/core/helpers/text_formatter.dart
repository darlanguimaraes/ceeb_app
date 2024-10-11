import 'package:intl/intl.dart';

class TextFormatter {
  TextFormatter._();

  static final _formatRealPattern =
      NumberFormat.currency(locale: 'pt_BR', symbol: r'R$');

  static String formatReal(double value) => _formatRealPattern.format(value);

  static double unformatReal(String text) {
    final value =
        text.replaceAll('R\$', '').replaceAll('.', '').replaceAll(',', '.');
    return double.parse(value);
  }
}
