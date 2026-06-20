// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $TripsTable extends Trips with TableInfo<$TripsTable, Trip> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TripsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDateMeta = const VerificationMeta(
    'startDate',
  );
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
    'start_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endDateMeta = const VerificationMeta(
    'endDate',
  );
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
    'end_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _baseCurrencyMeta = const VerificationMeta(
    'baseCurrency',
  );
  @override
  late final GeneratedColumn<String> baseCurrency = GeneratedColumn<String>(
    'base_currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estimatedBudgetMeta = const VerificationMeta(
    'estimatedBudget',
  );
  @override
  late final GeneratedColumn<double> estimatedBudget = GeneratedColumn<double>(
    'estimated_budget',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startDate,
    endDate,
    baseCurrency,
    estimatedBudget,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trips';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trip> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(
        _endDateMeta,
        endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta),
      );
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('base_currency')) {
      context.handle(
        _baseCurrencyMeta,
        baseCurrency.isAcceptableOrUnknown(
          data['base_currency']!,
          _baseCurrencyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_baseCurrencyMeta);
    }
    if (data.containsKey('estimated_budget')) {
      context.handle(
        _estimatedBudgetMeta,
        estimatedBudget.isAcceptableOrUnknown(
          data['estimated_budget']!,
          _estimatedBudgetMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trip map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trip(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      )!,
      endDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_date'],
      )!,
      baseCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}base_currency'],
      )!,
      estimatedBudget: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_budget'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $TripsTable createAlias(String alias) {
    return $TripsTable(attachedDatabase, alias);
  }
}

class Trip extends DataClass implements Insertable<Trip> {
  final int id;
  final String title;
  final DateTime startDate;
  final DateTime endDate;
  final String baseCurrency;
  final double estimatedBudget;
  final String? notes;
  const Trip({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.baseCurrency,
    required this.estimatedBudget,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    map['base_currency'] = Variable<String>(baseCurrency);
    map['estimated_budget'] = Variable<double>(estimatedBudget);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TripsCompanion toCompanion(bool nullToAbsent) {
    return TripsCompanion(
      id: Value(id),
      title: Value(title),
      startDate: Value(startDate),
      endDate: Value(endDate),
      baseCurrency: Value(baseCurrency),
      estimatedBudget: Value(estimatedBudget),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Trip.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trip(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      baseCurrency: serializer.fromJson<String>(json['baseCurrency']),
      estimatedBudget: serializer.fromJson<double>(json['estimatedBudget']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'baseCurrency': serializer.toJson<String>(baseCurrency),
      'estimatedBudget': serializer.toJson<double>(estimatedBudget),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Trip copyWith({
    int? id,
    String? title,
    DateTime? startDate,
    DateTime? endDate,
    String? baseCurrency,
    double? estimatedBudget,
    Value<String?> notes = const Value.absent(),
  }) => Trip(
    id: id ?? this.id,
    title: title ?? this.title,
    startDate: startDate ?? this.startDate,
    endDate: endDate ?? this.endDate,
    baseCurrency: baseCurrency ?? this.baseCurrency,
    estimatedBudget: estimatedBudget ?? this.estimatedBudget,
    notes: notes.present ? notes.value : this.notes,
  );
  Trip copyWithCompanion(TripsCompanion data) {
    return Trip(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      baseCurrency: data.baseCurrency.present
          ? data.baseCurrency.value
          : this.baseCurrency,
      estimatedBudget: data.estimatedBudget.present
          ? data.estimatedBudget.value
          : this.estimatedBudget,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trip(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('estimatedBudget: $estimatedBudget, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    startDate,
    endDate,
    baseCurrency,
    estimatedBudget,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trip &&
          other.id == this.id &&
          other.title == this.title &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.baseCurrency == this.baseCurrency &&
          other.estimatedBudget == this.estimatedBudget &&
          other.notes == this.notes);
}

class TripsCompanion extends UpdateCompanion<Trip> {
  final Value<int> id;
  final Value<String> title;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String> baseCurrency;
  final Value<double> estimatedBudget;
  final Value<String?> notes;
  const TripsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.baseCurrency = const Value.absent(),
    this.estimatedBudget = const Value.absent(),
    this.notes = const Value.absent(),
  });
  TripsCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required DateTime startDate,
    required DateTime endDate,
    required String baseCurrency,
    this.estimatedBudget = const Value.absent(),
    this.notes = const Value.absent(),
  }) : title = Value(title),
       startDate = Value(startDate),
       endDate = Value(endDate),
       baseCurrency = Value(baseCurrency);
  static Insertable<Trip> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? baseCurrency,
    Expression<double>? estimatedBudget,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (baseCurrency != null) 'base_currency': baseCurrency,
      if (estimatedBudget != null) 'estimated_budget': estimatedBudget,
      if (notes != null) 'notes': notes,
    });
  }

  TripsCompanion copyWith({
    Value<int>? id,
    Value<String>? title,
    Value<DateTime>? startDate,
    Value<DateTime>? endDate,
    Value<String>? baseCurrency,
    Value<double>? estimatedBudget,
    Value<String?>? notes,
  }) {
    return TripsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      baseCurrency: baseCurrency ?? this.baseCurrency,
      estimatedBudget: estimatedBudget ?? this.estimatedBudget,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (baseCurrency.present) {
      map['base_currency'] = Variable<String>(baseCurrency.value);
    }
    if (estimatedBudget.present) {
      map['estimated_budget'] = Variable<double>(estimatedBudget.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TripsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('baseCurrency: $baseCurrency, ')
          ..write('estimatedBudget: $estimatedBudget, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $DestinationsTable extends Destinations
    with TableInfo<$DestinationsTable, Destination> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DestinationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _orderIndexMeta = const VerificationMeta(
    'orderIndex',
  );
  @override
  late final GeneratedColumn<int> orderIndex = GeneratedColumn<int>(
    'order_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tripId, country, city, orderIndex];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'destinations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Destination> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    } else if (isInserting) {
      context.missing(_countryMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('order_index')) {
      context.handle(
        _orderIndexMeta,
        orderIndex.isAcceptableOrUnknown(data['order_index']!, _orderIndexMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Destination map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Destination(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      orderIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order_index'],
      )!,
    );
  }

  @override
  $DestinationsTable createAlias(String alias) {
    return $DestinationsTable(attachedDatabase, alias);
  }
}

class Destination extends DataClass implements Insertable<Destination> {
  final int id;
  final int tripId;
  final String country;
  final String city;
  final int orderIndex;
  const Destination({
    required this.id,
    required this.tripId,
    required this.country,
    required this.city,
    required this.orderIndex,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['country'] = Variable<String>(country);
    map['city'] = Variable<String>(city);
    map['order_index'] = Variable<int>(orderIndex);
    return map;
  }

  DestinationsCompanion toCompanion(bool nullToAbsent) {
    return DestinationsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      country: Value(country),
      city: Value(city),
      orderIndex: Value(orderIndex),
    );
  }

  factory Destination.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Destination(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      country: serializer.fromJson<String>(json['country']),
      city: serializer.fromJson<String>(json['city']),
      orderIndex: serializer.fromJson<int>(json['orderIndex']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'country': serializer.toJson<String>(country),
      'city': serializer.toJson<String>(city),
      'orderIndex': serializer.toJson<int>(orderIndex),
    };
  }

  Destination copyWith({
    int? id,
    int? tripId,
    String? country,
    String? city,
    int? orderIndex,
  }) => Destination(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    country: country ?? this.country,
    city: city ?? this.city,
    orderIndex: orderIndex ?? this.orderIndex,
  );
  Destination copyWithCompanion(DestinationsCompanion data) {
    return Destination(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      country: data.country.present ? data.country.value : this.country,
      city: data.city.present ? data.city.value : this.city,
      orderIndex: data.orderIndex.present
          ? data.orderIndex.value
          : this.orderIndex,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Destination(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tripId, country, city, orderIndex);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Destination &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.country == this.country &&
          other.city == this.city &&
          other.orderIndex == this.orderIndex);
}

class DestinationsCompanion extends UpdateCompanion<Destination> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> country;
  final Value<String> city;
  final Value<int> orderIndex;
  const DestinationsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.country = const Value.absent(),
    this.city = const Value.absent(),
    this.orderIndex = const Value.absent(),
  });
  DestinationsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String country,
    required String city,
    this.orderIndex = const Value.absent(),
  }) : tripId = Value(tripId),
       country = Value(country),
       city = Value(city);
  static Insertable<Destination> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? country,
    Expression<String>? city,
    Expression<int>? orderIndex,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (country != null) 'country': country,
      if (city != null) 'city': city,
      if (orderIndex != null) 'order_index': orderIndex,
    });
  }

  DestinationsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? country,
    Value<String>? city,
    Value<int>? orderIndex,
  }) {
    return DestinationsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      country: country ?? this.country,
      city: city ?? this.city,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (orderIndex.present) {
      map['order_index'] = Variable<int>(orderIndex.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DestinationsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('country: $country, ')
          ..write('city: $city, ')
          ..write('orderIndex: $orderIndex')
          ..write(')'))
        .toString();
  }
}

class $ItineraryDaysTable extends ItineraryDays
    with TableInfo<$ItineraryDaysTable, ItineraryDay> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItineraryDaysTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, tripId, date, title, notes];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'itinerary_days';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItineraryDay> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItineraryDay map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItineraryDay(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ItineraryDaysTable createAlias(String alias) {
    return $ItineraryDaysTable(attachedDatabase, alias);
  }
}

class ItineraryDay extends DataClass implements Insertable<ItineraryDay> {
  final int id;
  final int tripId;
  final DateTime date;
  final String title;
  final String? notes;
  const ItineraryDay({
    required this.id,
    required this.tripId,
    required this.date,
    required this.title,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['date'] = Variable<DateTime>(date);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ItineraryDaysCompanion toCompanion(bool nullToAbsent) {
    return ItineraryDaysCompanion(
      id: Value(id),
      tripId: Value(tripId),
      date: Value(date),
      title: Value(title),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory ItineraryDay.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItineraryDay(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      date: serializer.fromJson<DateTime>(json['date']),
      title: serializer.fromJson<String>(json['title']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'date': serializer.toJson<DateTime>(date),
      'title': serializer.toJson<String>(title),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  ItineraryDay copyWith({
    int? id,
    int? tripId,
    DateTime? date,
    String? title,
    Value<String?> notes = const Value.absent(),
  }) => ItineraryDay(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    date: date ?? this.date,
    title: title ?? this.title,
    notes: notes.present ? notes.value : this.notes,
  );
  ItineraryDay copyWithCompanion(ItineraryDaysCompanion data) {
    return ItineraryDay(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      date: data.date.present ? data.date.value : this.date,
      title: data.title.present ? data.title.value : this.title,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItineraryDay(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tripId, date, title, notes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItineraryDay &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.date == this.date &&
          other.title == this.title &&
          other.notes == this.notes);
}

class ItineraryDaysCompanion extends UpdateCompanion<ItineraryDay> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<DateTime> date;
  final Value<String> title;
  final Value<String?> notes;
  const ItineraryDaysCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.date = const Value.absent(),
    this.title = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ItineraryDaysCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required DateTime date,
    required String title,
    this.notes = const Value.absent(),
  }) : tripId = Value(tripId),
       date = Value(date),
       title = Value(title);
  static Insertable<ItineraryDay> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<DateTime>? date,
    Expression<String>? title,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (date != null) 'date': date,
      if (title != null) 'title': title,
      if (notes != null) 'notes': notes,
    });
  }

  ItineraryDaysCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<DateTime>? date,
    Value<String>? title,
    Value<String?>? notes,
  }) {
    return ItineraryDaysCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      date: date ?? this.date,
      title: title ?? this.title,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItineraryDaysCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('date: $date, ')
          ..write('title: $title, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $ActivitiesTable extends Activities
    with TableInfo<$ActivitiesTable, Activity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _itineraryDayIdMeta = const VerificationMeta(
    'itineraryDayId',
  );
  @override
  late final GeneratedColumn<int> itineraryDayId = GeneratedColumn<int>(
    'itinerary_day_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES itinerary_days (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _estimatedCostMeta = const VerificationMeta(
    'estimatedCost',
  );
  @override
  late final GeneratedColumn<double> estimatedCost = GeneratedColumn<double>(
    'estimated_cost',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itineraryDayId,
    title,
    location,
    time,
    estimatedCost,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<Activity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('itinerary_day_id')) {
      context.handle(
        _itineraryDayIdMeta,
        itineraryDayId.isAcceptableOrUnknown(
          data['itinerary_day_id']!,
          _itineraryDayIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_itineraryDayIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('estimated_cost')) {
      context.handle(
        _estimatedCostMeta,
        estimatedCost.isAcceptableOrUnknown(
          data['estimated_cost']!,
          _estimatedCostMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Activity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Activity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      itineraryDayId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}itinerary_day_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      ),
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      ),
      estimatedCost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}estimated_cost'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $ActivitiesTable createAlias(String alias) {
    return $ActivitiesTable(attachedDatabase, alias);
  }
}

class Activity extends DataClass implements Insertable<Activity> {
  final int id;
  final int itineraryDayId;
  final String title;
  final String? location;
  final DateTime? time;
  final double? estimatedCost;
  final String? notes;
  const Activity({
    required this.id,
    required this.itineraryDayId,
    required this.title,
    this.location,
    this.time,
    this.estimatedCost,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['itinerary_day_id'] = Variable<int>(itineraryDayId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    if (!nullToAbsent || estimatedCost != null) {
      map['estimated_cost'] = Variable<double>(estimatedCost);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  ActivitiesCompanion toCompanion(bool nullToAbsent) {
    return ActivitiesCompanion(
      id: Value(id),
      itineraryDayId: Value(itineraryDayId),
      title: Value(title),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      estimatedCost: estimatedCost == null && nullToAbsent
          ? const Value.absent()
          : Value(estimatedCost),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Activity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Activity(
      id: serializer.fromJson<int>(json['id']),
      itineraryDayId: serializer.fromJson<int>(json['itineraryDayId']),
      title: serializer.fromJson<String>(json['title']),
      location: serializer.fromJson<String?>(json['location']),
      time: serializer.fromJson<DateTime?>(json['time']),
      estimatedCost: serializer.fromJson<double?>(json['estimatedCost']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'itineraryDayId': serializer.toJson<int>(itineraryDayId),
      'title': serializer.toJson<String>(title),
      'location': serializer.toJson<String?>(location),
      'time': serializer.toJson<DateTime?>(time),
      'estimatedCost': serializer.toJson<double?>(estimatedCost),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Activity copyWith({
    int? id,
    int? itineraryDayId,
    String? title,
    Value<String?> location = const Value.absent(),
    Value<DateTime?> time = const Value.absent(),
    Value<double?> estimatedCost = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Activity(
    id: id ?? this.id,
    itineraryDayId: itineraryDayId ?? this.itineraryDayId,
    title: title ?? this.title,
    location: location.present ? location.value : this.location,
    time: time.present ? time.value : this.time,
    estimatedCost: estimatedCost.present
        ? estimatedCost.value
        : this.estimatedCost,
    notes: notes.present ? notes.value : this.notes,
  );
  Activity copyWithCompanion(ActivitiesCompanion data) {
    return Activity(
      id: data.id.present ? data.id.value : this.id,
      itineraryDayId: data.itineraryDayId.present
          ? data.itineraryDayId.value
          : this.itineraryDayId,
      title: data.title.present ? data.title.value : this.title,
      location: data.location.present ? data.location.value : this.location,
      time: data.time.present ? data.time.value : this.time,
      estimatedCost: data.estimatedCost.present
          ? data.estimatedCost.value
          : this.estimatedCost,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Activity(')
          ..write('id: $id, ')
          ..write('itineraryDayId: $itineraryDayId, ')
          ..write('title: $title, ')
          ..write('location: $location, ')
          ..write('time: $time, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itineraryDayId,
    title,
    location,
    time,
    estimatedCost,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Activity &&
          other.id == this.id &&
          other.itineraryDayId == this.itineraryDayId &&
          other.title == this.title &&
          other.location == this.location &&
          other.time == this.time &&
          other.estimatedCost == this.estimatedCost &&
          other.notes == this.notes);
}

class ActivitiesCompanion extends UpdateCompanion<Activity> {
  final Value<int> id;
  final Value<int> itineraryDayId;
  final Value<String> title;
  final Value<String?> location;
  final Value<DateTime?> time;
  final Value<double?> estimatedCost;
  final Value<String?> notes;
  const ActivitiesCompanion({
    this.id = const Value.absent(),
    this.itineraryDayId = const Value.absent(),
    this.title = const Value.absent(),
    this.location = const Value.absent(),
    this.time = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.notes = const Value.absent(),
  });
  ActivitiesCompanion.insert({
    this.id = const Value.absent(),
    required int itineraryDayId,
    required String title,
    this.location = const Value.absent(),
    this.time = const Value.absent(),
    this.estimatedCost = const Value.absent(),
    this.notes = const Value.absent(),
  }) : itineraryDayId = Value(itineraryDayId),
       title = Value(title);
  static Insertable<Activity> custom({
    Expression<int>? id,
    Expression<int>? itineraryDayId,
    Expression<String>? title,
    Expression<String>? location,
    Expression<DateTime>? time,
    Expression<double>? estimatedCost,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itineraryDayId != null) 'itinerary_day_id': itineraryDayId,
      if (title != null) 'title': title,
      if (location != null) 'location': location,
      if (time != null) 'time': time,
      if (estimatedCost != null) 'estimated_cost': estimatedCost,
      if (notes != null) 'notes': notes,
    });
  }

  ActivitiesCompanion copyWith({
    Value<int>? id,
    Value<int>? itineraryDayId,
    Value<String>? title,
    Value<String?>? location,
    Value<DateTime?>? time,
    Value<double?>? estimatedCost,
    Value<String?>? notes,
  }) {
    return ActivitiesCompanion(
      id: id ?? this.id,
      itineraryDayId: itineraryDayId ?? this.itineraryDayId,
      title: title ?? this.title,
      location: location ?? this.location,
      time: time ?? this.time,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (itineraryDayId.present) {
      map['itinerary_day_id'] = Variable<int>(itineraryDayId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (estimatedCost.present) {
      map['estimated_cost'] = Variable<double>(estimatedCost.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('itineraryDayId: $itineraryDayId, ')
          ..write('title: $title, ')
          ..write('location: $location, ')
          ..write('time: $time, ')
          ..write('estimatedCost: $estimatedCost, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $BudgetCategoriesTable extends BudgetCategories
    with TableInfo<$BudgetCategoriesTable, BudgetCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BudgetCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plannedAmountMeta = const VerificationMeta(
    'plannedAmount',
  );
  @override
  late final GeneratedColumn<double> plannedAmount = GeneratedColumn<double>(
    'planned_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tripId, category, plannedAmount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'budget_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<BudgetCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('planned_amount')) {
      context.handle(
        _plannedAmountMeta,
        plannedAmount.isAcceptableOrUnknown(
          data['planned_amount']!,
          _plannedAmountMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BudgetCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BudgetCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      plannedAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}planned_amount'],
      )!,
    );
  }

  @override
  $BudgetCategoriesTable createAlias(String alias) {
    return $BudgetCategoriesTable(attachedDatabase, alias);
  }
}

class BudgetCategory extends DataClass implements Insertable<BudgetCategory> {
  final int id;
  final int tripId;
  final String category;
  final double plannedAmount;
  const BudgetCategory({
    required this.id,
    required this.tripId,
    required this.category,
    required this.plannedAmount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['category'] = Variable<String>(category);
    map['planned_amount'] = Variable<double>(plannedAmount);
    return map;
  }

  BudgetCategoriesCompanion toCompanion(bool nullToAbsent) {
    return BudgetCategoriesCompanion(
      id: Value(id),
      tripId: Value(tripId),
      category: Value(category),
      plannedAmount: Value(plannedAmount),
    );
  }

  factory BudgetCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BudgetCategory(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      category: serializer.fromJson<String>(json['category']),
      plannedAmount: serializer.fromJson<double>(json['plannedAmount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'category': serializer.toJson<String>(category),
      'plannedAmount': serializer.toJson<double>(plannedAmount),
    };
  }

  BudgetCategory copyWith({
    int? id,
    int? tripId,
    String? category,
    double? plannedAmount,
  }) => BudgetCategory(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    category: category ?? this.category,
    plannedAmount: plannedAmount ?? this.plannedAmount,
  );
  BudgetCategory copyWithCompanion(BudgetCategoriesCompanion data) {
    return BudgetCategory(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      category: data.category.present ? data.category.value : this.category,
      plannedAmount: data.plannedAmount.present
          ? data.plannedAmount.value
          : this.plannedAmount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategory(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('category: $category, ')
          ..write('plannedAmount: $plannedAmount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tripId, category, plannedAmount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BudgetCategory &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.category == this.category &&
          other.plannedAmount == this.plannedAmount);
}

class BudgetCategoriesCompanion extends UpdateCompanion<BudgetCategory> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> category;
  final Value<double> plannedAmount;
  const BudgetCategoriesCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.category = const Value.absent(),
    this.plannedAmount = const Value.absent(),
  });
  BudgetCategoriesCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String category,
    this.plannedAmount = const Value.absent(),
  }) : tripId = Value(tripId),
       category = Value(category);
  static Insertable<BudgetCategory> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? category,
    Expression<double>? plannedAmount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (category != null) 'category': category,
      if (plannedAmount != null) 'planned_amount': plannedAmount,
    });
  }

  BudgetCategoriesCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? category,
    Value<double>? plannedAmount,
  }) {
    return BudgetCategoriesCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      category: category ?? this.category,
      plannedAmount: plannedAmount ?? this.plannedAmount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (plannedAmount.present) {
      map['planned_amount'] = Variable<double>(plannedAmount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BudgetCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('category: $category, ')
          ..write('plannedAmount: $plannedAmount')
          ..write(')'))
        .toString();
  }
}

class $ExpensesTable extends Expenses with TableInfo<$ExpensesTable, Expense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExpensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 3,
      maxTextLength: 3,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exchangeRateMeta = const VerificationMeta(
    'exchangeRate',
  );
  @override
  late final GeneratedColumn<double> exchangeRate = GeneratedColumn<double>(
    'exchange_rate',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    title,
    category,
    amount,
    currency,
    exchangeRate,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'expenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Expense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    } else if (isInserting) {
      context.missing(_currencyMeta);
    }
    if (data.containsKey('exchange_rate')) {
      context.handle(
        _exchangeRateMeta,
        exchangeRate.isAcceptableOrUnknown(
          data['exchange_rate']!,
          _exchangeRateMeta,
        ),
      );
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Expense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Expense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      exchangeRate: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}exchange_rate'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $ExpensesTable createAlias(String alias) {
    return $ExpensesTable(attachedDatabase, alias);
  }
}

class Expense extends DataClass implements Insertable<Expense> {
  final int id;
  final int tripId;
  final String title;
  final String category;
  final double amount;
  final String currency;
  final double exchangeRate;
  final DateTime date;
  const Expense({
    required this.id,
    required this.tripId,
    required this.title,
    required this.category,
    required this.amount,
    required this.currency,
    required this.exchangeRate,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['amount'] = Variable<double>(amount);
    map['currency'] = Variable<String>(currency);
    map['exchange_rate'] = Variable<double>(exchangeRate);
    map['date'] = Variable<DateTime>(date);
    return map;
  }

  ExpensesCompanion toCompanion(bool nullToAbsent) {
    return ExpensesCompanion(
      id: Value(id),
      tripId: Value(tripId),
      title: Value(title),
      category: Value(category),
      amount: Value(amount),
      currency: Value(currency),
      exchangeRate: Value(exchangeRate),
      date: Value(date),
    );
  }

  factory Expense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Expense(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      amount: serializer.fromJson<double>(json['amount']),
      currency: serializer.fromJson<String>(json['currency']),
      exchangeRate: serializer.fromJson<double>(json['exchangeRate']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'amount': serializer.toJson<double>(amount),
      'currency': serializer.toJson<String>(currency),
      'exchangeRate': serializer.toJson<double>(exchangeRate),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  Expense copyWith({
    int? id,
    int? tripId,
    String? title,
    String? category,
    double? amount,
    String? currency,
    double? exchangeRate,
    DateTime? date,
  }) => Expense(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    title: title ?? this.title,
    category: category ?? this.category,
    amount: amount ?? this.amount,
    currency: currency ?? this.currency,
    exchangeRate: exchangeRate ?? this.exchangeRate,
    date: date ?? this.date,
  );
  Expense copyWithCompanion(ExpensesCompanion data) {
    return Expense(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      currency: data.currency.present ? data.currency.value : this.currency,
      exchangeRate: data.exchangeRate.present
          ? data.exchangeRate.value
          : this.exchangeRate,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Expense(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    title,
    category,
    amount,
    currency,
    exchangeRate,
    date,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Expense &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.title == this.title &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.currency == this.currency &&
          other.exchangeRate == this.exchangeRate &&
          other.date == this.date);
}

class ExpensesCompanion extends UpdateCompanion<Expense> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> title;
  final Value<String> category;
  final Value<double> amount;
  final Value<String> currency;
  final Value<double> exchangeRate;
  final Value<DateTime> date;
  const ExpensesCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.currency = const Value.absent(),
    this.exchangeRate = const Value.absent(),
    this.date = const Value.absent(),
  });
  ExpensesCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String title,
    required String category,
    required double amount,
    required String currency,
    this.exchangeRate = const Value.absent(),
    required DateTime date,
  }) : tripId = Value(tripId),
       title = Value(title),
       category = Value(category),
       amount = Value(amount),
       currency = Value(currency),
       date = Value(date);
  static Insertable<Expense> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? currency,
    Expression<double>? exchangeRate,
    Expression<DateTime>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (currency != null) 'currency': currency,
      if (exchangeRate != null) 'exchange_rate': exchangeRate,
      if (date != null) 'date': date,
    });
  }

  ExpensesCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? title,
    Value<String>? category,
    Value<double>? amount,
    Value<String>? currency,
    Value<double>? exchangeRate,
    Value<DateTime>? date,
  }) {
    return ExpensesCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      exchangeRate: exchangeRate ?? this.exchangeRate,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (exchangeRate.present) {
      map['exchange_rate'] = Variable<double>(exchangeRate.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExpensesCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('currency: $currency, ')
          ..write('exchangeRate: $exchangeRate, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $TransportsTable extends Transports
    with TableInfo<$TransportsTable, Transport> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<String> from = GeneratedColumn<String>(
    'from',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toMeta = const VerificationMeta('to');
  @override
  late final GeneratedColumn<String> to = GeneratedColumn<String>(
    'to',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _departureDateTimeMeta = const VerificationMeta(
    'departureDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> departureDateTime =
      GeneratedColumn<DateTime>(
        'departure_date_time',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _arrivalDateTimeMeta = const VerificationMeta(
    'arrivalDateTime',
  );
  @override
  late final GeneratedColumn<DateTime> arrivalDateTime =
      GeneratedColumn<DateTime>(
        'arrival_date_time',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bookingReferenceMeta = const VerificationMeta(
    'bookingReference',
  );
  @override
  late final GeneratedColumn<String> bookingReference = GeneratedColumn<String>(
    'booking_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    type,
    from,
    to,
    departureDateTime,
    arrivalDateTime,
    cost,
    bookingReference,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transports';
  @override
  VerificationContext validateIntegrity(
    Insertable<Transport> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('from')) {
      context.handle(
        _fromMeta,
        from.isAcceptableOrUnknown(data['from']!, _fromMeta),
      );
    } else if (isInserting) {
      context.missing(_fromMeta);
    }
    if (data.containsKey('to')) {
      context.handle(_toMeta, to.isAcceptableOrUnknown(data['to']!, _toMeta));
    } else if (isInserting) {
      context.missing(_toMeta);
    }
    if (data.containsKey('departure_date_time')) {
      context.handle(
        _departureDateTimeMeta,
        departureDateTime.isAcceptableOrUnknown(
          data['departure_date_time']!,
          _departureDateTimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_departureDateTimeMeta);
    }
    if (data.containsKey('arrival_date_time')) {
      context.handle(
        _arrivalDateTimeMeta,
        arrivalDateTime.isAcceptableOrUnknown(
          data['arrival_date_time']!,
          _arrivalDateTimeMeta,
        ),
      );
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('booking_reference')) {
      context.handle(
        _bookingReferenceMeta,
        bookingReference.isAcceptableOrUnknown(
          data['booking_reference']!,
          _bookingReferenceMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transport map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transport(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      from: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}from'],
      )!,
      to: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to'],
      )!,
      departureDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}departure_date_time'],
      )!,
      arrivalDateTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}arrival_date_time'],
      ),
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      bookingReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}booking_reference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $TransportsTable createAlias(String alias) {
    return $TransportsTable(attachedDatabase, alias);
  }
}

class Transport extends DataClass implements Insertable<Transport> {
  final int id;
  final int tripId;
  final String type;
  final String from;
  final String to;
  final DateTime departureDateTime;
  final DateTime? arrivalDateTime;
  final double cost;
  final String? bookingReference;
  final String? notes;
  const Transport({
    required this.id,
    required this.tripId,
    required this.type,
    required this.from,
    required this.to,
    required this.departureDateTime,
    this.arrivalDateTime,
    required this.cost,
    this.bookingReference,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['type'] = Variable<String>(type);
    map['from'] = Variable<String>(from);
    map['to'] = Variable<String>(to);
    map['departure_date_time'] = Variable<DateTime>(departureDateTime);
    if (!nullToAbsent || arrivalDateTime != null) {
      map['arrival_date_time'] = Variable<DateTime>(arrivalDateTime);
    }
    map['cost'] = Variable<double>(cost);
    if (!nullToAbsent || bookingReference != null) {
      map['booking_reference'] = Variable<String>(bookingReference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  TransportsCompanion toCompanion(bool nullToAbsent) {
    return TransportsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      type: Value(type),
      from: Value(from),
      to: Value(to),
      departureDateTime: Value(departureDateTime),
      arrivalDateTime: arrivalDateTime == null && nullToAbsent
          ? const Value.absent()
          : Value(arrivalDateTime),
      cost: Value(cost),
      bookingReference: bookingReference == null && nullToAbsent
          ? const Value.absent()
          : Value(bookingReference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Transport.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transport(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      type: serializer.fromJson<String>(json['type']),
      from: serializer.fromJson<String>(json['from']),
      to: serializer.fromJson<String>(json['to']),
      departureDateTime: serializer.fromJson<DateTime>(
        json['departureDateTime'],
      ),
      arrivalDateTime: serializer.fromJson<DateTime?>(json['arrivalDateTime']),
      cost: serializer.fromJson<double>(json['cost']),
      bookingReference: serializer.fromJson<String?>(json['bookingReference']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'type': serializer.toJson<String>(type),
      'from': serializer.toJson<String>(from),
      'to': serializer.toJson<String>(to),
      'departureDateTime': serializer.toJson<DateTime>(departureDateTime),
      'arrivalDateTime': serializer.toJson<DateTime?>(arrivalDateTime),
      'cost': serializer.toJson<double>(cost),
      'bookingReference': serializer.toJson<String?>(bookingReference),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Transport copyWith({
    int? id,
    int? tripId,
    String? type,
    String? from,
    String? to,
    DateTime? departureDateTime,
    Value<DateTime?> arrivalDateTime = const Value.absent(),
    double? cost,
    Value<String?> bookingReference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Transport(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    type: type ?? this.type,
    from: from ?? this.from,
    to: to ?? this.to,
    departureDateTime: departureDateTime ?? this.departureDateTime,
    arrivalDateTime: arrivalDateTime.present
        ? arrivalDateTime.value
        : this.arrivalDateTime,
    cost: cost ?? this.cost,
    bookingReference: bookingReference.present
        ? bookingReference.value
        : this.bookingReference,
    notes: notes.present ? notes.value : this.notes,
  );
  Transport copyWithCompanion(TransportsCompanion data) {
    return Transport(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      type: data.type.present ? data.type.value : this.type,
      from: data.from.present ? data.from.value : this.from,
      to: data.to.present ? data.to.value : this.to,
      departureDateTime: data.departureDateTime.present
          ? data.departureDateTime.value
          : this.departureDateTime,
      arrivalDateTime: data.arrivalDateTime.present
          ? data.arrivalDateTime.value
          : this.arrivalDateTime,
      cost: data.cost.present ? data.cost.value : this.cost,
      bookingReference: data.bookingReference.present
          ? data.bookingReference.value
          : this.bookingReference,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transport(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('type: $type, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('departureDateTime: $departureDateTime, ')
          ..write('arrivalDateTime: $arrivalDateTime, ')
          ..write('cost: $cost, ')
          ..write('bookingReference: $bookingReference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    type,
    from,
    to,
    departureDateTime,
    arrivalDateTime,
    cost,
    bookingReference,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transport &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.type == this.type &&
          other.from == this.from &&
          other.to == this.to &&
          other.departureDateTime == this.departureDateTime &&
          other.arrivalDateTime == this.arrivalDateTime &&
          other.cost == this.cost &&
          other.bookingReference == this.bookingReference &&
          other.notes == this.notes);
}

class TransportsCompanion extends UpdateCompanion<Transport> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> type;
  final Value<String> from;
  final Value<String> to;
  final Value<DateTime> departureDateTime;
  final Value<DateTime?> arrivalDateTime;
  final Value<double> cost;
  final Value<String?> bookingReference;
  final Value<String?> notes;
  const TransportsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.type = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
    this.departureDateTime = const Value.absent(),
    this.arrivalDateTime = const Value.absent(),
    this.cost = const Value.absent(),
    this.bookingReference = const Value.absent(),
    this.notes = const Value.absent(),
  });
  TransportsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String type,
    required String from,
    required String to,
    required DateTime departureDateTime,
    this.arrivalDateTime = const Value.absent(),
    this.cost = const Value.absent(),
    this.bookingReference = const Value.absent(),
    this.notes = const Value.absent(),
  }) : tripId = Value(tripId),
       type = Value(type),
       from = Value(from),
       to = Value(to),
       departureDateTime = Value(departureDateTime);
  static Insertable<Transport> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? type,
    Expression<String>? from,
    Expression<String>? to,
    Expression<DateTime>? departureDateTime,
    Expression<DateTime>? arrivalDateTime,
    Expression<double>? cost,
    Expression<String>? bookingReference,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (type != null) 'type': type,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
      if (departureDateTime != null) 'departure_date_time': departureDateTime,
      if (arrivalDateTime != null) 'arrival_date_time': arrivalDateTime,
      if (cost != null) 'cost': cost,
      if (bookingReference != null) 'booking_reference': bookingReference,
      if (notes != null) 'notes': notes,
    });
  }

  TransportsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? type,
    Value<String>? from,
    Value<String>? to,
    Value<DateTime>? departureDateTime,
    Value<DateTime?>? arrivalDateTime,
    Value<double>? cost,
    Value<String?>? bookingReference,
    Value<String?>? notes,
  }) {
    return TransportsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      type: type ?? this.type,
      from: from ?? this.from,
      to: to ?? this.to,
      departureDateTime: departureDateTime ?? this.departureDateTime,
      arrivalDateTime: arrivalDateTime ?? this.arrivalDateTime,
      cost: cost ?? this.cost,
      bookingReference: bookingReference ?? this.bookingReference,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (from.present) {
      map['from'] = Variable<String>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<String>(to.value);
    }
    if (departureDateTime.present) {
      map['departure_date_time'] = Variable<DateTime>(departureDateTime.value);
    }
    if (arrivalDateTime.present) {
      map['arrival_date_time'] = Variable<DateTime>(arrivalDateTime.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (bookingReference.present) {
      map['booking_reference'] = Variable<String>(bookingReference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransportsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('type: $type, ')
          ..write('from: $from, ')
          ..write('to: $to, ')
          ..write('departureDateTime: $departureDateTime, ')
          ..write('arrivalDateTime: $arrivalDateTime, ')
          ..write('cost: $cost, ')
          ..write('bookingReference: $bookingReference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $AccommodationsTable extends Accommodations
    with TableInfo<$AccommodationsTable, Accommodation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AccommodationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkInMeta = const VerificationMeta(
    'checkIn',
  );
  @override
  late final GeneratedColumn<DateTime> checkIn = GeneratedColumn<DateTime>(
    'check_in',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _checkOutMeta = const VerificationMeta(
    'checkOut',
  );
  @override
  late final GeneratedColumn<DateTime> checkOut = GeneratedColumn<DateTime>(
    'check_out',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costMeta = const VerificationMeta('cost');
  @override
  late final GeneratedColumn<double> cost = GeneratedColumn<double>(
    'cost',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _bookingReferenceMeta = const VerificationMeta(
    'bookingReference',
  );
  @override
  late final GeneratedColumn<String> bookingReference = GeneratedColumn<String>(
    'booking_reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tripId,
    name,
    city,
    checkIn,
    checkOut,
    cost,
    bookingReference,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'accommodations';
  @override
  VerificationContext validateIntegrity(
    Insertable<Accommodation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('check_in')) {
      context.handle(
        _checkInMeta,
        checkIn.isAcceptableOrUnknown(data['check_in']!, _checkInMeta),
      );
    } else if (isInserting) {
      context.missing(_checkInMeta);
    }
    if (data.containsKey('check_out')) {
      context.handle(
        _checkOutMeta,
        checkOut.isAcceptableOrUnknown(data['check_out']!, _checkOutMeta),
      );
    } else if (isInserting) {
      context.missing(_checkOutMeta);
    }
    if (data.containsKey('cost')) {
      context.handle(
        _costMeta,
        cost.isAcceptableOrUnknown(data['cost']!, _costMeta),
      );
    }
    if (data.containsKey('booking_reference')) {
      context.handle(
        _bookingReferenceMeta,
        bookingReference.isAcceptableOrUnknown(
          data['booking_reference']!,
          _bookingReferenceMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Accommodation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Accommodation(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      checkIn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_in'],
      )!,
      checkOut: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}check_out'],
      )!,
      cost: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost'],
      )!,
      bookingReference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}booking_reference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $AccommodationsTable createAlias(String alias) {
    return $AccommodationsTable(attachedDatabase, alias);
  }
}

class Accommodation extends DataClass implements Insertable<Accommodation> {
  final int id;
  final int tripId;
  final String name;
  final String city;
  final DateTime checkIn;
  final DateTime checkOut;
  final double cost;
  final String? bookingReference;
  final String? notes;
  const Accommodation({
    required this.id,
    required this.tripId,
    required this.name,
    required this.city,
    required this.checkIn,
    required this.checkOut,
    required this.cost,
    this.bookingReference,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['name'] = Variable<String>(name);
    map['city'] = Variable<String>(city);
    map['check_in'] = Variable<DateTime>(checkIn);
    map['check_out'] = Variable<DateTime>(checkOut);
    map['cost'] = Variable<double>(cost);
    if (!nullToAbsent || bookingReference != null) {
      map['booking_reference'] = Variable<String>(bookingReference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  AccommodationsCompanion toCompanion(bool nullToAbsent) {
    return AccommodationsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      name: Value(name),
      city: Value(city),
      checkIn: Value(checkIn),
      checkOut: Value(checkOut),
      cost: Value(cost),
      bookingReference: bookingReference == null && nullToAbsent
          ? const Value.absent()
          : Value(bookingReference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
    );
  }

  factory Accommodation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Accommodation(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      name: serializer.fromJson<String>(json['name']),
      city: serializer.fromJson<String>(json['city']),
      checkIn: serializer.fromJson<DateTime>(json['checkIn']),
      checkOut: serializer.fromJson<DateTime>(json['checkOut']),
      cost: serializer.fromJson<double>(json['cost']),
      bookingReference: serializer.fromJson<String?>(json['bookingReference']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'name': serializer.toJson<String>(name),
      'city': serializer.toJson<String>(city),
      'checkIn': serializer.toJson<DateTime>(checkIn),
      'checkOut': serializer.toJson<DateTime>(checkOut),
      'cost': serializer.toJson<double>(cost),
      'bookingReference': serializer.toJson<String?>(bookingReference),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  Accommodation copyWith({
    int? id,
    int? tripId,
    String? name,
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
    double? cost,
    Value<String?> bookingReference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
  }) => Accommodation(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    name: name ?? this.name,
    city: city ?? this.city,
    checkIn: checkIn ?? this.checkIn,
    checkOut: checkOut ?? this.checkOut,
    cost: cost ?? this.cost,
    bookingReference: bookingReference.present
        ? bookingReference.value
        : this.bookingReference,
    notes: notes.present ? notes.value : this.notes,
  );
  Accommodation copyWithCompanion(AccommodationsCompanion data) {
    return Accommodation(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      name: data.name.present ? data.name.value : this.name,
      city: data.city.present ? data.city.value : this.city,
      checkIn: data.checkIn.present ? data.checkIn.value : this.checkIn,
      checkOut: data.checkOut.present ? data.checkOut.value : this.checkOut,
      cost: data.cost.present ? data.cost.value : this.cost,
      bookingReference: data.bookingReference.present
          ? data.bookingReference.value
          : this.bookingReference,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Accommodation(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('cost: $cost, ')
          ..write('bookingReference: $bookingReference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tripId,
    name,
    city,
    checkIn,
    checkOut,
    cost,
    bookingReference,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Accommodation &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.name == this.name &&
          other.city == this.city &&
          other.checkIn == this.checkIn &&
          other.checkOut == this.checkOut &&
          other.cost == this.cost &&
          other.bookingReference == this.bookingReference &&
          other.notes == this.notes);
}

class AccommodationsCompanion extends UpdateCompanion<Accommodation> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> name;
  final Value<String> city;
  final Value<DateTime> checkIn;
  final Value<DateTime> checkOut;
  final Value<double> cost;
  final Value<String?> bookingReference;
  final Value<String?> notes;
  const AccommodationsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.name = const Value.absent(),
    this.city = const Value.absent(),
    this.checkIn = const Value.absent(),
    this.checkOut = const Value.absent(),
    this.cost = const Value.absent(),
    this.bookingReference = const Value.absent(),
    this.notes = const Value.absent(),
  });
  AccommodationsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String name,
    required String city,
    required DateTime checkIn,
    required DateTime checkOut,
    this.cost = const Value.absent(),
    this.bookingReference = const Value.absent(),
    this.notes = const Value.absent(),
  }) : tripId = Value(tripId),
       name = Value(name),
       city = Value(city),
       checkIn = Value(checkIn),
       checkOut = Value(checkOut);
  static Insertable<Accommodation> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? name,
    Expression<String>? city,
    Expression<DateTime>? checkIn,
    Expression<DateTime>? checkOut,
    Expression<double>? cost,
    Expression<String>? bookingReference,
    Expression<String>? notes,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (name != null) 'name': name,
      if (city != null) 'city': city,
      if (checkIn != null) 'check_in': checkIn,
      if (checkOut != null) 'check_out': checkOut,
      if (cost != null) 'cost': cost,
      if (bookingReference != null) 'booking_reference': bookingReference,
      if (notes != null) 'notes': notes,
    });
  }

  AccommodationsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? name,
    Value<String>? city,
    Value<DateTime>? checkIn,
    Value<DateTime>? checkOut,
    Value<double>? cost,
    Value<String?>? bookingReference,
    Value<String?>? notes,
  }) {
    return AccommodationsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      name: name ?? this.name,
      city: city ?? this.city,
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      cost: cost ?? this.cost,
      bookingReference: bookingReference ?? this.bookingReference,
      notes: notes ?? this.notes,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (checkIn.present) {
      map['check_in'] = Variable<DateTime>(checkIn.value);
    }
    if (checkOut.present) {
      map['check_out'] = Variable<DateTime>(checkOut.value);
    }
    if (cost.present) {
      map['cost'] = Variable<double>(cost.value);
    }
    if (bookingReference.present) {
      map['booking_reference'] = Variable<String>(bookingReference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccommodationsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('checkIn: $checkIn, ')
          ..write('checkOut: $checkOut, ')
          ..write('cost: $cost, ')
          ..write('bookingReference: $bookingReference, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }
}

class $PackingItemsTable extends PackingItems
    with TableInfo<$PackingItemsTable, PackingItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PackingItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _tripIdMeta = const VerificationMeta('tripId');
  @override
  late final GeneratedColumn<int> tripId = GeneratedColumn<int>(
    'trip_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES trips (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isPackedMeta = const VerificationMeta(
    'isPacked',
  );
  @override
  late final GeneratedColumn<bool> isPacked = GeneratedColumn<bool>(
    'is_packed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_packed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, tripId, title, category, isPacked];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'packing_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PackingItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('trip_id')) {
      context.handle(
        _tripIdMeta,
        tripId.isAcceptableOrUnknown(data['trip_id']!, _tripIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tripIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_packed')) {
      context.handle(
        _isPackedMeta,
        isPacked.isAcceptableOrUnknown(data['is_packed']!, _isPackedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PackingItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PackingItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tripId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}trip_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isPacked: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_packed'],
      )!,
    );
  }

  @override
  $PackingItemsTable createAlias(String alias) {
    return $PackingItemsTable(attachedDatabase, alias);
  }
}

class PackingItem extends DataClass implements Insertable<PackingItem> {
  final int id;
  final int tripId;
  final String title;
  final String category;
  final bool isPacked;
  const PackingItem({
    required this.id,
    required this.tripId,
    required this.title,
    required this.category,
    required this.isPacked,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['trip_id'] = Variable<int>(tripId);
    map['title'] = Variable<String>(title);
    map['category'] = Variable<String>(category);
    map['is_packed'] = Variable<bool>(isPacked);
    return map;
  }

  PackingItemsCompanion toCompanion(bool nullToAbsent) {
    return PackingItemsCompanion(
      id: Value(id),
      tripId: Value(tripId),
      title: Value(title),
      category: Value(category),
      isPacked: Value(isPacked),
    );
  }

  factory PackingItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PackingItem(
      id: serializer.fromJson<int>(json['id']),
      tripId: serializer.fromJson<int>(json['tripId']),
      title: serializer.fromJson<String>(json['title']),
      category: serializer.fromJson<String>(json['category']),
      isPacked: serializer.fromJson<bool>(json['isPacked']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tripId': serializer.toJson<int>(tripId),
      'title': serializer.toJson<String>(title),
      'category': serializer.toJson<String>(category),
      'isPacked': serializer.toJson<bool>(isPacked),
    };
  }

  PackingItem copyWith({
    int? id,
    int? tripId,
    String? title,
    String? category,
    bool? isPacked,
  }) => PackingItem(
    id: id ?? this.id,
    tripId: tripId ?? this.tripId,
    title: title ?? this.title,
    category: category ?? this.category,
    isPacked: isPacked ?? this.isPacked,
  );
  PackingItem copyWithCompanion(PackingItemsCompanion data) {
    return PackingItem(
      id: data.id.present ? data.id.value : this.id,
      tripId: data.tripId.present ? data.tripId.value : this.tripId,
      title: data.title.present ? data.title.value : this.title,
      category: data.category.present ? data.category.value : this.category,
      isPacked: data.isPacked.present ? data.isPacked.value : this.isPacked,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PackingItem(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('isPacked: $isPacked')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tripId, title, category, isPacked);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PackingItem &&
          other.id == this.id &&
          other.tripId == this.tripId &&
          other.title == this.title &&
          other.category == this.category &&
          other.isPacked == this.isPacked);
}

class PackingItemsCompanion extends UpdateCompanion<PackingItem> {
  final Value<int> id;
  final Value<int> tripId;
  final Value<String> title;
  final Value<String> category;
  final Value<bool> isPacked;
  const PackingItemsCompanion({
    this.id = const Value.absent(),
    this.tripId = const Value.absent(),
    this.title = const Value.absent(),
    this.category = const Value.absent(),
    this.isPacked = const Value.absent(),
  });
  PackingItemsCompanion.insert({
    this.id = const Value.absent(),
    required int tripId,
    required String title,
    required String category,
    this.isPacked = const Value.absent(),
  }) : tripId = Value(tripId),
       title = Value(title),
       category = Value(category);
  static Insertable<PackingItem> custom({
    Expression<int>? id,
    Expression<int>? tripId,
    Expression<String>? title,
    Expression<String>? category,
    Expression<bool>? isPacked,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tripId != null) 'trip_id': tripId,
      if (title != null) 'title': title,
      if (category != null) 'category': category,
      if (isPacked != null) 'is_packed': isPacked,
    });
  }

  PackingItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? tripId,
    Value<String>? title,
    Value<String>? category,
    Value<bool>? isPacked,
  }) {
    return PackingItemsCompanion(
      id: id ?? this.id,
      tripId: tripId ?? this.tripId,
      title: title ?? this.title,
      category: category ?? this.category,
      isPacked: isPacked ?? this.isPacked,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tripId.present) {
      map['trip_id'] = Variable<int>(tripId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isPacked.present) {
      map['is_packed'] = Variable<bool>(isPacked.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PackingItemsCompanion(')
          ..write('id: $id, ')
          ..write('tripId: $tripId, ')
          ..write('title: $title, ')
          ..write('category: $category, ')
          ..write('isPacked: $isPacked')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $TripsTable trips = $TripsTable(this);
  late final $DestinationsTable destinations = $DestinationsTable(this);
  late final $ItineraryDaysTable itineraryDays = $ItineraryDaysTable(this);
  late final $ActivitiesTable activities = $ActivitiesTable(this);
  late final $BudgetCategoriesTable budgetCategories = $BudgetCategoriesTable(
    this,
  );
  late final $ExpensesTable expenses = $ExpensesTable(this);
  late final $TransportsTable transports = $TransportsTable(this);
  late final $AccommodationsTable accommodations = $AccommodationsTable(this);
  late final $PackingItemsTable packingItems = $PackingItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    trips,
    destinations,
    itineraryDays,
    activities,
    budgetCategories,
    expenses,
    transports,
    accommodations,
    packingItems,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('destinations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('itinerary_days', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'itinerary_days',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('activities', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('budget_categories', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('expenses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('transports', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('accommodations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'trips',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('packing_items', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$TripsTableCreateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      required String title,
      required DateTime startDate,
      required DateTime endDate,
      required String baseCurrency,
      Value<double> estimatedBudget,
      Value<String?> notes,
    });
typedef $$TripsTableUpdateCompanionBuilder =
    TripsCompanion Function({
      Value<int> id,
      Value<String> title,
      Value<DateTime> startDate,
      Value<DateTime> endDate,
      Value<String> baseCurrency,
      Value<double> estimatedBudget,
      Value<String?> notes,
    });

final class $$TripsTableReferences
    extends BaseReferences<_$AppDatabase, $TripsTable, Trip> {
  $$TripsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DestinationsTable, List<Destination>>
  _destinationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.destinations,
    aliasName: 'trips__id__destinations__trip_id',
  );

  $$DestinationsTableProcessedTableManager get destinationsRefs {
    final manager = $$DestinationsTableTableManager(
      $_db,
      $_db.destinations,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_destinationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ItineraryDaysTable, List<ItineraryDay>>
  _itineraryDaysRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itineraryDays,
    aliasName: 'trips__id__itinerary_days__trip_id',
  );

  $$ItineraryDaysTableProcessedTableManager get itineraryDaysRefs {
    final manager = $$ItineraryDaysTableTableManager(
      $_db,
      $_db.itineraryDays,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itineraryDaysRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$BudgetCategoriesTable, List<BudgetCategory>>
  _budgetCategoriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.budgetCategories,
    aliasName: 'trips__id__budget_categories__trip_id',
  );

  $$BudgetCategoriesTableProcessedTableManager get budgetCategoriesRefs {
    final manager = $$BudgetCategoriesTableTableManager(
      $_db,
      $_db.budgetCategories,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _budgetCategoriesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ExpensesTable, List<Expense>> _expensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.expenses,
    aliasName: 'trips__id__expenses__trip_id',
  );

  $$ExpensesTableProcessedTableManager get expensesRefs {
    final manager = $$ExpensesTableTableManager(
      $_db,
      $_db.expenses,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_expensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TransportsTable, List<Transport>>
  _transportsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.transports,
    aliasName: 'trips__id__transports__trip_id',
  );

  $$TransportsTableProcessedTableManager get transportsRefs {
    final manager = $$TransportsTableTableManager(
      $_db,
      $_db.transports,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_transportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$AccommodationsTable, List<Accommodation>>
  _accommodationsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.accommodations,
    aliasName: 'trips__id__accommodations__trip_id',
  );

  $$AccommodationsTableProcessedTableManager get accommodationsRefs {
    final manager = $$AccommodationsTableTableManager(
      $_db,
      $_db.accommodations,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_accommodationsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PackingItemsTable, List<PackingItem>>
  _packingItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.packingItems,
    aliasName: 'trips__id__packing_items__trip_id',
  );

  $$PackingItemsTableProcessedTableManager get packingItemsRefs {
    final manager = $$PackingItemsTableTableManager(
      $_db,
      $_db.packingItems,
    ).filter((f) => f.tripId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_packingItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TripsTableFilterComposer extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedBudget => $composableBuilder(
    column: $table.estimatedBudget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> destinationsRefs(
    Expression<bool> Function($$DestinationsTableFilterComposer f) f,
  ) {
    final $$DestinationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.destinations,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DestinationsTableFilterComposer(
            $db: $db,
            $table: $db.destinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> itineraryDaysRefs(
    Expression<bool> Function($$ItineraryDaysTableFilterComposer f) f,
  ) {
    final $$ItineraryDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itineraryDays,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItineraryDaysTableFilterComposer(
            $db: $db,
            $table: $db.itineraryDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> budgetCategoriesRefs(
    Expression<bool> Function($$BudgetCategoriesTableFilterComposer f) f,
  ) {
    final $$BudgetCategoriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableFilterComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> expensesRefs(
    Expression<bool> Function($$ExpensesTableFilterComposer f) f,
  ) {
    final $$ExpensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableFilterComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> transportsRefs(
    Expression<bool> Function($$TransportsTableFilterComposer f) f,
  ) {
    final $$TransportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transports,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransportsTableFilterComposer(
            $db: $db,
            $table: $db.transports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> accommodationsRefs(
    Expression<bool> Function($$AccommodationsTableFilterComposer f) f,
  ) {
    final $$AccommodationsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accommodations,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccommodationsTableFilterComposer(
            $db: $db,
            $table: $db.accommodations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> packingItemsRefs(
    Expression<bool> Function($$PackingItemsTableFilterComposer f) f,
  ) {
    final $$PackingItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packingItems,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackingItemsTableFilterComposer(
            $db: $db,
            $table: $db.packingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableOrderingComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
    column: $table.endDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedBudget => $composableBuilder(
    column: $table.estimatedBudget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TripsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TripsTable> {
  $$TripsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get baseCurrency => $composableBuilder(
    column: $table.baseCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<double> get estimatedBudget => $composableBuilder(
    column: $table.estimatedBudget,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  Expression<T> destinationsRefs<T extends Object>(
    Expression<T> Function($$DestinationsTableAnnotationComposer a) f,
  ) {
    final $$DestinationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.destinations,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DestinationsTableAnnotationComposer(
            $db: $db,
            $table: $db.destinations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> itineraryDaysRefs<T extends Object>(
    Expression<T> Function($$ItineraryDaysTableAnnotationComposer a) f,
  ) {
    final $$ItineraryDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itineraryDays,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItineraryDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.itineraryDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> budgetCategoriesRefs<T extends Object>(
    Expression<T> Function($$BudgetCategoriesTableAnnotationComposer a) f,
  ) {
    final $$BudgetCategoriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.budgetCategories,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BudgetCategoriesTableAnnotationComposer(
            $db: $db,
            $table: $db.budgetCategories,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> expensesRefs<T extends Object>(
    Expression<T> Function($$ExpensesTableAnnotationComposer a) f,
  ) {
    final $$ExpensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.expenses,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ExpensesTableAnnotationComposer(
            $db: $db,
            $table: $db.expenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> transportsRefs<T extends Object>(
    Expression<T> Function($$TransportsTableAnnotationComposer a) f,
  ) {
    final $$TransportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.transports,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TransportsTableAnnotationComposer(
            $db: $db,
            $table: $db.transports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> accommodationsRefs<T extends Object>(
    Expression<T> Function($$AccommodationsTableAnnotationComposer a) f,
  ) {
    final $$AccommodationsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.accommodations,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AccommodationsTableAnnotationComposer(
            $db: $db,
            $table: $db.accommodations,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> packingItemsRefs<T extends Object>(
    Expression<T> Function($$PackingItemsTableAnnotationComposer a) f,
  ) {
    final $$PackingItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.packingItems,
      getReferencedColumn: (t) => t.tripId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PackingItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.packingItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TripsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TripsTable,
          Trip,
          $$TripsTableFilterComposer,
          $$TripsTableOrderingComposer,
          $$TripsTableAnnotationComposer,
          $$TripsTableCreateCompanionBuilder,
          $$TripsTableUpdateCompanionBuilder,
          (Trip, $$TripsTableReferences),
          Trip,
          PrefetchHooks Function({
            bool destinationsRefs,
            bool itineraryDaysRefs,
            bool budgetCategoriesRefs,
            bool expensesRefs,
            bool transportsRefs,
            bool accommodationsRefs,
            bool packingItemsRefs,
          })
        > {
  $$TripsTableTableManager(_$AppDatabase db, $TripsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TripsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TripsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TripsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime> startDate = const Value.absent(),
                Value<DateTime> endDate = const Value.absent(),
                Value<String> baseCurrency = const Value.absent(),
                Value<double> estimatedBudget = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => TripsCompanion(
                id: id,
                title: title,
                startDate: startDate,
                endDate: endDate,
                baseCurrency: baseCurrency,
                estimatedBudget: estimatedBudget,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String title,
                required DateTime startDate,
                required DateTime endDate,
                required String baseCurrency,
                Value<double> estimatedBudget = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => TripsCompanion.insert(
                id: id,
                title: title,
                startDate: startDate,
                endDate: endDate,
                baseCurrency: baseCurrency,
                estimatedBudget: estimatedBudget,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TripsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                destinationsRefs = false,
                itineraryDaysRefs = false,
                budgetCategoriesRefs = false,
                expensesRefs = false,
                transportsRefs = false,
                accommodationsRefs = false,
                packingItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (destinationsRefs) db.destinations,
                    if (itineraryDaysRefs) db.itineraryDays,
                    if (budgetCategoriesRefs) db.budgetCategories,
                    if (expensesRefs) db.expenses,
                    if (transportsRefs) db.transports,
                    if (accommodationsRefs) db.accommodations,
                    if (packingItemsRefs) db.packingItems,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (destinationsRefs)
                        await $_getPrefetchedData<
                          Trip,
                          $TripsTable,
                          Destination
                        >(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._destinationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).destinationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (itineraryDaysRefs)
                        await $_getPrefetchedData<
                          Trip,
                          $TripsTable,
                          ItineraryDay
                        >(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._itineraryDaysRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).itineraryDaysRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (budgetCategoriesRefs)
                        await $_getPrefetchedData<
                          Trip,
                          $TripsTable,
                          BudgetCategory
                        >(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._budgetCategoriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).budgetCategoriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (expensesRefs)
                        await $_getPrefetchedData<Trip, $TripsTable, Expense>(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._expensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).expensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (transportsRefs)
                        await $_getPrefetchedData<Trip, $TripsTable, Transport>(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._transportsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).transportsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (accommodationsRefs)
                        await $_getPrefetchedData<
                          Trip,
                          $TripsTable,
                          Accommodation
                        >(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._accommodationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).accommodationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (packingItemsRefs)
                        await $_getPrefetchedData<
                          Trip,
                          $TripsTable,
                          PackingItem
                        >(
                          currentTable: table,
                          referencedTable: $$TripsTableReferences
                              ._packingItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TripsTableReferences(
                                db,
                                table,
                                p0,
                              ).packingItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tripId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$TripsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TripsTable,
      Trip,
      $$TripsTableFilterComposer,
      $$TripsTableOrderingComposer,
      $$TripsTableAnnotationComposer,
      $$TripsTableCreateCompanionBuilder,
      $$TripsTableUpdateCompanionBuilder,
      (Trip, $$TripsTableReferences),
      Trip,
      PrefetchHooks Function({
        bool destinationsRefs,
        bool itineraryDaysRefs,
        bool budgetCategoriesRefs,
        bool expensesRefs,
        bool transportsRefs,
        bool accommodationsRefs,
        bool packingItemsRefs,
      })
    >;
typedef $$DestinationsTableCreateCompanionBuilder =
    DestinationsCompanion Function({
      Value<int> id,
      required int tripId,
      required String country,
      required String city,
      Value<int> orderIndex,
    });
typedef $$DestinationsTableUpdateCompanionBuilder =
    DestinationsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> country,
      Value<String> city,
      Value<int> orderIndex,
    });

final class $$DestinationsTableReferences
    extends BaseReferences<_$AppDatabase, $DestinationsTable, Destination> {
  $$DestinationsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('destinations__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DestinationsTableFilterComposer
    extends Composer<_$AppDatabase, $DestinationsTable> {
  $$DestinationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DestinationsTableOrderingComposer
    extends Composer<_$AppDatabase, $DestinationsTable> {
  $$DestinationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DestinationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DestinationsTable> {
  $$DestinationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<int> get orderIndex => $composableBuilder(
    column: $table.orderIndex,
    builder: (column) => column,
  );

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DestinationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DestinationsTable,
          Destination,
          $$DestinationsTableFilterComposer,
          $$DestinationsTableOrderingComposer,
          $$DestinationsTableAnnotationComposer,
          $$DestinationsTableCreateCompanionBuilder,
          $$DestinationsTableUpdateCompanionBuilder,
          (Destination, $$DestinationsTableReferences),
          Destination,
          PrefetchHooks Function({bool tripId})
        > {
  $$DestinationsTableTableManager(_$AppDatabase db, $DestinationsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DestinationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DestinationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DestinationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> country = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<int> orderIndex = const Value.absent(),
              }) => DestinationsCompanion(
                id: id,
                tripId: tripId,
                country: country,
                city: city,
                orderIndex: orderIndex,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String country,
                required String city,
                Value<int> orderIndex = const Value.absent(),
              }) => DestinationsCompanion.insert(
                id: id,
                tripId: tripId,
                country: country,
                city: city,
                orderIndex: orderIndex,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DestinationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$DestinationsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$DestinationsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DestinationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DestinationsTable,
      Destination,
      $$DestinationsTableFilterComposer,
      $$DestinationsTableOrderingComposer,
      $$DestinationsTableAnnotationComposer,
      $$DestinationsTableCreateCompanionBuilder,
      $$DestinationsTableUpdateCompanionBuilder,
      (Destination, $$DestinationsTableReferences),
      Destination,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$ItineraryDaysTableCreateCompanionBuilder =
    ItineraryDaysCompanion Function({
      Value<int> id,
      required int tripId,
      required DateTime date,
      required String title,
      Value<String?> notes,
    });
typedef $$ItineraryDaysTableUpdateCompanionBuilder =
    ItineraryDaysCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<DateTime> date,
      Value<String> title,
      Value<String?> notes,
    });

final class $$ItineraryDaysTableReferences
    extends BaseReferences<_$AppDatabase, $ItineraryDaysTable, ItineraryDay> {
  $$ItineraryDaysTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('itinerary_days__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ActivitiesTable, List<Activity>>
  _activitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.activities,
    aliasName: 'itinerary_days__id__activities__itinerary_day_id',
  );

  $$ActivitiesTableProcessedTableManager get activitiesRefs {
    final manager = $$ActivitiesTableTableManager(
      $_db,
      $_db.activities,
    ).filter((f) => f.itineraryDayId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_activitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItineraryDaysTableFilterComposer
    extends Composer<_$AppDatabase, $ItineraryDaysTable> {
  $$ItineraryDaysTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> activitiesRefs(
    Expression<bool> Function($$ActivitiesTableFilterComposer f) f,
  ) {
    final $$ActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.itineraryDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItineraryDaysTableOrderingComposer
    extends Composer<_$AppDatabase, $ItineraryDaysTable> {
  $$ItineraryDaysTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItineraryDaysTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItineraryDaysTable> {
  $$ItineraryDaysTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> activitiesRefs<T extends Object>(
    Expression<T> Function($$ActivitiesTableAnnotationComposer a) f,
  ) {
    final $$ActivitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.activities,
      getReferencedColumn: (t) => t.itineraryDayId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ActivitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.activities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItineraryDaysTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItineraryDaysTable,
          ItineraryDay,
          $$ItineraryDaysTableFilterComposer,
          $$ItineraryDaysTableOrderingComposer,
          $$ItineraryDaysTableAnnotationComposer,
          $$ItineraryDaysTableCreateCompanionBuilder,
          $$ItineraryDaysTableUpdateCompanionBuilder,
          (ItineraryDay, $$ItineraryDaysTableReferences),
          ItineraryDay,
          PrefetchHooks Function({bool tripId, bool activitiesRefs})
        > {
  $$ItineraryDaysTableTableManager(_$AppDatabase db, $ItineraryDaysTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItineraryDaysTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItineraryDaysTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItineraryDaysTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ItineraryDaysCompanion(
                id: id,
                tripId: tripId,
                date: date,
                title: title,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required DateTime date,
                required String title,
                Value<String?> notes = const Value.absent(),
              }) => ItineraryDaysCompanion.insert(
                id: id,
                tripId: tripId,
                date: date,
                title: title,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItineraryDaysTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false, activitiesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (activitiesRefs) db.activities],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$ItineraryDaysTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$ItineraryDaysTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (activitiesRefs)
                    await $_getPrefetchedData<
                      ItineraryDay,
                      $ItineraryDaysTable,
                      Activity
                    >(
                      currentTable: table,
                      referencedTable: $$ItineraryDaysTableReferences
                          ._activitiesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ItineraryDaysTableReferences(
                            db,
                            table,
                            p0,
                          ).activitiesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.itineraryDayId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ItineraryDaysTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItineraryDaysTable,
      ItineraryDay,
      $$ItineraryDaysTableFilterComposer,
      $$ItineraryDaysTableOrderingComposer,
      $$ItineraryDaysTableAnnotationComposer,
      $$ItineraryDaysTableCreateCompanionBuilder,
      $$ItineraryDaysTableUpdateCompanionBuilder,
      (ItineraryDay, $$ItineraryDaysTableReferences),
      ItineraryDay,
      PrefetchHooks Function({bool tripId, bool activitiesRefs})
    >;
typedef $$ActivitiesTableCreateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      required int itineraryDayId,
      required String title,
      Value<String?> location,
      Value<DateTime?> time,
      Value<double?> estimatedCost,
      Value<String?> notes,
    });
typedef $$ActivitiesTableUpdateCompanionBuilder =
    ActivitiesCompanion Function({
      Value<int> id,
      Value<int> itineraryDayId,
      Value<String> title,
      Value<String?> location,
      Value<DateTime?> time,
      Value<double?> estimatedCost,
      Value<String?> notes,
    });

final class $$ActivitiesTableReferences
    extends BaseReferences<_$AppDatabase, $ActivitiesTable, Activity> {
  $$ActivitiesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ItineraryDaysTable _itineraryDayIdTable(_$AppDatabase db) => db
      .itineraryDays
      .createAlias('activities__itinerary_day_id__itinerary_days__id');

  $$ItineraryDaysTableProcessedTableManager get itineraryDayId {
    final $_column = $_itemColumn<int>('itinerary_day_id')!;

    final manager = $$ItineraryDaysTableTableManager(
      $_db,
      $_db.itineraryDays,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itineraryDayIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$ItineraryDaysTableFilterComposer get itineraryDayId {
    final $$ItineraryDaysTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itineraryDayId,
      referencedTable: $db.itineraryDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItineraryDaysTableFilterComposer(
            $db: $db,
            $table: $db.itineraryDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$ItineraryDaysTableOrderingComposer get itineraryDayId {
    final $$ItineraryDaysTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itineraryDayId,
      referencedTable: $db.itineraryDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItineraryDaysTableOrderingComposer(
            $db: $db,
            $table: $db.itineraryDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivitiesTable> {
  $$ActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<double> get estimatedCost => $composableBuilder(
    column: $table.estimatedCost,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$ItineraryDaysTableAnnotationComposer get itineraryDayId {
    final $$ItineraryDaysTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itineraryDayId,
      referencedTable: $db.itineraryDays,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItineraryDaysTableAnnotationComposer(
            $db: $db,
            $table: $db.itineraryDays,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivitiesTable,
          Activity,
          $$ActivitiesTableFilterComposer,
          $$ActivitiesTableOrderingComposer,
          $$ActivitiesTableAnnotationComposer,
          $$ActivitiesTableCreateCompanionBuilder,
          $$ActivitiesTableUpdateCompanionBuilder,
          (Activity, $$ActivitiesTableReferences),
          Activity,
          PrefetchHooks Function({bool itineraryDayId})
        > {
  $$ActivitiesTableTableManager(_$AppDatabase db, $ActivitiesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> itineraryDayId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> location = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ActivitiesCompanion(
                id: id,
                itineraryDayId: itineraryDayId,
                title: title,
                location: location,
                time: time,
                estimatedCost: estimatedCost,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int itineraryDayId,
                required String title,
                Value<String?> location = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<double?> estimatedCost = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => ActivitiesCompanion.insert(
                id: id,
                itineraryDayId: itineraryDayId,
                title: title,
                location: location,
                time: time,
                estimatedCost: estimatedCost,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itineraryDayId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itineraryDayId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itineraryDayId,
                                referencedTable: $$ActivitiesTableReferences
                                    ._itineraryDayIdTable(db),
                                referencedColumn: $$ActivitiesTableReferences
                                    ._itineraryDayIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivitiesTable,
      Activity,
      $$ActivitiesTableFilterComposer,
      $$ActivitiesTableOrderingComposer,
      $$ActivitiesTableAnnotationComposer,
      $$ActivitiesTableCreateCompanionBuilder,
      $$ActivitiesTableUpdateCompanionBuilder,
      (Activity, $$ActivitiesTableReferences),
      Activity,
      PrefetchHooks Function({bool itineraryDayId})
    >;
typedef $$BudgetCategoriesTableCreateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<int> id,
      required int tripId,
      required String category,
      Value<double> plannedAmount,
    });
typedef $$BudgetCategoriesTableUpdateCompanionBuilder =
    BudgetCategoriesCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> category,
      Value<double> plannedAmount,
    });

final class $$BudgetCategoriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $BudgetCategoriesTable, BudgetCategory> {
  $$BudgetCategoriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('budget_categories__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$BudgetCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BudgetCategoriesTable> {
  $$BudgetCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get plannedAmount => $composableBuilder(
    column: $table.plannedAmount,
    builder: (column) => column,
  );

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BudgetCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BudgetCategoriesTable,
          BudgetCategory,
          $$BudgetCategoriesTableFilterComposer,
          $$BudgetCategoriesTableOrderingComposer,
          $$BudgetCategoriesTableAnnotationComposer,
          $$BudgetCategoriesTableCreateCompanionBuilder,
          $$BudgetCategoriesTableUpdateCompanionBuilder,
          (BudgetCategory, $$BudgetCategoriesTableReferences),
          BudgetCategory,
          PrefetchHooks Function({bool tripId})
        > {
  $$BudgetCategoriesTableTableManager(
    _$AppDatabase db,
    $BudgetCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BudgetCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BudgetCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BudgetCategoriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> plannedAmount = const Value.absent(),
              }) => BudgetCategoriesCompanion(
                id: id,
                tripId: tripId,
                category: category,
                plannedAmount: plannedAmount,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String category,
                Value<double> plannedAmount = const Value.absent(),
              }) => BudgetCategoriesCompanion.insert(
                id: id,
                tripId: tripId,
                category: category,
                plannedAmount: plannedAmount,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BudgetCategoriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable:
                                    $$BudgetCategoriesTableReferences
                                        ._tripIdTable(db),
                                referencedColumn:
                                    $$BudgetCategoriesTableReferences
                                        ._tripIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$BudgetCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BudgetCategoriesTable,
      BudgetCategory,
      $$BudgetCategoriesTableFilterComposer,
      $$BudgetCategoriesTableOrderingComposer,
      $$BudgetCategoriesTableAnnotationComposer,
      $$BudgetCategoriesTableCreateCompanionBuilder,
      $$BudgetCategoriesTableUpdateCompanionBuilder,
      (BudgetCategory, $$BudgetCategoriesTableReferences),
      BudgetCategory,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$ExpensesTableCreateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      required int tripId,
      required String title,
      required String category,
      required double amount,
      required String currency,
      Value<double> exchangeRate,
      required DateTime date,
    });
typedef $$ExpensesTableUpdateCompanionBuilder =
    ExpensesCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> title,
      Value<String> category,
      Value<double> amount,
      Value<String> currency,
      Value<double> exchangeRate,
      Value<DateTime> date,
    });

final class $$ExpensesTableReferences
    extends BaseReferences<_$AppDatabase, $ExpensesTable, Expense> {
  $$ExpensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('expenses__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ExpensesTableFilterComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExpensesTable> {
  $$ExpensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<double> get exchangeRate => $composableBuilder(
    column: $table.exchangeRate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ExpensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExpensesTable,
          Expense,
          $$ExpensesTableFilterComposer,
          $$ExpensesTableOrderingComposer,
          $$ExpensesTableAnnotationComposer,
          $$ExpensesTableCreateCompanionBuilder,
          $$ExpensesTableUpdateCompanionBuilder,
          (Expense, $$ExpensesTableReferences),
          Expense,
          PrefetchHooks Function({bool tripId})
        > {
  $$ExpensesTableTableManager(_$AppDatabase db, $ExpensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExpensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExpensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExpensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<double> exchangeRate = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
              }) => ExpensesCompanion(
                id: id,
                tripId: tripId,
                title: title,
                category: category,
                amount: amount,
                currency: currency,
                exchangeRate: exchangeRate,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String title,
                required String category,
                required double amount,
                required String currency,
                Value<double> exchangeRate = const Value.absent(),
                required DateTime date,
              }) => ExpensesCompanion.insert(
                id: id,
                tripId: tripId,
                title: title,
                category: category,
                amount: amount,
                currency: currency,
                exchangeRate: exchangeRate,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ExpensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$ExpensesTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$ExpensesTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ExpensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExpensesTable,
      Expense,
      $$ExpensesTableFilterComposer,
      $$ExpensesTableOrderingComposer,
      $$ExpensesTableAnnotationComposer,
      $$ExpensesTableCreateCompanionBuilder,
      $$ExpensesTableUpdateCompanionBuilder,
      (Expense, $$ExpensesTableReferences),
      Expense,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$TransportsTableCreateCompanionBuilder =
    TransportsCompanion Function({
      Value<int> id,
      required int tripId,
      required String type,
      required String from,
      required String to,
      required DateTime departureDateTime,
      Value<DateTime?> arrivalDateTime,
      Value<double> cost,
      Value<String?> bookingReference,
      Value<String?> notes,
    });
typedef $$TransportsTableUpdateCompanionBuilder =
    TransportsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> type,
      Value<String> from,
      Value<String> to,
      Value<DateTime> departureDateTime,
      Value<DateTime?> arrivalDateTime,
      Value<double> cost,
      Value<String?> bookingReference,
      Value<String?> notes,
    });

final class $$TransportsTableReferences
    extends BaseReferences<_$AppDatabase, $TransportsTable, Transport> {
  $$TransportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('transports__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TransportsTableFilterComposer
    extends Composer<_$AppDatabase, $TransportsTable> {
  $$TransportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get departureDateTime => $composableBuilder(
    column: $table.departureDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get arrivalDateTime => $composableBuilder(
    column: $table.arrivalDateTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransportsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransportsTable> {
  $$TransportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get departureDateTime => $composableBuilder(
    column: $table.departureDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get arrivalDateTime => $composableBuilder(
    column: $table.arrivalDateTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransportsTable> {
  $$TransportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get from =>
      $composableBuilder(column: $table.from, builder: (column) => column);

  GeneratedColumn<String> get to =>
      $composableBuilder(column: $table.to, builder: (column) => column);

  GeneratedColumn<DateTime> get departureDateTime => $composableBuilder(
    column: $table.departureDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get arrivalDateTime => $composableBuilder(
    column: $table.arrivalDateTime,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TransportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TransportsTable,
          Transport,
          $$TransportsTableFilterComposer,
          $$TransportsTableOrderingComposer,
          $$TransportsTableAnnotationComposer,
          $$TransportsTableCreateCompanionBuilder,
          $$TransportsTableUpdateCompanionBuilder,
          (Transport, $$TransportsTableReferences),
          Transport,
          PrefetchHooks Function({bool tripId})
        > {
  $$TransportsTableTableManager(_$AppDatabase db, $TransportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> from = const Value.absent(),
                Value<String> to = const Value.absent(),
                Value<DateTime> departureDateTime = const Value.absent(),
                Value<DateTime?> arrivalDateTime = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<String?> bookingReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => TransportsCompanion(
                id: id,
                tripId: tripId,
                type: type,
                from: from,
                to: to,
                departureDateTime: departureDateTime,
                arrivalDateTime: arrivalDateTime,
                cost: cost,
                bookingReference: bookingReference,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String type,
                required String from,
                required String to,
                required DateTime departureDateTime,
                Value<DateTime?> arrivalDateTime = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<String?> bookingReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => TransportsCompanion.insert(
                id: id,
                tripId: tripId,
                type: type,
                from: from,
                to: to,
                departureDateTime: departureDateTime,
                arrivalDateTime: arrivalDateTime,
                cost: cost,
                bookingReference: bookingReference,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TransportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$TransportsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$TransportsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TransportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TransportsTable,
      Transport,
      $$TransportsTableFilterComposer,
      $$TransportsTableOrderingComposer,
      $$TransportsTableAnnotationComposer,
      $$TransportsTableCreateCompanionBuilder,
      $$TransportsTableUpdateCompanionBuilder,
      (Transport, $$TransportsTableReferences),
      Transport,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$AccommodationsTableCreateCompanionBuilder =
    AccommodationsCompanion Function({
      Value<int> id,
      required int tripId,
      required String name,
      required String city,
      required DateTime checkIn,
      required DateTime checkOut,
      Value<double> cost,
      Value<String?> bookingReference,
      Value<String?> notes,
    });
typedef $$AccommodationsTableUpdateCompanionBuilder =
    AccommodationsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> name,
      Value<String> city,
      Value<DateTime> checkIn,
      Value<DateTime> checkOut,
      Value<double> cost,
      Value<String?> bookingReference,
      Value<String?> notes,
    });

final class $$AccommodationsTableReferences
    extends BaseReferences<_$AppDatabase, $AccommodationsTable, Accommodation> {
  $$AccommodationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('accommodations__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$AccommodationsTableFilterComposer
    extends Composer<_$AppDatabase, $AccommodationsTable> {
  $$AccommodationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccommodationsTableOrderingComposer
    extends Composer<_$AppDatabase, $AccommodationsTable> {
  $$AccommodationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkIn => $composableBuilder(
    column: $table.checkIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get checkOut => $composableBuilder(
    column: $table.checkOut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cost => $composableBuilder(
    column: $table.cost,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccommodationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AccommodationsTable> {
  $$AccommodationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<DateTime> get checkIn =>
      $composableBuilder(column: $table.checkIn, builder: (column) => column);

  GeneratedColumn<DateTime> get checkOut =>
      $composableBuilder(column: $table.checkOut, builder: (column) => column);

  GeneratedColumn<double> get cost =>
      $composableBuilder(column: $table.cost, builder: (column) => column);

  GeneratedColumn<String> get bookingReference => $composableBuilder(
    column: $table.bookingReference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$AccommodationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AccommodationsTable,
          Accommodation,
          $$AccommodationsTableFilterComposer,
          $$AccommodationsTableOrderingComposer,
          $$AccommodationsTableAnnotationComposer,
          $$AccommodationsTableCreateCompanionBuilder,
          $$AccommodationsTableUpdateCompanionBuilder,
          (Accommodation, $$AccommodationsTableReferences),
          Accommodation,
          PrefetchHooks Function({bool tripId})
        > {
  $$AccommodationsTableTableManager(
    _$AppDatabase db,
    $AccommodationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AccommodationsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AccommodationsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AccommodationsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<DateTime> checkIn = const Value.absent(),
                Value<DateTime> checkOut = const Value.absent(),
                Value<double> cost = const Value.absent(),
                Value<String?> bookingReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => AccommodationsCompanion(
                id: id,
                tripId: tripId,
                name: name,
                city: city,
                checkIn: checkIn,
                checkOut: checkOut,
                cost: cost,
                bookingReference: bookingReference,
                notes: notes,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String name,
                required String city,
                required DateTime checkIn,
                required DateTime checkOut,
                Value<double> cost = const Value.absent(),
                Value<String?> bookingReference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
              }) => AccommodationsCompanion.insert(
                id: id,
                tripId: tripId,
                name: name,
                city: city,
                checkIn: checkIn,
                checkOut: checkOut,
                cost: cost,
                bookingReference: bookingReference,
                notes: notes,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AccommodationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$AccommodationsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn:
                                    $$AccommodationsTableReferences
                                        ._tripIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$AccommodationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AccommodationsTable,
      Accommodation,
      $$AccommodationsTableFilterComposer,
      $$AccommodationsTableOrderingComposer,
      $$AccommodationsTableAnnotationComposer,
      $$AccommodationsTableCreateCompanionBuilder,
      $$AccommodationsTableUpdateCompanionBuilder,
      (Accommodation, $$AccommodationsTableReferences),
      Accommodation,
      PrefetchHooks Function({bool tripId})
    >;
typedef $$PackingItemsTableCreateCompanionBuilder =
    PackingItemsCompanion Function({
      Value<int> id,
      required int tripId,
      required String title,
      required String category,
      Value<bool> isPacked,
    });
typedef $$PackingItemsTableUpdateCompanionBuilder =
    PackingItemsCompanion Function({
      Value<int> id,
      Value<int> tripId,
      Value<String> title,
      Value<String> category,
      Value<bool> isPacked,
    });

final class $$PackingItemsTableReferences
    extends BaseReferences<_$AppDatabase, $PackingItemsTable, PackingItem> {
  $$PackingItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TripsTable _tripIdTable(_$AppDatabase db) =>
      db.trips.createAlias('packing_items__trip_id__trips__id');

  $$TripsTableProcessedTableManager get tripId {
    final $_column = $_itemColumn<int>('trip_id')!;

    final manager = $$TripsTableTableManager(
      $_db,
      $_db.trips,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tripIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PackingItemsTableFilterComposer
    extends Composer<_$AppDatabase, $PackingItemsTable> {
  $$PackingItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isPacked => $composableBuilder(
    column: $table.isPacked,
    builder: (column) => ColumnFilters(column),
  );

  $$TripsTableFilterComposer get tripId {
    final $$TripsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableFilterComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackingItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $PackingItemsTable> {
  $$PackingItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPacked => $composableBuilder(
    column: $table.isPacked,
    builder: (column) => ColumnOrderings(column),
  );

  $$TripsTableOrderingComposer get tripId {
    final $$TripsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableOrderingComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackingItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PackingItemsTable> {
  $$PackingItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isPacked =>
      $composableBuilder(column: $table.isPacked, builder: (column) => column);

  $$TripsTableAnnotationComposer get tripId {
    final $$TripsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tripId,
      referencedTable: $db.trips,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TripsTableAnnotationComposer(
            $db: $db,
            $table: $db.trips,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PackingItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PackingItemsTable,
          PackingItem,
          $$PackingItemsTableFilterComposer,
          $$PackingItemsTableOrderingComposer,
          $$PackingItemsTableAnnotationComposer,
          $$PackingItemsTableCreateCompanionBuilder,
          $$PackingItemsTableUpdateCompanionBuilder,
          (PackingItem, $$PackingItemsTableReferences),
          PackingItem,
          PrefetchHooks Function({bool tripId})
        > {
  $$PackingItemsTableTableManager(_$AppDatabase db, $PackingItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PackingItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PackingItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PackingItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> tripId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isPacked = const Value.absent(),
              }) => PackingItemsCompanion(
                id: id,
                tripId: tripId,
                title: title,
                category: category,
                isPacked: isPacked,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int tripId,
                required String title,
                required String category,
                Value<bool> isPacked = const Value.absent(),
              }) => PackingItemsCompanion.insert(
                id: id,
                tripId: tripId,
                title: title,
                category: category,
                isPacked: isPacked,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PackingItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({tripId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (tripId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tripId,
                                referencedTable: $$PackingItemsTableReferences
                                    ._tripIdTable(db),
                                referencedColumn: $$PackingItemsTableReferences
                                    ._tripIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PackingItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PackingItemsTable,
      PackingItem,
      $$PackingItemsTableFilterComposer,
      $$PackingItemsTableOrderingComposer,
      $$PackingItemsTableAnnotationComposer,
      $$PackingItemsTableCreateCompanionBuilder,
      $$PackingItemsTableUpdateCompanionBuilder,
      (PackingItem, $$PackingItemsTableReferences),
      PackingItem,
      PrefetchHooks Function({bool tripId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$TripsTableTableManager get trips =>
      $$TripsTableTableManager(_db, _db.trips);
  $$DestinationsTableTableManager get destinations =>
      $$DestinationsTableTableManager(_db, _db.destinations);
  $$ItineraryDaysTableTableManager get itineraryDays =>
      $$ItineraryDaysTableTableManager(_db, _db.itineraryDays);
  $$ActivitiesTableTableManager get activities =>
      $$ActivitiesTableTableManager(_db, _db.activities);
  $$BudgetCategoriesTableTableManager get budgetCategories =>
      $$BudgetCategoriesTableTableManager(_db, _db.budgetCategories);
  $$ExpensesTableTableManager get expenses =>
      $$ExpensesTableTableManager(_db, _db.expenses);
  $$TransportsTableTableManager get transports =>
      $$TransportsTableTableManager(_db, _db.transports);
  $$AccommodationsTableTableManager get accommodations =>
      $$AccommodationsTableTableManager(_db, _db.accommodations);
  $$PackingItemsTableTableManager get packingItems =>
      $$PackingItemsTableTableManager(_db, _db.packingItems);
}
