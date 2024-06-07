import 'package:ceeb_app/app/models/book/book_model.dart';
import 'package:ceeb_app/app/models/category/category_model.dart';
import 'package:ceeb_app/app/models/invoice/invoice_model.dart';
import 'package:ceeb_app/app/models/lending/lending_model.dart';
import 'package:ceeb_app/app/models/node/note_model.dart';
import 'package:ceeb_app/app/models/reader/reader_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  IsarHelper._();

  static final IsarHelper _instance = IsarHelper._();
  static IsarHelper get instance => _instance;

  Isar? isarInstance;

  Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    if (isarInstance != null) {
      return isarInstance!;
    }

    isarInstance = await Isar.open(
      [
        CategoryModelSchema,
        BookModelSchema,
        ReaderModelSchema,
        InvoiceModelSchema,
        LeadingModelSchema,
        NoteModelSchema,
      ],
      directory: dir.path,
    );
    return isarInstance!;
  }

  void close() {
    instance.close();
  }
}
