import 'package:ceeb_app/app/core/helpers/constants.dart';

class TablesSql {
  TablesSql._();

  static const CATEGORY = '''
    CREATE TABLE ${Constants.TABLE_CATEGORY} (
      id INTEGER primary key autoincrement,
      name text NOT NULL,
      name_diacritics text not null,
      price real,
      sync INTEGER,
      quantity INTEGER,
      price_fixed INTEGER,
      remote_id text,
      fixed_price INTEGER,
      fixed_quantity INTEGER
    );
    ''';

  static const BOOK = '''
    CREATE TABLE ${Constants.TABLE_BOOK} (
      id INTEGER primary key autoincrement,
      name text NOT NULL,
      name_diacritics text not null,
      author text,
      writer text,
      code text NOT NULL,
      borrow INTEGER,
      sync INTEGER,
      remote_id text
    );
    ''';

  static const NOTES = '''
    CREATE TABLE ${Constants.TABLE_NOTES} (
      id INTEGER primary key autoincrement,
      date integer,
      description text,
      complete INTEGER,
      created_at INTEGER NOT NULL,
      updated_at INTEGER NOT NULL
    );
    ''';

  static const READER = '''
    CREATE TABLE ${Constants.TABLE_READER} (
      id INTEGER primary key autoincrement,
      name text NOT NULL,
      name_diacritics text not null,
      phone text NOT NULL,
      address text,
      city text,
      email text,
      sync INTEGER,
      open_loan INTEGER,
      remote_id text
    );
    ''';

  static const INVOICE = '''
    CREATE TABLE ${Constants.TABLE_INVOICE} (
      id INTEGER primary key autoincrement,
      date INTEGER not null,
      quantity INTEGER NOT NULL,
      price real NOT NULL,
      value real NOT NULL,
      credit INTEGER,
      payment_type text,
      sync INTEGER,
      remote_id text,
      category_id INTEGER,
      FOREIGN KEY(category_id) REFERENCES ${Constants.TABLE_CATEGORY} (id)
    );
    ''';

  static const LENDING = '''
    CREATE TABLE ${Constants.TABLE_LENDING} (
      id INTEGER primary key autoincrement,
      book_id INTEGER NOT NULL,
      reader_id INTEGER NOT NULL,
      date INTEGER NOT NULL,
      expected_date INTEGER NOT NULL,
      delivery_date INTEGER,
      returned INTEGER,
      sync INTEGER,
      remote_id text,
      FOREIGN KEY(book_id) REFERENCES ${Constants.TABLE_BOOK} (id),
      FOREIGN KEY(reader_id) REFERENCES ${Constants.TABLE_READER} (id)
    );
    ''';

  static const CONFIGURATION = '''
    CREATE TABLE ${Constants.TABLE_CONFIGURATION} (
      id INTEGER primary key autoincrement,
      sync_date int not null,
      url text
    );
    ''';

  static const INSERT_DEFAULT_CONFIGURATION = '''
    insert into ${Constants.TABLE_CONFIGURATION} (sync_date, url) values (946692000000, 'https://ceeuripedesbarsanulpho.org.br/');
    ''';
}
