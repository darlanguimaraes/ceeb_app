class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance => _instance ?? TextStyles._();
}
