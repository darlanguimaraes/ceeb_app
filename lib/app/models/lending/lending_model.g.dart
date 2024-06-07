// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lending_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLeadingModelCollection on Isar {
  IsarCollection<LeadingModel> get leadingModels => this.collection();
}

const LeadingModelSchema = CollectionSchema(
  name: r'LeadingModel',
  id: -6626254488779893529,
  properties: {
    r'book': PropertySchema(
      id: 0,
      name: r'book',
      type: IsarType.object,
      target: r'BookEmbedded',
    ),
    r'date': PropertySchema(
      id: 1,
      name: r'date',
      type: IsarType.dateTime,
    ),
    r'deliveryDate': PropertySchema(
      id: 2,
      name: r'deliveryDate',
      type: IsarType.dateTime,
    ),
    r'expectedDate': PropertySchema(
      id: 3,
      name: r'expectedDate',
      type: IsarType.dateTime,
    ),
    r'reader': PropertySchema(
      id: 4,
      name: r'reader',
      type: IsarType.object,
      target: r'ReaderEmbedded',
    ),
    r'remoteId': PropertySchema(
      id: 5,
      name: r'remoteId',
      type: IsarType.string,
    ),
    r'returned': PropertySchema(
      id: 6,
      name: r'returned',
      type: IsarType.bool,
    ),
    r'sync': PropertySchema(
      id: 7,
      name: r'sync',
      type: IsarType.bool,
    ),
    r'updatedAt': PropertySchema(
      id: 8,
      name: r'updatedAt',
      type: IsarType.dateTime,
    )
  },
  estimateSize: _leadingModelEstimateSize,
  serialize: _leadingModelSerialize,
  deserialize: _leadingModelDeserialize,
  deserializeProp: _leadingModelDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'BookEmbedded': BookEmbeddedSchema,
    r'ReaderEmbedded': ReaderEmbeddedSchema
  },
  getId: _leadingModelGetId,
  getLinks: _leadingModelGetLinks,
  attach: _leadingModelAttach,
  version: '3.1.0+1',
);

int _leadingModelEstimateSize(
  LeadingModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      BookEmbeddedSchema.estimateSize(
          object.book, allOffsets[BookEmbedded]!, allOffsets);
  bytesCount += 3 +
      ReaderEmbeddedSchema.estimateSize(
          object.reader, allOffsets[ReaderEmbedded]!, allOffsets);
  {
    final value = object.remoteId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _leadingModelSerialize(
  LeadingModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<BookEmbedded>(
    offsets[0],
    allOffsets,
    BookEmbeddedSchema.serialize,
    object.book,
  );
  writer.writeDateTime(offsets[1], object.date);
  writer.writeDateTime(offsets[2], object.deliveryDate);
  writer.writeDateTime(offsets[3], object.expectedDate);
  writer.writeObject<ReaderEmbedded>(
    offsets[4],
    allOffsets,
    ReaderEmbeddedSchema.serialize,
    object.reader,
  );
  writer.writeString(offsets[5], object.remoteId);
  writer.writeBool(offsets[6], object.returned);
  writer.writeBool(offsets[7], object.sync);
  writer.writeDateTime(offsets[8], object.updatedAt);
}

LeadingModel _leadingModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LeadingModel(
    book: reader.readObjectOrNull<BookEmbedded>(
          offsets[0],
          BookEmbeddedSchema.deserialize,
          allOffsets,
        ) ??
        BookEmbedded(),
    date: reader.readDateTime(offsets[1]),
    deliveryDate: reader.readDateTimeOrNull(offsets[2]),
    expectedDate: reader.readDateTime(offsets[3]),
    id: id,
    reader: reader.readObjectOrNull<ReaderEmbedded>(
          offsets[4],
          ReaderEmbeddedSchema.deserialize,
          allOffsets,
        ) ??
        ReaderEmbedded(),
    remoteId: reader.readStringOrNull(offsets[5]),
    returned: reader.readBool(offsets[6]),
    sync: reader.readBool(offsets[7]),
    updatedAt: reader.readDateTime(offsets[8]),
  );
  return object;
}

P _leadingModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<BookEmbedded>(
            offset,
            BookEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          BookEmbedded()) as P;
    case 1:
      return (reader.readDateTime(offset)) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readDateTime(offset)) as P;
    case 4:
      return (reader.readObjectOrNull<ReaderEmbedded>(
            offset,
            ReaderEmbeddedSchema.deserialize,
            allOffsets,
          ) ??
          ReaderEmbedded()) as P;
    case 5:
      return (reader.readStringOrNull(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readBool(offset)) as P;
    case 8:
      return (reader.readDateTime(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _leadingModelGetId(LeadingModel object) {
  return object.id ?? Isar.autoIncrement;
}

List<IsarLinkBase<dynamic>> _leadingModelGetLinks(LeadingModel object) {
  return [];
}

void _leadingModelAttach(
    IsarCollection<dynamic> col, Id id, LeadingModel object) {
  object.id = id;
}

extension LeadingModelQueryWhereSort
    on QueryBuilder<LeadingModel, LeadingModel, QWhere> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LeadingModelQueryWhere
    on QueryBuilder<LeadingModel, LeadingModel, QWhereClause> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LeadingModelQueryFilter
    on QueryBuilder<LeadingModel, LeadingModel, QFilterCondition> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> dateEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      dateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> dateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'date',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> dateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'date',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'deliveryDate',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'deliveryDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      deliveryDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'deliveryDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      expectedDateEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'expectedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      expectedDateGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'expectedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      expectedDateLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'expectedDate',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      expectedDateBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'expectedDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> idEqualTo(
      Id? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> idGreaterThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> idLessThan(
    Id? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> idBetween(
    Id? lower,
    Id? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'remoteId',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'remoteId',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'remoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'remoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'remoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      remoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'remoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      returnedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'returned',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> syncEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sync',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      updatedAtEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      updatedAtLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition>
      updatedAtBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension LeadingModelQueryObject
    on QueryBuilder<LeadingModel, LeadingModel, QFilterCondition> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> book(
      FilterQuery<BookEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'book');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterFilterCondition> reader(
      FilterQuery<ReaderEmbedded> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'reader');
    });
  }
}

extension LeadingModelQueryLinks
    on QueryBuilder<LeadingModel, LeadingModel, QFilterCondition> {}

extension LeadingModelQuerySortBy
    on QueryBuilder<LeadingModel, LeadingModel, QSortBy> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy>
      sortByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByExpectedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDate', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy>
      sortByExpectedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDate', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByReturned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returned', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByReturnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returned', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortBySync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortBySyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension LeadingModelQuerySortThenBy
    on QueryBuilder<LeadingModel, LeadingModel, QSortThenBy> {
  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'date', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy>
      thenByDeliveryDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'deliveryDate', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByExpectedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDate', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy>
      thenByExpectedDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'expectedDate', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByRemoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByRemoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'remoteId', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByReturned() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returned', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByReturnedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'returned', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenBySync() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenBySyncDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sync', Sort.desc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }
}

extension LeadingModelQueryWhereDistinct
    on QueryBuilder<LeadingModel, LeadingModel, QDistinct> {
  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'date');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByDeliveryDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'deliveryDate');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByExpectedDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'expectedDate');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByRemoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'remoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByReturned() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'returned');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctBySync() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sync');
    });
  }

  QueryBuilder<LeadingModel, LeadingModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }
}

extension LeadingModelQueryProperty
    on QueryBuilder<LeadingModel, LeadingModel, QQueryProperty> {
  QueryBuilder<LeadingModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LeadingModel, BookEmbedded, QQueryOperations> bookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'book');
    });
  }

  QueryBuilder<LeadingModel, DateTime, QQueryOperations> dateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'date');
    });
  }

  QueryBuilder<LeadingModel, DateTime?, QQueryOperations>
      deliveryDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'deliveryDate');
    });
  }

  QueryBuilder<LeadingModel, DateTime, QQueryOperations>
      expectedDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'expectedDate');
    });
  }

  QueryBuilder<LeadingModel, ReaderEmbedded, QQueryOperations>
      readerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'reader');
    });
  }

  QueryBuilder<LeadingModel, String?, QQueryOperations> remoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'remoteId');
    });
  }

  QueryBuilder<LeadingModel, bool, QQueryOperations> returnedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'returned');
    });
  }

  QueryBuilder<LeadingModel, bool, QQueryOperations> syncProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sync');
    });
  }

  QueryBuilder<LeadingModel, DateTime, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const BookEmbeddedSchema = Schema(
  name: r'BookEmbedded',
  id: 5621800152433035001,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _bookEmbeddedEstimateSize,
  serialize: _bookEmbeddedSerialize,
  deserialize: _bookEmbeddedDeserialize,
  deserializeProp: _bookEmbeddedDeserializeProp,
);

int _bookEmbeddedEstimateSize(
  BookEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _bookEmbeddedSerialize(
  BookEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeString(offsets[1], object.name);
}

BookEmbedded _bookEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookEmbedded();
  object.id = reader.readLongOrNull(offsets[0]);
  object.name = reader.readStringOrNull(offsets[1]);
  return object;
}

P _bookEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension BookEmbeddedQueryFilter
    on QueryBuilder<BookEmbedded, BookEmbedded, QFilterCondition> {
  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> idEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> idLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<BookEmbedded, BookEmbedded, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension BookEmbeddedQueryObject
    on QueryBuilder<BookEmbedded, BookEmbedded, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ReaderEmbeddedSchema = Schema(
  name: r'ReaderEmbedded',
  id: 1397277518898982208,
  properties: {
    r'id': PropertySchema(
      id: 0,
      name: r'id',
      type: IsarType.long,
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _readerEmbeddedEstimateSize,
  serialize: _readerEmbeddedSerialize,
  deserialize: _readerEmbeddedDeserialize,
  deserializeProp: _readerEmbeddedDeserializeProp,
);

int _readerEmbeddedEstimateSize(
  ReaderEmbedded object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.name;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _readerEmbeddedSerialize(
  ReaderEmbedded object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.id);
  writer.writeString(offsets[1], object.name);
}

ReaderEmbedded _readerEmbeddedDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ReaderEmbedded();
  object.id = reader.readLongOrNull(offsets[0]);
  object.name = reader.readStringOrNull(offsets[1]);
  return object;
}

P _readerEmbeddedDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ReaderEmbeddedQueryFilter
    on QueryBuilder<ReaderEmbedded, ReaderEmbedded, QFilterCondition> {
  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      idIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      idIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'id',
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition> idEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      idGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      idLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition> idBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'name',
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<ReaderEmbedded, ReaderEmbedded, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension ReaderEmbeddedQueryObject
    on QueryBuilder<ReaderEmbedded, ReaderEmbedded, QFilterCondition> {}
