// import 'dart:async';

// import 'package:ceeb_app/app/core/database/sqlite_connection_factory.dart';
// import 'package:ceeb_app/app/core/exceptions/repository_exception.dart';
// import 'package:ceeb_app/app/core/helpers/constants.dart';
// import 'package:ceeb_app/app/core/helpers/tables_sql.dart';
// import 'package:ceeb_app/app/models/category/category_model.dart';
// import 'package:ceeb_app/app/repositories/category/category_repository.dart';
// import 'package:ceeb_app/app/repositories/category/category_repository_impl.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:sqflite_common_ffi/sqflite_ffi.dart';

// class SqliteConnectionMock extends Mock implements SqliteConnectionFactory {}

// Future<Database> openConnectionDataBase() async {
//   var databaseFactory = databaseFactoryFfi;
//   var db = await databaseFactory.openDatabase(inMemoryDatabasePath);
//   return db;
// }

// Future<void> createTestDatabase(Database db) async {
//   await db.execute(TablesSql.CATEGORY);
// }

// void main() {
//   sqfliteFfiInit();

//   late SqliteConnectionFactory sqliteConnectionFactory;
//   late CategoryRepository categoryRepository;

//   setUp(
//     () {
//       sqliteConnectionFactory = SqliteConnectionMock();
//       categoryRepository = CategoryRepositoryImpl(
//           sqliteConnectionFactory: sqliteConnectionFactory);
//     },
//   );

//   setUpAll(
//     () async {
//       var db = await openConnectionDataBase();
//       await createTestDatabase(db);
//     },
//   );

//   tearDown(
//     () async {
//       var conn = await sqliteConnectionFactory.openConnection();
//       await conn.rawDelete(
//           'delete from ${Constants.TABLE_CATEGORY} where id > ?', [0]);
//     },
//   );

//   group(
//     'Category Repository test',
//     () {
//       group(
//         'Save Category',
//         () {
//           test(
//             'Should category be save',
//             () async {
//               when(
//                 () => sqliteConnectionFactory.openConnection(),
//               ).thenAnswer((_) => openConnectionDataBase());

//               final category = CategoryModel(
//                 name: 'Category',
//                 price: 2.00,
//                 sync: false,
//                 fixedQuantity: true,
//                 fixedPrice: false,
//               );
//               final categorySaved = await categoryRepository.save(category);

//               expect(categorySaved, isA<CategoryModel>());
//               expect(categorySaved.id, isNotNull);
//               expect(categorySaved.name, 'Category');
//               expect(categorySaved.nameDiacritics, 'category');
//               expect(categorySaved.price, 2.00);
//             },
//           );
//           test('Should not save when category name is already in the database',
//               () async {
//             when(
//               () => sqliteConnectionFactory.openConnection(),
//             ).thenAnswer((_) => openConnectionDataBase());

//             final category = CategoryModel(
//               name: 'Category',
//               price: 2.00,
//               sync: false,
//               fixedQuantity: true,
//               fixedPrice: false,
//             );
//             await categoryRepository.save(category);

//             expect(() async => await categoryRepository.save(category),
//                 throwsA(isA<RepositoryException>()));
//           });
//         },
//       );

//       group(
//         'Update Category',
//         () {
//           test('Should update a category', () async {
//             when(
//               () => sqliteConnectionFactory.openConnection(),
//             ).thenAnswer((_) => openConnectionDataBase());

//             final category = CategoryModel(
//               name: 'Category',
//               price: 2.00,
//               sync: false,
//               fixedQuantity: true,
//               fixedPrice: false,
//             );
//             final categorySaved = await categoryRepository.save(category);

//             categorySaved.name = 'New name';
//             categorySaved.price = 1;
//             categorySaved.fixedQuantity = false;
//             categorySaved.fixedPrice = false;

//             final categoryUpdated =
//                 await categoryRepository.update(categorySaved);

//             expect(categoryUpdated, isA<CategoryModel>());
//             expect(categoryUpdated.id, categorySaved.id);
//             expect(categoryUpdated.name, 'New name');
//             expect(categoryUpdated.price, 1);
//             expect(categoryUpdated.fixedQuantity, false);
//             expect(categoryUpdated.fixedQuantity, false);
//           });

//           test(
//               'Should not update a category when the name is already in the database',
//               () async {
//             when(
//               () => sqliteConnectionFactory.openConnection(),
//             ).thenAnswer((_) => openConnectionDataBase());

//             final category = CategoryModel(
//               name: 'Category save',
//               price: 2.00,
//               sync: false,
//               fixedQuantity: true,
//               fixedPrice: false,
//             );
//             await categoryRepository.save(category);

//             final category2 = CategoryModel(
//               name: 'Name',
//               price: 2.00,
//               sync: false,
//               fixedQuantity: true,
//               fixedPrice: false,
//             );
//             final categoryToUpdate = await categoryRepository.save(category2);
//             categoryToUpdate.name = 'Category save';

//             expect(
//                 () async => await categoryRepository.update(categoryToUpdate),
//                 throwsA(isA<RepositoryException>()));
//           });
//         },
//       );
//     },
//   );
// }
