// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserTable extends User with TableInfo<$UserTable, UserData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL UNIQUE',
  );
  static const VerificationMeta _passwordMeta = const VerificationMeta(
    'password',
  );
  @override
  late final GeneratedColumn<String> password = GeneratedColumn<String>(
    'password',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    $customConstraints: 'NOT NULL',
  );
  @override
  List<GeneratedColumn> get $columns => [id, email, password];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('password')) {
      context.handle(
        _passwordMeta,
        password.isAcceptableOrUnknown(data['password']!, _passwordMeta),
      );
    } else if (isInserting) {
      context.missing(_passwordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      password: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password'],
      )!,
    );
  }

  @override
  $UserTable createAlias(String alias) {
    return $UserTable(attachedDatabase, alias);
  }
}

class UserData extends DataClass implements Insertable<UserData> {
  final int id;
  final String email;
  final String password;
  const UserData({
    required this.id,
    required this.email,
    required this.password,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['email'] = Variable<String>(email);
    map['password'] = Variable<String>(password);
    return map;
  }

  UserCompanion toCompanion(bool nullToAbsent) {
    return UserCompanion(
      id: Value(id),
      email: Value(email),
      password: Value(password),
    );
  }

  factory UserData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserData(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      password: serializer.fromJson<String>(json['password']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String>(email),
      'password': serializer.toJson<String>(password),
    };
  }

  UserData copyWith({int? id, String? email, String? password}) => UserData(
    id: id ?? this.id,
    email: email ?? this.email,
    password: password ?? this.password,
  );
  UserData copyWithCompanion(UserCompanion data) {
    return UserData(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      password: data.password.present ? data.password.value : this.password,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserData(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, email, password);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserData &&
          other.id == this.id &&
          other.email == this.email &&
          other.password == this.password);
}

class UserCompanion extends UpdateCompanion<UserData> {
  final Value<int> id;
  final Value<String> email;
  final Value<String> password;
  const UserCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.password = const Value.absent(),
  });
  UserCompanion.insert({
    this.id = const Value.absent(),
    required String email,
    required String password,
  }) : email = Value(email),
       password = Value(password);
  static Insertable<UserData> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? password,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (password != null) 'password': password,
    });
  }

  UserCompanion copyWith({
    Value<int>? id,
    Value<String>? email,
    Value<String>? password,
  }) {
    return UserCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (password.present) {
      map['password'] = Variable<String>(password.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('password: $password')
          ..write(')'))
        .toString();
  }
}

class $CategoryTable extends Category
    with TableInfo<$CategoryTable, CategoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fromMeta = const VerificationMeta('from');
  @override
  late final GeneratedColumn<double> from = GeneratedColumn<double>(
    'from',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _toMeta = const VerificationMeta('to');
  @override
  late final GeneratedColumn<double> to = GeneratedColumn<double>(
    'to',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, from, to];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'category';
  @override
  VerificationContext validateIntegrity(
    Insertable<CategoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CategoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      from: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}from'],
      )!,
      to: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}to'],
      )!,
    );
  }

  @override
  $CategoryTable createAlias(String alias) {
    return $CategoryTable(attachedDatabase, alias);
  }
}

class CategoryData extends DataClass implements Insertable<CategoryData> {
  final int id;
  final String name;
  final double from;
  final double to;
  const CategoryData({
    required this.id,
    required this.name,
    required this.from,
    required this.to,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['from'] = Variable<double>(from);
    map['to'] = Variable<double>(to);
    return map;
  }

  CategoryCompanion toCompanion(bool nullToAbsent) {
    return CategoryCompanion(
      id: Value(id),
      name: Value(name),
      from: Value(from),
      to: Value(to),
    );
  }

  factory CategoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoryData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      from: serializer.fromJson<double>(json['from']),
      to: serializer.fromJson<double>(json['to']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'from': serializer.toJson<double>(from),
      'to': serializer.toJson<double>(to),
    };
  }

  CategoryData copyWith({int? id, String? name, double? from, double? to}) =>
      CategoryData(
        id: id ?? this.id,
        name: name ?? this.name,
        from: from ?? this.from,
        to: to ?? this.to,
      );
  CategoryData copyWithCompanion(CategoryCompanion data) {
    return CategoryData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      from: data.from.present ? data.from.value : this.from,
      to: data.to.present ? data.to.value : this.to,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CategoryData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('from: $from, ')
          ..write('to: $to')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, from, to);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoryData &&
          other.id == this.id &&
          other.name == this.name &&
          other.from == this.from &&
          other.to == this.to);
}

class CategoryCompanion extends UpdateCompanion<CategoryData> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> from;
  final Value<double> to;
  const CategoryCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.from = const Value.absent(),
    this.to = const Value.absent(),
  });
  CategoryCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required double from,
    required double to,
  }) : name = Value(name),
       from = Value(from),
       to = Value(to);
  static Insertable<CategoryData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? from,
    Expression<double>? to,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (from != null) 'from': from,
      if (to != null) 'to': to,
    });
  }

  CategoryCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? from,
    Value<double>? to,
  }) {
    return CategoryCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      from: from ?? this.from,
      to: to ?? this.to,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (from.present) {
      map['from'] = Variable<double>(from.value);
    }
    if (to.present) {
      map['to'] = Variable<double>(to.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoryCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('from: $from, ')
          ..write('to: $to')
          ..write(')'))
        .toString();
  }
}

class $BmiEntryTable extends BmiEntry
    with TableInfo<$BmiEntryTable, BmiEntryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BmiEntryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user (id)',
    ),
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
    'category_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES category (id)',
    ),
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<String> date = GeneratedColumn<String>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    categoryId,
    weight,
    height,
    value,
    date,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bmi_entry';
  @override
  VerificationContext validateIntegrity(
    Insertable<BmiEntryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
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
  BmiEntryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BmiEntryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}category_id'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date'],
      )!,
    );
  }

  @override
  $BmiEntryTable createAlias(String alias) {
    return $BmiEntryTable(attachedDatabase, alias);
  }
}

class BmiEntryData extends DataClass implements Insertable<BmiEntryData> {
  final int id;
  final int userId;
  final int categoryId;
  final double weight;
  final double height;
  final double value;
  final String date;
  const BmiEntryData({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.weight,
    required this.height,
    required this.value,
    required this.date,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['category_id'] = Variable<int>(categoryId);
    map['weight'] = Variable<double>(weight);
    map['height'] = Variable<double>(height);
    map['value'] = Variable<double>(value);
    map['date'] = Variable<String>(date);
    return map;
  }

  BmiEntryCompanion toCompanion(bool nullToAbsent) {
    return BmiEntryCompanion(
      id: Value(id),
      userId: Value(userId),
      categoryId: Value(categoryId),
      weight: Value(weight),
      height: Value(height),
      value: Value(value),
      date: Value(date),
    );
  }

  factory BmiEntryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BmiEntryData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      categoryId: serializer.fromJson<int>(json['categoryId']),
      weight: serializer.fromJson<double>(json['weight']),
      height: serializer.fromJson<double>(json['height']),
      value: serializer.fromJson<double>(json['value']),
      date: serializer.fromJson<String>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'categoryId': serializer.toJson<int>(categoryId),
      'weight': serializer.toJson<double>(weight),
      'height': serializer.toJson<double>(height),
      'value': serializer.toJson<double>(value),
      'date': serializer.toJson<String>(date),
    };
  }

  BmiEntryData copyWith({
    int? id,
    int? userId,
    int? categoryId,
    double? weight,
    double? height,
    double? value,
    String? date,
  }) => BmiEntryData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    categoryId: categoryId ?? this.categoryId,
    weight: weight ?? this.weight,
    height: height ?? this.height,
    value: value ?? this.value,
    date: date ?? this.date,
  );
  BmiEntryData copyWithCompanion(BmiEntryCompanion data) {
    return BmiEntryData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      weight: data.weight.present ? data.weight.value : this.weight,
      height: data.height.present ? data.height.value : this.height,
      value: data.value.present ? data.value.value : this.value,
      date: data.date.present ? data.date.value : this.date,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BmiEntryData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('value: $value, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, userId, categoryId, weight, height, value, date);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BmiEntryData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.categoryId == this.categoryId &&
          other.weight == this.weight &&
          other.height == this.height &&
          other.value == this.value &&
          other.date == this.date);
}

class BmiEntryCompanion extends UpdateCompanion<BmiEntryData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> categoryId;
  final Value<double> weight;
  final Value<double> height;
  final Value<double> value;
  final Value<String> date;
  const BmiEntryCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.weight = const Value.absent(),
    this.height = const Value.absent(),
    this.value = const Value.absent(),
    this.date = const Value.absent(),
  });
  BmiEntryCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int categoryId,
    required double weight,
    required double height,
    required double value,
    required String date,
  }) : userId = Value(userId),
       categoryId = Value(categoryId),
       weight = Value(weight),
       height = Value(height),
       value = Value(value),
       date = Value(date);
  static Insertable<BmiEntryData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? categoryId,
    Expression<double>? weight,
    Expression<double>? height,
    Expression<double>? value,
    Expression<String>? date,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (categoryId != null) 'category_id': categoryId,
      if (weight != null) 'weight': weight,
      if (height != null) 'height': height,
      if (value != null) 'value': value,
      if (date != null) 'date': date,
    });
  }

  BmiEntryCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? categoryId,
    Value<double>? weight,
    Value<double>? height,
    Value<double>? value,
    Value<String>? date,
  }) {
    return BmiEntryCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      categoryId: categoryId ?? this.categoryId,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      value: value ?? this.value,
      date: date ?? this.date,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (date.present) {
      map['date'] = Variable<String>(date.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BmiEntryCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('categoryId: $categoryId, ')
          ..write('weight: $weight, ')
          ..write('height: $height, ')
          ..write('value: $value, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }
}

class $GoalTable extends Goal with TableInfo<$GoalTable, GoalData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES user (id)',
    ),
  );
  static const VerificationMeta _targetBmiMeta = const VerificationMeta(
    'targetBmi',
  );
  @override
  late final GeneratedColumn<double> targetBmi = GeneratedColumn<double>(
    'target_bmi',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetCategoryMeta = const VerificationMeta(
    'targetCategory',
  );
  @override
  late final GeneratedColumn<int> targetCategory = GeneratedColumn<int>(
    'target_category',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES category (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, userId, targetBmi, targetCategory];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('target_bmi')) {
      context.handle(
        _targetBmiMeta,
        targetBmi.isAcceptableOrUnknown(data['target_bmi']!, _targetBmiMeta),
      );
    }
    if (data.containsKey('target_category')) {
      context.handle(
        _targetCategoryMeta,
        targetCategory.isAcceptableOrUnknown(
          data['target_category']!,
          _targetCategoryMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}user_id'],
      )!,
      targetBmi: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_bmi'],
      ),
      targetCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}target_category'],
      ),
    );
  }

  @override
  $GoalTable createAlias(String alias) {
    return $GoalTable(attachedDatabase, alias);
  }
}

class GoalData extends DataClass implements Insertable<GoalData> {
  final int id;
  final int userId;
  final double? targetBmi;
  final int? targetCategory;
  const GoalData({
    required this.id,
    required this.userId,
    this.targetBmi,
    this.targetCategory,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    if (!nullToAbsent || targetBmi != null) {
      map['target_bmi'] = Variable<double>(targetBmi);
    }
    if (!nullToAbsent || targetCategory != null) {
      map['target_category'] = Variable<int>(targetCategory);
    }
    return map;
  }

  GoalCompanion toCompanion(bool nullToAbsent) {
    return GoalCompanion(
      id: Value(id),
      userId: Value(userId),
      targetBmi: targetBmi == null && nullToAbsent
          ? const Value.absent()
          : Value(targetBmi),
      targetCategory: targetCategory == null && nullToAbsent
          ? const Value.absent()
          : Value(targetCategory),
    );
  }

  factory GoalData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      targetBmi: serializer.fromJson<double?>(json['targetBmi']),
      targetCategory: serializer.fromJson<int?>(json['targetCategory']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'targetBmi': serializer.toJson<double?>(targetBmi),
      'targetCategory': serializer.toJson<int?>(targetCategory),
    };
  }

  GoalData copyWith({
    int? id,
    int? userId,
    Value<double?> targetBmi = const Value.absent(),
    Value<int?> targetCategory = const Value.absent(),
  }) => GoalData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    targetBmi: targetBmi.present ? targetBmi.value : this.targetBmi,
    targetCategory: targetCategory.present
        ? targetCategory.value
        : this.targetCategory,
  );
  GoalData copyWithCompanion(GoalCompanion data) {
    return GoalData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      targetBmi: data.targetBmi.present ? data.targetBmi.value : this.targetBmi,
      targetCategory: data.targetCategory.present
          ? data.targetCategory.value
          : this.targetCategory,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('targetBmi: $targetBmi, ')
          ..write('targetCategory: $targetCategory')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, targetBmi, targetCategory);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.targetBmi == this.targetBmi &&
          other.targetCategory == this.targetCategory);
}

class GoalCompanion extends UpdateCompanion<GoalData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<double?> targetBmi;
  final Value<int?> targetCategory;
  const GoalCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.targetBmi = const Value.absent(),
    this.targetCategory = const Value.absent(),
  });
  GoalCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    this.targetBmi = const Value.absent(),
    this.targetCategory = const Value.absent(),
  }) : userId = Value(userId);
  static Insertable<GoalData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<double>? targetBmi,
    Expression<int>? targetCategory,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (targetBmi != null) 'target_bmi': targetBmi,
      if (targetCategory != null) 'target_category': targetCategory,
    });
  }

  GoalCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<double?>? targetBmi,
    Value<int?>? targetCategory,
  }) {
    return GoalCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      targetBmi: targetBmi ?? this.targetBmi,
      targetCategory: targetCategory ?? this.targetCategory,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (targetBmi.present) {
      map['target_bmi'] = Variable<double>(targetBmi.value);
    }
    if (targetCategory.present) {
      map['target_category'] = Variable<int>(targetCategory.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('targetBmi: $targetBmi, ')
          ..write('targetCategory: $targetCategory')
          ..write(')'))
        .toString();
  }
}

class $GoalAchievementTable extends GoalAchievement
    with TableInfo<$GoalAchievementTable, GoalAchievementData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalAchievementTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<int> goalId = GeneratedColumn<int>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goal (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<int> entryId = GeneratedColumn<int>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bmi_entry (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _achievementDateMeta = const VerificationMeta(
    'achievementDate',
  );
  @override
  late final GeneratedColumn<String> achievementDate = GeneratedColumn<String>(
    'achievement_date',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [goalId, entryId, achievementDate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_achievement';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalAchievementData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('achievement_date')) {
      context.handle(
        _achievementDateMeta,
        achievementDate.isAcceptableOrUnknown(
          data['achievement_date']!,
          _achievementDateMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_achievementDateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {goalId, entryId};
  @override
  GoalAchievementData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalAchievementData(
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}goal_id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}entry_id'],
      )!,
      achievementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}achievement_date'],
      )!,
    );
  }

  @override
  $GoalAchievementTable createAlias(String alias) {
    return $GoalAchievementTable(attachedDatabase, alias);
  }
}

class GoalAchievementData extends DataClass
    implements Insertable<GoalAchievementData> {
  final int goalId;
  final int entryId;
  final String achievementDate;
  const GoalAchievementData({
    required this.goalId,
    required this.entryId,
    required this.achievementDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['goal_id'] = Variable<int>(goalId);
    map['entry_id'] = Variable<int>(entryId);
    map['achievement_date'] = Variable<String>(achievementDate);
    return map;
  }

  GoalAchievementCompanion toCompanion(bool nullToAbsent) {
    return GoalAchievementCompanion(
      goalId: Value(goalId),
      entryId: Value(entryId),
      achievementDate: Value(achievementDate),
    );
  }

  factory GoalAchievementData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalAchievementData(
      goalId: serializer.fromJson<int>(json['goalId']),
      entryId: serializer.fromJson<int>(json['entryId']),
      achievementDate: serializer.fromJson<String>(json['achievementDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'goalId': serializer.toJson<int>(goalId),
      'entryId': serializer.toJson<int>(entryId),
      'achievementDate': serializer.toJson<String>(achievementDate),
    };
  }

  GoalAchievementData copyWith({
    int? goalId,
    int? entryId,
    String? achievementDate,
  }) => GoalAchievementData(
    goalId: goalId ?? this.goalId,
    entryId: entryId ?? this.entryId,
    achievementDate: achievementDate ?? this.achievementDate,
  );
  GoalAchievementData copyWithCompanion(GoalAchievementCompanion data) {
    return GoalAchievementData(
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      achievementDate: data.achievementDate.present
          ? data.achievementDate.value
          : this.achievementDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalAchievementData(')
          ..write('goalId: $goalId, ')
          ..write('entryId: $entryId, ')
          ..write('achievementDate: $achievementDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(goalId, entryId, achievementDate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalAchievementData &&
          other.goalId == this.goalId &&
          other.entryId == this.entryId &&
          other.achievementDate == this.achievementDate);
}

class GoalAchievementCompanion extends UpdateCompanion<GoalAchievementData> {
  final Value<int> goalId;
  final Value<int> entryId;
  final Value<String> achievementDate;
  final Value<int> rowid;
  const GoalAchievementCompanion({
    this.goalId = const Value.absent(),
    this.entryId = const Value.absent(),
    this.achievementDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalAchievementCompanion.insert({
    required int goalId,
    required int entryId,
    required String achievementDate,
    this.rowid = const Value.absent(),
  }) : goalId = Value(goalId),
       entryId = Value(entryId),
       achievementDate = Value(achievementDate);
  static Insertable<GoalAchievementData> custom({
    Expression<int>? goalId,
    Expression<int>? entryId,
    Expression<String>? achievementDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (goalId != null) 'goal_id': goalId,
      if (entryId != null) 'entry_id': entryId,
      if (achievementDate != null) 'achievement_date': achievementDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalAchievementCompanion copyWith({
    Value<int>? goalId,
    Value<int>? entryId,
    Value<String>? achievementDate,
    Value<int>? rowid,
  }) {
    return GoalAchievementCompanion(
      goalId: goalId ?? this.goalId,
      entryId: entryId ?? this.entryId,
      achievementDate: achievementDate ?? this.achievementDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (goalId.present) {
      map['goal_id'] = Variable<int>(goalId.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<int>(entryId.value);
    }
    if (achievementDate.present) {
      map['achievement_date'] = Variable<String>(achievementDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalAchievementCompanion(')
          ..write('goalId: $goalId, ')
          ..write('entryId: $entryId, ')
          ..write('achievementDate: $achievementDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserTable user = $UserTable(this);
  late final $CategoryTable category = $CategoryTable(this);
  late final $BmiEntryTable bmiEntry = $BmiEntryTable(this);
  late final $GoalTable goal = $GoalTable(this);
  late final $GoalAchievementTable goalAchievement = $GoalAchievementTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    user,
    category,
    bmiEntry,
    goal,
    goalAchievement,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goal',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goal_achievement', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'bmi_entry',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goal_achievement', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserTableCreateCompanionBuilder =
    UserCompanion Function({
      Value<int> id,
      required String email,
      required String password,
    });
typedef $$UserTableUpdateCompanionBuilder =
    UserCompanion Function({
      Value<int> id,
      Value<String> email,
      Value<String> password,
    });

final class $$UserTableReferences
    extends BaseReferences<_$AppDatabase, $UserTable, UserData> {
  $$UserTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BmiEntryTable, List<BmiEntryData>>
  _bmiEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bmiEntry,
    aliasName: $_aliasNameGenerator(db.user.id, db.bmiEntry.userId),
  );

  $$BmiEntryTableProcessedTableManager get bmiEntryRefs {
    final manager = $$BmiEntryTableTableManager(
      $_db,
      $_db.bmiEntry,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bmiEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalTable, List<GoalData>> _goalRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goal,
    aliasName: $_aliasNameGenerator(db.user.id, db.goal.userId),
  );

  $$GoalTableProcessedTableManager get goalRefs {
    final manager = $$GoalTableTableManager(
      $_db,
      $_db.goal,
    ).filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UserTableFilterComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableFilterComposer({
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

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bmiEntryRefs(
    Expression<bool> Function($$BmiEntryTableFilterComposer f) f,
  ) {
    final $$BmiEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableFilterComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalRefs(
    Expression<bool> Function($$GoalTableFilterComposer f) f,
  ) {
    final $$GoalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableFilterComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserTableOrderingComposer extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableOrderingComposer({
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

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get password => $composableBuilder(
    column: $table.password,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserTable> {
  $$UserTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get password =>
      $composableBuilder(column: $table.password, builder: (column) => column);

  Expression<T> bmiEntryRefs<T extends Object>(
    Expression<T> Function($$BmiEntryTableAnnotationComposer a) f,
  ) {
    final $$BmiEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalRefs<T extends Object>(
    Expression<T> Function($$GoalTableAnnotationComposer a) f,
  ) {
    final $$GoalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.userId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableAnnotationComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UserTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserTable,
          UserData,
          $$UserTableFilterComposer,
          $$UserTableOrderingComposer,
          $$UserTableAnnotationComposer,
          $$UserTableCreateCompanionBuilder,
          $$UserTableUpdateCompanionBuilder,
          (UserData, $$UserTableReferences),
          UserData,
          PrefetchHooks Function({bool bmiEntryRefs, bool goalRefs})
        > {
  $$UserTableTableManager(_$AppDatabase db, $UserTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> password = const Value.absent(),
              }) => UserCompanion(id: id, email: email, password: password),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String email,
                required String password,
              }) => UserCompanion.insert(
                id: id,
                email: email,
                password: password,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$UserTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({bmiEntryRefs = false, goalRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bmiEntryRefs) db.bmiEntry,
                if (goalRefs) db.goal,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bmiEntryRefs)
                    await $_getPrefetchedData<
                      UserData,
                      $UserTable,
                      BmiEntryData
                    >(
                      currentTable: table,
                      referencedTable: $$UserTableReferences._bmiEntryRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$UserTableReferences(db, table, p0).bmiEntryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                  if (goalRefs)
                    await $_getPrefetchedData<UserData, $UserTable, GoalData>(
                      currentTable: table,
                      referencedTable: $$UserTableReferences._goalRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$UserTableReferences(db, table, p0).goalRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.userId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$UserTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserTable,
      UserData,
      $$UserTableFilterComposer,
      $$UserTableOrderingComposer,
      $$UserTableAnnotationComposer,
      $$UserTableCreateCompanionBuilder,
      $$UserTableUpdateCompanionBuilder,
      (UserData, $$UserTableReferences),
      UserData,
      PrefetchHooks Function({bool bmiEntryRefs, bool goalRefs})
    >;
typedef $$CategoryTableCreateCompanionBuilder =
    CategoryCompanion Function({
      Value<int> id,
      required String name,
      required double from,
      required double to,
    });
typedef $$CategoryTableUpdateCompanionBuilder =
    CategoryCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> from,
      Value<double> to,
    });

final class $$CategoryTableReferences
    extends BaseReferences<_$AppDatabase, $CategoryTable, CategoryData> {
  $$CategoryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BmiEntryTable, List<BmiEntryData>>
  _bmiEntryRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bmiEntry,
    aliasName: $_aliasNameGenerator(db.category.id, db.bmiEntry.categoryId),
  );

  $$BmiEntryTableProcessedTableManager get bmiEntryRefs {
    final manager = $$BmiEntryTableTableManager(
      $_db,
      $_db.bmiEntry,
    ).filter((f) => f.categoryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_bmiEntryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalTable, List<GoalData>> _goalRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.goal,
    aliasName: $_aliasNameGenerator(db.category.id, db.goal.targetCategory),
  );

  $$GoalTableProcessedTableManager get goalRefs {
    final manager = $$GoalTableTableManager(
      $_db,
      $_db.goal,
    ).filter((f) => f.targetCategory.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoryTableFilterComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableFilterComposer({
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

  ColumnFilters<double> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bmiEntryRefs(
    Expression<bool> Function($$BmiEntryTableFilterComposer f) f,
  ) {
    final $$BmiEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableFilterComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalRefs(
    Expression<bool> Function($$GoalTableFilterComposer f) f,
  ) {
    final $$GoalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.targetCategory,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableFilterComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableOrderingComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableOrderingComposer({
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

  ColumnOrderings<double> get from => $composableBuilder(
    column: $table.from,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get to => $composableBuilder(
    column: $table.to,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $CategoryTable> {
  $$CategoryTableAnnotationComposer({
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

  GeneratedColumn<double> get from =>
      $composableBuilder(column: $table.from, builder: (column) => column);

  GeneratedColumn<double> get to =>
      $composableBuilder(column: $table.to, builder: (column) => column);

  Expression<T> bmiEntryRefs<T extends Object>(
    Expression<T> Function($$BmiEntryTableAnnotationComposer a) f,
  ) {
    final $$BmiEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.categoryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalRefs<T extends Object>(
    Expression<T> Function($$GoalTableAnnotationComposer a) f,
  ) {
    final $$GoalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.targetCategory,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableAnnotationComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CategoryTable,
          CategoryData,
          $$CategoryTableFilterComposer,
          $$CategoryTableOrderingComposer,
          $$CategoryTableAnnotationComposer,
          $$CategoryTableCreateCompanionBuilder,
          $$CategoryTableUpdateCompanionBuilder,
          (CategoryData, $$CategoryTableReferences),
          CategoryData,
          PrefetchHooks Function({bool bmiEntryRefs, bool goalRefs})
        > {
  $$CategoryTableTableManager(_$AppDatabase db, $CategoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> from = const Value.absent(),
                Value<double> to = const Value.absent(),
              }) => CategoryCompanion(id: id, name: name, from: from, to: to),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required double from,
                required double to,
              }) => CategoryCompanion.insert(
                id: id,
                name: name,
                from: from,
                to: to,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CategoryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({bmiEntryRefs = false, goalRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (bmiEntryRefs) db.bmiEntry,
                if (goalRefs) db.goal,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (bmiEntryRefs)
                    await $_getPrefetchedData<
                      CategoryData,
                      $CategoryTable,
                      BmiEntryData
                    >(
                      currentTable: table,
                      referencedTable: $$CategoryTableReferences
                          ._bmiEntryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoryTableReferences(db, table, p0).bmiEntryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.categoryId == item.id),
                      typedResults: items,
                    ),
                  if (goalRefs)
                    await $_getPrefetchedData<
                      CategoryData,
                      $CategoryTable,
                      GoalData
                    >(
                      currentTable: table,
                      referencedTable: $$CategoryTableReferences._goalRefsTable(
                        db,
                      ),
                      managerFromTypedResult: (p0) =>
                          $$CategoryTableReferences(db, table, p0).goalRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.targetCategory == item.id,
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

typedef $$CategoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CategoryTable,
      CategoryData,
      $$CategoryTableFilterComposer,
      $$CategoryTableOrderingComposer,
      $$CategoryTableAnnotationComposer,
      $$CategoryTableCreateCompanionBuilder,
      $$CategoryTableUpdateCompanionBuilder,
      (CategoryData, $$CategoryTableReferences),
      CategoryData,
      PrefetchHooks Function({bool bmiEntryRefs, bool goalRefs})
    >;
typedef $$BmiEntryTableCreateCompanionBuilder =
    BmiEntryCompanion Function({
      Value<int> id,
      required int userId,
      required int categoryId,
      required double weight,
      required double height,
      required double value,
      required String date,
    });
typedef $$BmiEntryTableUpdateCompanionBuilder =
    BmiEntryCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> categoryId,
      Value<double> weight,
      Value<double> height,
      Value<double> value,
      Value<String> date,
    });

final class $$BmiEntryTableReferences
    extends BaseReferences<_$AppDatabase, $BmiEntryTable, BmiEntryData> {
  $$BmiEntryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.bmiEntry.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserTableTableManager(
      $_db,
      $_db.user,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoryTable _categoryIdTable(_$AppDatabase db) =>
      db.category.createAlias(
        $_aliasNameGenerator(db.bmiEntry.categoryId, db.category.id),
      );

  $$CategoryTableProcessedTableManager get categoryId {
    final $_column = $_itemColumn<int>('category_id')!;

    final manager = $$CategoryTableTableManager(
      $_db,
      $_db.category,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$GoalAchievementTable, List<GoalAchievementData>>
  _goalAchievementRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.goalAchievement,
    aliasName: $_aliasNameGenerator(db.bmiEntry.id, db.goalAchievement.entryId),
  );

  $$GoalAchievementTableProcessedTableManager get goalAchievementRefs {
    final manager = $$GoalAchievementTableTableManager(
      $_db,
      $_db.goalAchievement,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalAchievementRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BmiEntryTableFilterComposer
    extends Composer<_$AppDatabase, $BmiEntryTable> {
  $$BmiEntryTableFilterComposer({
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

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableFilterComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableFilterComposer get categoryId {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableFilterComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> goalAchievementRefs(
    Expression<bool> Function($$GoalAchievementTableFilterComposer f) f,
  ) {
    final $$GoalAchievementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalAchievement,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalAchievementTableFilterComposer(
            $db: $db,
            $table: $db.goalAchievement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BmiEntryTableOrderingComposer
    extends Composer<_$AppDatabase, $BmiEntryTable> {
  $$BmiEntryTableOrderingComposer({
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

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableOrderingComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableOrderingComposer get categoryId {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableOrderingComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BmiEntryTableAnnotationComposer
    extends Composer<_$AppDatabase, $BmiEntryTable> {
  $$BmiEntryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableAnnotationComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableAnnotationComposer get categoryId {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoryId,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableAnnotationComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> goalAchievementRefs<T extends Object>(
    Expression<T> Function($$GoalAchievementTableAnnotationComposer a) f,
  ) {
    final $$GoalAchievementTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalAchievement,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalAchievementTableAnnotationComposer(
            $db: $db,
            $table: $db.goalAchievement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BmiEntryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BmiEntryTable,
          BmiEntryData,
          $$BmiEntryTableFilterComposer,
          $$BmiEntryTableOrderingComposer,
          $$BmiEntryTableAnnotationComposer,
          $$BmiEntryTableCreateCompanionBuilder,
          $$BmiEntryTableUpdateCompanionBuilder,
          (BmiEntryData, $$BmiEntryTableReferences),
          BmiEntryData,
          PrefetchHooks Function({
            bool userId,
            bool categoryId,
            bool goalAchievementRefs,
          })
        > {
  $$BmiEntryTableTableManager(_$AppDatabase db, $BmiEntryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BmiEntryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BmiEntryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BmiEntryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> categoryId = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double> height = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> date = const Value.absent(),
              }) => BmiEntryCompanion(
                id: id,
                userId: userId,
                categoryId: categoryId,
                weight: weight,
                height: height,
                value: value,
                date: date,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int categoryId,
                required double weight,
                required double height,
                required double value,
                required String date,
              }) => BmiEntryCompanion.insert(
                id: id,
                userId: userId,
                categoryId: categoryId,
                weight: weight,
                height: height,
                value: value,
                date: date,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$BmiEntryTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                categoryId = false,
                goalAchievementRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (goalAchievementRefs) db.goalAchievement,
                  ],
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$BmiEntryTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$BmiEntryTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (categoryId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.categoryId,
                                    referencedTable: $$BmiEntryTableReferences
                                        ._categoryIdTable(db),
                                    referencedColumn: $$BmiEntryTableReferences
                                        ._categoryIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (goalAchievementRefs)
                        await $_getPrefetchedData<
                          BmiEntryData,
                          $BmiEntryTable,
                          GoalAchievementData
                        >(
                          currentTable: table,
                          referencedTable: $$BmiEntryTableReferences
                              ._goalAchievementRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BmiEntryTableReferences(
                                db,
                                table,
                                p0,
                              ).goalAchievementRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
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

typedef $$BmiEntryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BmiEntryTable,
      BmiEntryData,
      $$BmiEntryTableFilterComposer,
      $$BmiEntryTableOrderingComposer,
      $$BmiEntryTableAnnotationComposer,
      $$BmiEntryTableCreateCompanionBuilder,
      $$BmiEntryTableUpdateCompanionBuilder,
      (BmiEntryData, $$BmiEntryTableReferences),
      BmiEntryData,
      PrefetchHooks Function({
        bool userId,
        bool categoryId,
        bool goalAchievementRefs,
      })
    >;
typedef $$GoalTableCreateCompanionBuilder =
    GoalCompanion Function({
      Value<int> id,
      required int userId,
      Value<double?> targetBmi,
      Value<int?> targetCategory,
    });
typedef $$GoalTableUpdateCompanionBuilder =
    GoalCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<double?> targetBmi,
      Value<int?> targetCategory,
    });

final class $$GoalTableReferences
    extends BaseReferences<_$AppDatabase, $GoalTable, GoalData> {
  $$GoalTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UserTable _userIdTable(_$AppDatabase db) =>
      db.user.createAlias($_aliasNameGenerator(db.goal.userId, db.user.id));

  $$UserTableProcessedTableManager get userId {
    final $_column = $_itemColumn<int>('user_id')!;

    final manager = $$UserTableTableManager(
      $_db,
      $_db.user,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CategoryTable _targetCategoryTable(_$AppDatabase db) =>
      db.category.createAlias(
        $_aliasNameGenerator(db.goal.targetCategory, db.category.id),
      );

  $$CategoryTableProcessedTableManager? get targetCategory {
    final $_column = $_itemColumn<int>('target_category');
    if ($_column == null) return null;
    final manager = $$CategoryTableTableManager(
      $_db,
      $_db.category,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_targetCategoryTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$GoalAchievementTable, List<GoalAchievementData>>
  _goalAchievementRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.goalAchievement,
    aliasName: $_aliasNameGenerator(db.goal.id, db.goalAchievement.goalId),
  );

  $$GoalAchievementTableProcessedTableManager get goalAchievementRefs {
    final manager = $$GoalAchievementTableTableManager(
      $_db,
      $_db.goalAchievement,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalAchievementRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalTableFilterComposer extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableFilterComposer({
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

  ColumnFilters<double> get targetBmi => $composableBuilder(
    column: $table.targetBmi,
    builder: (column) => ColumnFilters(column),
  );

  $$UserTableFilterComposer get userId {
    final $$UserTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableFilterComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableFilterComposer get targetCategory {
    final $$CategoryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCategory,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableFilterComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> goalAchievementRefs(
    Expression<bool> Function($$GoalAchievementTableFilterComposer f) f,
  ) {
    final $$GoalAchievementTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalAchievement,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalAchievementTableFilterComposer(
            $db: $db,
            $table: $db.goalAchievement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalTableOrderingComposer extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableOrderingComposer({
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

  ColumnOrderings<double> get targetBmi => $composableBuilder(
    column: $table.targetBmi,
    builder: (column) => ColumnOrderings(column),
  );

  $$UserTableOrderingComposer get userId {
    final $$UserTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableOrderingComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableOrderingComposer get targetCategory {
    final $$CategoryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCategory,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableOrderingComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalTable> {
  $$GoalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get targetBmi =>
      $composableBuilder(column: $table.targetBmi, builder: (column) => column);

  $$UserTableAnnotationComposer get userId {
    final $$UserTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.userId,
      referencedTable: $db.user,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserTableAnnotationComposer(
            $db: $db,
            $table: $db.user,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CategoryTableAnnotationComposer get targetCategory {
    final $$CategoryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.targetCategory,
      referencedTable: $db.category,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoryTableAnnotationComposer(
            $db: $db,
            $table: $db.category,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> goalAchievementRefs<T extends Object>(
    Expression<T> Function($$GoalAchievementTableAnnotationComposer a) f,
  ) {
    final $$GoalAchievementTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalAchievement,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalAchievementTableAnnotationComposer(
            $db: $db,
            $table: $db.goalAchievement,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalTable,
          GoalData,
          $$GoalTableFilterComposer,
          $$GoalTableOrderingComposer,
          $$GoalTableAnnotationComposer,
          $$GoalTableCreateCompanionBuilder,
          $$GoalTableUpdateCompanionBuilder,
          (GoalData, $$GoalTableReferences),
          GoalData,
          PrefetchHooks Function({
            bool userId,
            bool targetCategory,
            bool goalAchievementRefs,
          })
        > {
  $$GoalTableTableManager(_$AppDatabase db, $GoalTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<double?> targetBmi = const Value.absent(),
                Value<int?> targetCategory = const Value.absent(),
              }) => GoalCompanion(
                id: id,
                userId: userId,
                targetBmi: targetBmi,
                targetCategory: targetCategory,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                Value<double?> targetBmi = const Value.absent(),
                Value<int?> targetCategory = const Value.absent(),
              }) => GoalCompanion.insert(
                id: id,
                userId: userId,
                targetBmi: targetBmi,
                targetCategory: targetCategory,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GoalTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                userId = false,
                targetCategory = false,
                goalAchievementRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (goalAchievementRefs) db.goalAchievement,
                  ],
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
                        if (userId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.userId,
                                    referencedTable: $$GoalTableReferences
                                        ._userIdTable(db),
                                    referencedColumn: $$GoalTableReferences
                                        ._userIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (targetCategory) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.targetCategory,
                                    referencedTable: $$GoalTableReferences
                                        ._targetCategoryTable(db),
                                    referencedColumn: $$GoalTableReferences
                                        ._targetCategoryTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (goalAchievementRefs)
                        await $_getPrefetchedData<
                          GoalData,
                          $GoalTable,
                          GoalAchievementData
                        >(
                          currentTable: table,
                          referencedTable: $$GoalTableReferences
                              ._goalAchievementRefsTable(db),
                          managerFromTypedResult: (p0) => $$GoalTableReferences(
                            db,
                            table,
                            p0,
                          ).goalAchievementRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
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

typedef $$GoalTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalTable,
      GoalData,
      $$GoalTableFilterComposer,
      $$GoalTableOrderingComposer,
      $$GoalTableAnnotationComposer,
      $$GoalTableCreateCompanionBuilder,
      $$GoalTableUpdateCompanionBuilder,
      (GoalData, $$GoalTableReferences),
      GoalData,
      PrefetchHooks Function({
        bool userId,
        bool targetCategory,
        bool goalAchievementRefs,
      })
    >;
typedef $$GoalAchievementTableCreateCompanionBuilder =
    GoalAchievementCompanion Function({
      required int goalId,
      required int entryId,
      required String achievementDate,
      Value<int> rowid,
    });
typedef $$GoalAchievementTableUpdateCompanionBuilder =
    GoalAchievementCompanion Function({
      Value<int> goalId,
      Value<int> entryId,
      Value<String> achievementDate,
      Value<int> rowid,
    });

final class $$GoalAchievementTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GoalAchievementTable,
          GoalAchievementData
        > {
  $$GoalAchievementTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalTable _goalIdTable(_$AppDatabase db) => db.goal.createAlias(
    $_aliasNameGenerator(db.goalAchievement.goalId, db.goal.id),
  );

  $$GoalTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<int>('goal_id')!;

    final manager = $$GoalTableTableManager(
      $_db,
      $_db.goal,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BmiEntryTable _entryIdTable(_$AppDatabase db) =>
      db.bmiEntry.createAlias(
        $_aliasNameGenerator(db.goalAchievement.entryId, db.bmiEntry.id),
      );

  $$BmiEntryTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<int>('entry_id')!;

    final manager = $$BmiEntryTableTableManager(
      $_db,
      $_db.bmiEntry,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalAchievementTableFilterComposer
    extends Composer<_$AppDatabase, $GoalAchievementTable> {
  $$GoalAchievementTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get achievementDate => $composableBuilder(
    column: $table.achievementDate,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalTableFilterComposer get goalId {
    final $$GoalTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableFilterComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BmiEntryTableFilterComposer get entryId {
    final $$BmiEntryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableFilterComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalAchievementTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalAchievementTable> {
  $$GoalAchievementTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get achievementDate => $composableBuilder(
    column: $table.achievementDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalTableOrderingComposer get goalId {
    final $$GoalTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableOrderingComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BmiEntryTableOrderingComposer get entryId {
    final $$BmiEntryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableOrderingComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalAchievementTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalAchievementTable> {
  $$GoalAchievementTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get achievementDate => $composableBuilder(
    column: $table.achievementDate,
    builder: (column) => column,
  );

  $$GoalTableAnnotationComposer get goalId {
    final $$GoalTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goal,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalTableAnnotationComposer(
            $db: $db,
            $table: $db.goal,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BmiEntryTableAnnotationComposer get entryId {
    final $$BmiEntryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.bmiEntry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BmiEntryTableAnnotationComposer(
            $db: $db,
            $table: $db.bmiEntry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalAchievementTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalAchievementTable,
          GoalAchievementData,
          $$GoalAchievementTableFilterComposer,
          $$GoalAchievementTableOrderingComposer,
          $$GoalAchievementTableAnnotationComposer,
          $$GoalAchievementTableCreateCompanionBuilder,
          $$GoalAchievementTableUpdateCompanionBuilder,
          (GoalAchievementData, $$GoalAchievementTableReferences),
          GoalAchievementData,
          PrefetchHooks Function({bool goalId, bool entryId})
        > {
  $$GoalAchievementTableTableManager(
    _$AppDatabase db,
    $GoalAchievementTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalAchievementTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalAchievementTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalAchievementTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> goalId = const Value.absent(),
                Value<int> entryId = const Value.absent(),
                Value<String> achievementDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalAchievementCompanion(
                goalId: goalId,
                entryId: entryId,
                achievementDate: achievementDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int goalId,
                required int entryId,
                required String achievementDate,
                Value<int> rowid = const Value.absent(),
              }) => GoalAchievementCompanion.insert(
                goalId: goalId,
                entryId: entryId,
                achievementDate: achievementDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GoalAchievementTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false, entryId = false}) {
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
                    if (goalId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.goalId,
                                referencedTable:
                                    $$GoalAchievementTableReferences
                                        ._goalIdTable(db),
                                referencedColumn:
                                    $$GoalAchievementTableReferences
                                        ._goalIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable:
                                    $$GoalAchievementTableReferences
                                        ._entryIdTable(db),
                                referencedColumn:
                                    $$GoalAchievementTableReferences
                                        ._entryIdTable(db)
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

typedef $$GoalAchievementTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalAchievementTable,
      GoalAchievementData,
      $$GoalAchievementTableFilterComposer,
      $$GoalAchievementTableOrderingComposer,
      $$GoalAchievementTableAnnotationComposer,
      $$GoalAchievementTableCreateCompanionBuilder,
      $$GoalAchievementTableUpdateCompanionBuilder,
      (GoalAchievementData, $$GoalAchievementTableReferences),
      GoalAchievementData,
      PrefetchHooks Function({bool goalId, bool entryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserTableTableManager get user => $$UserTableTableManager(_db, _db.user);
  $$CategoryTableTableManager get category =>
      $$CategoryTableTableManager(_db, _db.category);
  $$BmiEntryTableTableManager get bmiEntry =>
      $$BmiEntryTableTableManager(_db, _db.bmiEntry);
  $$GoalTableTableManager get goal => $$GoalTableTableManager(_db, _db.goal);
  $$GoalAchievementTableTableManager get goalAchievement =>
      $$GoalAchievementTableTableManager(_db, _db.goalAchievement);
}
