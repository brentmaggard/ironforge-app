// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  );
  static const VerificationMeta _firstNameMeta = const VerificationMeta(
    'firstName',
  );
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
    'first_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastNameMeta = const VerificationMeta(
    'lastName',
  );
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
    'last_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dateOfBirthMeta = const VerificationMeta(
    'dateOfBirth',
  );
  @override
  late final GeneratedColumn<DateTime> dateOfBirth = GeneratedColumn<DateTime>(
    'date_of_birth',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
    'gender',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
    'height',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
    'weight',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _experienceLevelMeta = const VerificationMeta(
    'experienceLevel',
  );
  @override
  late final GeneratedColumn<String> experienceLevel = GeneratedColumn<String>(
    'experience_level',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('beginner'),
  );
  static const VerificationMeta _preferencesMeta = const VerificationMeta(
    'preferences',
  );
  @override
  late final GeneratedColumn<String> preferences = GeneratedColumn<String>(
    'preferences',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    firstName,
    lastName,
    dateOfBirth,
    gender,
    height,
    weight,
    experienceLevel,
    preferences,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('first_name')) {
      context.handle(
        _firstNameMeta,
        firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta),
      );
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(
        _lastNameMeta,
        lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta),
      );
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('date_of_birth')) {
      context.handle(
        _dateOfBirthMeta,
        dateOfBirth.isAcceptableOrUnknown(
          data['date_of_birth']!,
          _dateOfBirthMeta,
        ),
      );
    }
    if (data.containsKey('gender')) {
      context.handle(
        _genderMeta,
        gender.isAcceptableOrUnknown(data['gender']!, _genderMeta),
      );
    }
    if (data.containsKey('height')) {
      context.handle(
        _heightMeta,
        height.isAcceptableOrUnknown(data['height']!, _heightMeta),
      );
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    }
    if (data.containsKey('experience_level')) {
      context.handle(
        _experienceLevelMeta,
        experienceLevel.isAcceptableOrUnknown(
          data['experience_level']!,
          _experienceLevelMeta,
        ),
      );
    }
    if (data.containsKey('preferences')) {
      context.handle(
        _preferencesMeta,
        preferences.isAcceptableOrUnknown(
          data['preferences']!,
          _preferencesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      firstName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}first_name'],
      )!,
      lastName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_name'],
      )!,
      dateOfBirth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_of_birth'],
      ),
      gender: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gender'],
      ),
      height: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height'],
      ),
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      ),
      experienceLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}experience_level'],
      )!,
      preferences: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}preferences'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime? dateOfBirth;
  final String? gender;
  final double? height;
  final double? weight;
  final String experienceLevel;
  final String? preferences;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.dateOfBirth,
    this.gender,
    this.height,
    this.weight,
    required this.experienceLevel,
    this.preferences,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['email'] = Variable<String>(email);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || dateOfBirth != null) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    if (!nullToAbsent || height != null) {
      map['height'] = Variable<double>(height);
    }
    if (!nullToAbsent || weight != null) {
      map['weight'] = Variable<double>(weight);
    }
    map['experience_level'] = Variable<String>(experienceLevel);
    if (!nullToAbsent || preferences != null) {
      map['preferences'] = Variable<String>(preferences);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      email: Value(email),
      firstName: Value(firstName),
      lastName: Value(lastName),
      dateOfBirth: dateOfBirth == null && nullToAbsent
          ? const Value.absent()
          : Value(dateOfBirth),
      gender: gender == null && nullToAbsent
          ? const Value.absent()
          : Value(gender),
      height: height == null && nullToAbsent
          ? const Value.absent()
          : Value(height),
      weight: weight == null && nullToAbsent
          ? const Value.absent()
          : Value(weight),
      experienceLevel: Value(experienceLevel),
      preferences: preferences == null && nullToAbsent
          ? const Value.absent()
          : Value(preferences),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<String>(json['id']),
      email: serializer.fromJson<String>(json['email']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      dateOfBirth: serializer.fromJson<DateTime?>(json['dateOfBirth']),
      gender: serializer.fromJson<String?>(json['gender']),
      height: serializer.fromJson<double?>(json['height']),
      weight: serializer.fromJson<double?>(json['weight']),
      experienceLevel: serializer.fromJson<String>(json['experienceLevel']),
      preferences: serializer.fromJson<String?>(json['preferences']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'email': serializer.toJson<String>(email),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'dateOfBirth': serializer.toJson<DateTime?>(dateOfBirth),
      'gender': serializer.toJson<String?>(gender),
      'height': serializer.toJson<double?>(height),
      'weight': serializer.toJson<double?>(weight),
      'experienceLevel': serializer.toJson<String>(experienceLevel),
      'preferences': serializer.toJson<String?>(preferences),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  User copyWith({
    String? id,
    String? email,
    String? firstName,
    String? lastName,
    Value<DateTime?> dateOfBirth = const Value.absent(),
    Value<String?> gender = const Value.absent(),
    Value<double?> height = const Value.absent(),
    Value<double?> weight = const Value.absent(),
    String? experienceLevel,
    Value<String?> preferences = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => User(
    id: id ?? this.id,
    email: email ?? this.email,
    firstName: firstName ?? this.firstName,
    lastName: lastName ?? this.lastName,
    dateOfBirth: dateOfBirth.present ? dateOfBirth.value : this.dateOfBirth,
    gender: gender.present ? gender.value : this.gender,
    height: height.present ? height.value : this.height,
    weight: weight.present ? weight.value : this.weight,
    experienceLevel: experienceLevel ?? this.experienceLevel,
    preferences: preferences.present ? preferences.value : this.preferences,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      dateOfBirth: data.dateOfBirth.present
          ? data.dateOfBirth.value
          : this.dateOfBirth,
      gender: data.gender.present ? data.gender.value : this.gender,
      height: data.height.present ? data.height.value : this.height,
      weight: data.weight.present ? data.weight.value : this.weight,
      experienceLevel: data.experienceLevel.present
          ? data.experienceLevel.value
          : this.experienceLevel,
      preferences: data.preferences.present
          ? data.preferences.value
          : this.preferences,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('preferences: $preferences, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    firstName,
    lastName,
    dateOfBirth,
    gender,
    height,
    weight,
    experienceLevel,
    preferences,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.email == this.email &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.dateOfBirth == this.dateOfBirth &&
          other.gender == this.gender &&
          other.height == this.height &&
          other.weight == this.weight &&
          other.experienceLevel == this.experienceLevel &&
          other.preferences == this.preferences &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<String> id;
  final Value<String> email;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<DateTime?> dateOfBirth;
  final Value<String?> gender;
  final Value<double?> height;
  final Value<double?> weight;
  final Value<String> experienceLevel;
  final Value<String?> preferences;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.experienceLevel = const Value.absent(),
    this.preferences = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsersCompanion.insert({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    this.dateOfBirth = const Value.absent(),
    this.gender = const Value.absent(),
    this.height = const Value.absent(),
    this.weight = const Value.absent(),
    this.experienceLevel = const Value.absent(),
    this.preferences = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       email = Value(email),
       firstName = Value(firstName),
       lastName = Value(lastName);
  static Insertable<User> custom({
    Expression<String>? id,
    Expression<String>? email,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<DateTime>? dateOfBirth,
    Expression<String>? gender,
    Expression<double>? height,
    Expression<double>? weight,
    Expression<String>? experienceLevel,
    Expression<String>? preferences,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (dateOfBirth != null) 'date_of_birth': dateOfBirth,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (experienceLevel != null) 'experience_level': experienceLevel,
      if (preferences != null) 'preferences': preferences,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsersCompanion copyWith({
    Value<String>? id,
    Value<String>? email,
    Value<String>? firstName,
    Value<String>? lastName,
    Value<DateTime?>? dateOfBirth,
    Value<String?>? gender,
    Value<double?>? height,
    Value<double?>? weight,
    Value<String>? experienceLevel,
    Value<String?>? preferences,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      experienceLevel: experienceLevel ?? this.experienceLevel,
      preferences: preferences ?? this.preferences,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (dateOfBirth.present) {
      map['date_of_birth'] = Variable<DateTime>(dateOfBirth.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (experienceLevel.present) {
      map['experience_level'] = Variable<String>(experienceLevel.value);
    }
    if (preferences.present) {
      map['preferences'] = Variable<String>(preferences.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('dateOfBirth: $dateOfBirth, ')
          ..write('gender: $gender, ')
          ..write('height: $height, ')
          ..write('weight: $weight, ')
          ..write('experienceLevel: $experienceLevel, ')
          ..write('preferences: $preferences, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalTypeMeta = const VerificationMeta(
    'goalType',
  );
  @override
  late final GeneratedColumn<String> goalType = GeneratedColumn<String>(
    'goal_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _exerciseNameMeta = const VerificationMeta(
    'exerciseName',
  );
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
    'exercise_name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentValueMeta = const VerificationMeta(
    'currentValue',
  );
  @override
  late final GeneratedColumn<double> currentValue = GeneratedColumn<double>(
    'current_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
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
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _displayOrderMeta = const VerificationMeta(
    'displayOrder',
  );
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
    'display_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    color,
    goalType,
    exerciseId,
    exerciseName,
    targetValue,
    currentValue,
    unit,
    startDate,
    targetDate,
    isArchived,
    displayOrder,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('goal_type')) {
      context.handle(
        _goalTypeMeta,
        goalType.isAcceptableOrUnknown(data['goal_type']!, _goalTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_goalTypeMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
        _exerciseNameMeta,
        exerciseName.isAcceptableOrUnknown(
          data['exercise_name']!,
          _exerciseNameMeta,
        ),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_targetValueMeta);
    }
    if (data.containsKey('current_value')) {
      context.handle(
        _currentValueMeta,
        currentValue.isAcceptableOrUnknown(
          data['current_value']!,
          _currentValueMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('start_date')) {
      context.handle(
        _startDateMeta,
        startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('display_order')) {
      context.handle(
        _displayOrderMeta,
        displayOrder.isAcceptableOrUnknown(
          data['display_order']!,
          _displayOrderMeta,
        ),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      goalType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_type'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      ),
      exerciseName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_name'],
      ),
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      currentValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}current_value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      startDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_date'],
      ),
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      displayOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}display_order'],
      )!,
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final String? color;
  final String goalType;
  final String? exerciseId;
  final String? exerciseName;
  final double targetValue;
  final double currentValue;
  final String unit;
  final DateTime? startDate;
  final DateTime? targetDate;
  final bool isArchived;
  final int displayOrder;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const Goal({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.color,
    required this.goalType,
    this.exerciseId,
    this.exerciseName,
    required this.targetValue,
    required this.currentValue,
    required this.unit,
    this.startDate,
    this.targetDate,
    required this.isArchived,
    required this.displayOrder,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    map['goal_type'] = Variable<String>(goalType);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<String>(exerciseId);
    }
    if (!nullToAbsent || exerciseName != null) {
      map['exercise_name'] = Variable<String>(exerciseName);
    }
    map['target_value'] = Variable<double>(targetValue);
    map['current_value'] = Variable<double>(currentValue);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || startDate != null) {
      map['start_date'] = Variable<DateTime>(startDate);
    }
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['display_order'] = Variable<int>(displayOrder);
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      goalType: Value(goalType),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      exerciseName: exerciseName == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseName),
      targetValue: Value(targetValue),
      currentValue: Value(currentValue),
      unit: Value(unit),
      startDate: startDate == null && nullToAbsent
          ? const Value.absent()
          : Value(startDate),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      isArchived: Value(isArchived),
      displayOrder: Value(displayOrder),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      color: serializer.fromJson<String?>(json['color']),
      goalType: serializer.fromJson<String>(json['goalType']),
      exerciseId: serializer.fromJson<String?>(json['exerciseId']),
      exerciseName: serializer.fromJson<String?>(json['exerciseName']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      currentValue: serializer.fromJson<double>(json['currentValue']),
      unit: serializer.fromJson<String>(json['unit']),
      startDate: serializer.fromJson<DateTime?>(json['startDate']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'color': serializer.toJson<String?>(color),
      'goalType': serializer.toJson<String>(goalType),
      'exerciseId': serializer.toJson<String?>(exerciseId),
      'exerciseName': serializer.toJson<String?>(exerciseName),
      'targetValue': serializer.toJson<double>(targetValue),
      'currentValue': serializer.toJson<double>(currentValue),
      'unit': serializer.toJson<String>(unit),
      'startDate': serializer.toJson<DateTime?>(startDate),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'isArchived': serializer.toJson<bool>(isArchived),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Goal copyWith({
    String? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> color = const Value.absent(),
    String? goalType,
    Value<String?> exerciseId = const Value.absent(),
    Value<String?> exerciseName = const Value.absent(),
    double? targetValue,
    double? currentValue,
    String? unit,
    Value<DateTime?> startDate = const Value.absent(),
    Value<DateTime?> targetDate = const Value.absent(),
    bool? isArchived,
    int? displayOrder,
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Goal(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    color: color.present ? color.value : this.color,
    goalType: goalType ?? this.goalType,
    exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
    exerciseName: exerciseName.present ? exerciseName.value : this.exerciseName,
    targetValue: targetValue ?? this.targetValue,
    currentValue: currentValue ?? this.currentValue,
    unit: unit ?? this.unit,
    startDate: startDate.present ? startDate.value : this.startDate,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    isArchived: isArchived ?? this.isArchived,
    displayOrder: displayOrder ?? this.displayOrder,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      color: data.color.present ? data.color.value : this.color,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      currentValue: data.currentValue.present
          ? data.currentValue.value
          : this.currentValue,
      unit: data.unit.present ? data.unit.value : this.unit,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('goalType: $goalType, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('unit: $unit, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    userId,
    name,
    description,
    color,
    goalType,
    exerciseId,
    exerciseName,
    targetValue,
    currentValue,
    unit,
    startDate,
    targetDate,
    isArchived,
    displayOrder,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.color == this.color &&
          other.goalType == this.goalType &&
          other.exerciseId == this.exerciseId &&
          other.exerciseName == this.exerciseName &&
          other.targetValue == this.targetValue &&
          other.currentValue == this.currentValue &&
          other.unit == this.unit &&
          other.startDate == this.startDate &&
          other.targetDate == this.targetDate &&
          other.isArchived == this.isArchived &&
          other.displayOrder == this.displayOrder &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> color;
  final Value<String> goalType;
  final Value<String?> exerciseId;
  final Value<String?> exerciseName;
  final Value<double> targetValue;
  final Value<double> currentValue;
  final Value<String> unit;
  final Value<DateTime?> startDate;
  final Value<DateTime?> targetDate;
  final Value<bool> isArchived;
  final Value<int> displayOrder;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.goalType = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.currentValue = const Value.absent(),
    this.unit = const Value.absent(),
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    required String goalType,
    this.exerciseId = const Value.absent(),
    this.exerciseName = const Value.absent(),
    required double targetValue,
    this.currentValue = const Value.absent(),
    required String unit,
    this.startDate = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       goalType = Value(goalType),
       targetValue = Value(targetValue),
       unit = Value(unit);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? color,
    Expression<String>? goalType,
    Expression<String>? exerciseId,
    Expression<String>? exerciseName,
    Expression<double>? targetValue,
    Expression<double>? currentValue,
    Expression<String>? unit,
    Expression<DateTime>? startDate,
    Expression<DateTime>? targetDate,
    Expression<bool>? isArchived,
    Expression<int>? displayOrder,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (goalType != null) 'goal_type': goalType,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (exerciseName != null) 'exercise_name': exerciseName,
      if (targetValue != null) 'target_value': targetValue,
      if (currentValue != null) 'current_value': currentValue,
      if (unit != null) 'unit': unit,
      if (startDate != null) 'start_date': startDate,
      if (targetDate != null) 'target_date': targetDate,
      if (isArchived != null) 'is_archived': isArchived,
      if (displayOrder != null) 'display_order': displayOrder,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? color,
    Value<String>? goalType,
    Value<String?>? exerciseId,
    Value<String?>? exerciseName,
    Value<double>? targetValue,
    Value<double>? currentValue,
    Value<String>? unit,
    Value<DateTime?>? startDate,
    Value<DateTime?>? targetDate,
    Value<bool>? isArchived,
    Value<int>? displayOrder,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      goalType: goalType ?? this.goalType,
      exerciseId: exerciseId ?? this.exerciseId,
      exerciseName: exerciseName ?? this.exerciseName,
      targetValue: targetValue ?? this.targetValue,
      currentValue: currentValue ?? this.currentValue,
      unit: unit ?? this.unit,
      startDate: startDate ?? this.startDate,
      targetDate: targetDate ?? this.targetDate,
      isArchived: isArchived ?? this.isArchived,
      displayOrder: displayOrder ?? this.displayOrder,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(goalType.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (currentValue.present) {
      map['current_value'] = Variable<double>(currentValue.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('goalType: $goalType, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('exerciseName: $exerciseName, ')
          ..write('targetValue: $targetValue, ')
          ..write('currentValue: $currentValue, ')
          ..write('unit: $unit, ')
          ..write('startDate: $startDate, ')
          ..write('targetDate: $targetDate, ')
          ..write('isArchived: $isArchived, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultEquipmentMeta = const VerificationMeta(
    'defaultEquipment',
  );
  @override
  late final GeneratedColumn<String> defaultEquipment = GeneratedColumn<String>(
    'default_equipment',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _availableEquipmentMeta =
      const VerificationMeta('availableEquipment');
  @override
  late final GeneratedColumn<String> availableEquipment =
      GeneratedColumn<String>(
        'available_equipment',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _exerciseTypesMeta = const VerificationMeta(
    'exerciseTypes',
  );
  @override
  late final GeneratedColumn<String> exerciseTypes = GeneratedColumn<String>(
    'exercise_types',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _primaryMusclesMeta = const VerificationMeta(
    'primaryMuscles',
  );
  @override
  late final GeneratedColumn<String> primaryMuscles = GeneratedColumn<String>(
    'primary_muscles',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _secondaryMusclesMeta = const VerificationMeta(
    'secondaryMuscles',
  );
  @override
  late final GeneratedColumn<String> secondaryMuscles = GeneratedColumn<String>(
    'secondary_muscles',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _bodyPartsMeta = const VerificationMeta(
    'bodyParts',
  );
  @override
  late final GeneratedColumn<String> bodyParts = GeneratedColumn<String>(
    'body_parts',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _startingWeightLbsMeta = const VerificationMeta(
    'startingWeightLbs',
  );
  @override
  late final GeneratedColumn<double> startingWeightLbs =
      GeneratedColumn<double>(
        'starting_weight_lbs',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _startingWeightKgMeta = const VerificationMeta(
    'startingWeightKg',
  );
  @override
  late final GeneratedColumn<double> startingWeightKg = GeneratedColumn<double>(
    'starting_weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultWarmupWeightMeta =
      const VerificationMeta('defaultWarmupWeight');
  @override
  late final GeneratedColumn<double> defaultWarmupWeight =
      GeneratedColumn<double>(
        'default_warmup_weight',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tipsMeta = const VerificationMeta('tips');
  @override
  late final GeneratedColumn<String> tips = GeneratedColumn<String>(
    'tips',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _videoUrlMeta = const VerificationMeta(
    'videoUrl',
  );
  @override
  late final GeneratedColumn<String> videoUrl = GeneratedColumn<String>(
    'video_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlSmallMeta = const VerificationMeta(
    'imageUrlSmall',
  );
  @override
  late final GeneratedColumn<String> imageUrlSmall = GeneratedColumn<String>(
    'image_url_small',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageUrlLargeMeta = const VerificationMeta(
    'imageUrlLarge',
  );
  @override
  late final GeneratedColumn<String> imageUrlLarge = GeneratedColumn<String>(
    'image_url_large',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasCustomImageMeta = const VerificationMeta(
    'hasCustomImage',
  );
  @override
  late final GeneratedColumn<bool> hasCustomImage = GeneratedColumn<bool>(
    'has_custom_image',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_custom_image" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _difficultyLevelMeta = const VerificationMeta(
    'difficultyLevel',
  );
  @override
  late final GeneratedColumn<int> difficultyLevel = GeneratedColumn<int>(
    'difficulty_level',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _safetyRatingMeta = const VerificationMeta(
    'safetyRating',
  );
  @override
  late final GeneratedColumn<int> safetyRating = GeneratedColumn<int>(
    'safety_rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _isCompoundMeta = const VerificationMeta(
    'isCompound',
  );
  @override
  late final GeneratedColumn<bool> isCompound = GeneratedColumn<bool>(
    'is_compound',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_compound" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isUnilateralMeta = const VerificationMeta(
    'isUnilateral',
  );
  @override
  late final GeneratedColumn<bool> isUnilateral = GeneratedColumn<bool>(
    'is_unilateral',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_unilateral" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _requiresSpotterMeta = const VerificationMeta(
    'requiresSpotter',
  );
  @override
  late final GeneratedColumn<bool> requiresSpotter = GeneratedColumn<bool>(
    'requires_spotter',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("requires_spotter" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isCustomMeta = const VerificationMeta(
    'isCustom',
  );
  @override
  late final GeneratedColumn<bool> isCustom = GeneratedColumn<bool>(
    'is_custom',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_custom" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdByMeta = const VerificationMeta(
    'createdBy',
  );
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
    'created_by',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    exerciseId,
    name,
    defaultEquipment,
    availableEquipment,
    exerciseTypes,
    primaryMuscles,
    secondaryMuscles,
    bodyParts,
    startingWeightLbs,
    startingWeightKg,
    defaultWarmupWeight,
    description,
    instructions,
    tips,
    videoUrl,
    imageUrlSmall,
    imageUrlLarge,
    hasCustomImage,
    difficultyLevel,
    safetyRating,
    isCompound,
    isUnilateral,
    requiresSpotter,
    isActive,
    isCustom,
    createdBy,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(
    Insertable<Exercise> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('default_equipment')) {
      context.handle(
        _defaultEquipmentMeta,
        defaultEquipment.isAcceptableOrUnknown(
          data['default_equipment']!,
          _defaultEquipmentMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_defaultEquipmentMeta);
    }
    if (data.containsKey('available_equipment')) {
      context.handle(
        _availableEquipmentMeta,
        availableEquipment.isAcceptableOrUnknown(
          data['available_equipment']!,
          _availableEquipmentMeta,
        ),
      );
    }
    if (data.containsKey('exercise_types')) {
      context.handle(
        _exerciseTypesMeta,
        exerciseTypes.isAcceptableOrUnknown(
          data['exercise_types']!,
          _exerciseTypesMeta,
        ),
      );
    }
    if (data.containsKey('primary_muscles')) {
      context.handle(
        _primaryMusclesMeta,
        primaryMuscles.isAcceptableOrUnknown(
          data['primary_muscles']!,
          _primaryMusclesMeta,
        ),
      );
    }
    if (data.containsKey('secondary_muscles')) {
      context.handle(
        _secondaryMusclesMeta,
        secondaryMuscles.isAcceptableOrUnknown(
          data['secondary_muscles']!,
          _secondaryMusclesMeta,
        ),
      );
    }
    if (data.containsKey('body_parts')) {
      context.handle(
        _bodyPartsMeta,
        bodyParts.isAcceptableOrUnknown(data['body_parts']!, _bodyPartsMeta),
      );
    }
    if (data.containsKey('starting_weight_lbs')) {
      context.handle(
        _startingWeightLbsMeta,
        startingWeightLbs.isAcceptableOrUnknown(
          data['starting_weight_lbs']!,
          _startingWeightLbsMeta,
        ),
      );
    }
    if (data.containsKey('starting_weight_kg')) {
      context.handle(
        _startingWeightKgMeta,
        startingWeightKg.isAcceptableOrUnknown(
          data['starting_weight_kg']!,
          _startingWeightKgMeta,
        ),
      );
    }
    if (data.containsKey('default_warmup_weight')) {
      context.handle(
        _defaultWarmupWeightMeta,
        defaultWarmupWeight.isAcceptableOrUnknown(
          data['default_warmup_weight']!,
          _defaultWarmupWeightMeta,
        ),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    }
    if (data.containsKey('tips')) {
      context.handle(
        _tipsMeta,
        tips.isAcceptableOrUnknown(data['tips']!, _tipsMeta),
      );
    }
    if (data.containsKey('video_url')) {
      context.handle(
        _videoUrlMeta,
        videoUrl.isAcceptableOrUnknown(data['video_url']!, _videoUrlMeta),
      );
    }
    if (data.containsKey('image_url_small')) {
      context.handle(
        _imageUrlSmallMeta,
        imageUrlSmall.isAcceptableOrUnknown(
          data['image_url_small']!,
          _imageUrlSmallMeta,
        ),
      );
    }
    if (data.containsKey('image_url_large')) {
      context.handle(
        _imageUrlLargeMeta,
        imageUrlLarge.isAcceptableOrUnknown(
          data['image_url_large']!,
          _imageUrlLargeMeta,
        ),
      );
    }
    if (data.containsKey('has_custom_image')) {
      context.handle(
        _hasCustomImageMeta,
        hasCustomImage.isAcceptableOrUnknown(
          data['has_custom_image']!,
          _hasCustomImageMeta,
        ),
      );
    }
    if (data.containsKey('difficulty_level')) {
      context.handle(
        _difficultyLevelMeta,
        difficultyLevel.isAcceptableOrUnknown(
          data['difficulty_level']!,
          _difficultyLevelMeta,
        ),
      );
    }
    if (data.containsKey('safety_rating')) {
      context.handle(
        _safetyRatingMeta,
        safetyRating.isAcceptableOrUnknown(
          data['safety_rating']!,
          _safetyRatingMeta,
        ),
      );
    }
    if (data.containsKey('is_compound')) {
      context.handle(
        _isCompoundMeta,
        isCompound.isAcceptableOrUnknown(data['is_compound']!, _isCompoundMeta),
      );
    }
    if (data.containsKey('is_unilateral')) {
      context.handle(
        _isUnilateralMeta,
        isUnilateral.isAcceptableOrUnknown(
          data['is_unilateral']!,
          _isUnilateralMeta,
        ),
      );
    }
    if (data.containsKey('requires_spotter')) {
      context.handle(
        _requiresSpotterMeta,
        requiresSpotter.isAcceptableOrUnknown(
          data['requires_spotter']!,
          _requiresSpotterMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('is_custom')) {
      context.handle(
        _isCustomMeta,
        isCustom.isAcceptableOrUnknown(data['is_custom']!, _isCustomMeta),
      );
    }
    if (data.containsKey('created_by')) {
      context.handle(
        _createdByMeta,
        createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      defaultEquipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_equipment'],
      )!,
      availableEquipment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}available_equipment'],
      ),
      exerciseTypes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_types'],
      ),
      primaryMuscles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_muscles'],
      ),
      secondaryMuscles: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_muscles'],
      ),
      bodyParts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_parts'],
      ),
      startingWeightLbs: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}starting_weight_lbs'],
      ),
      startingWeightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}starting_weight_kg'],
      ),
      defaultWarmupWeight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_warmup_weight'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      ),
      tips: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tips'],
      ),
      videoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}video_url'],
      ),
      imageUrlSmall: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url_small'],
      ),
      imageUrlLarge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_url_large'],
      ),
      hasCustomImage: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_custom_image'],
      )!,
      difficultyLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}difficulty_level'],
      )!,
      safetyRating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}safety_rating'],
      )!,
      isCompound: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_compound'],
      )!,
      isUnilateral: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_unilateral'],
      )!,
      requiresSpotter: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}requires_spotter'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      isCustom: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_custom'],
      )!,
      createdBy: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}created_by'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String id;
  final String exerciseId;
  final String name;
  final String defaultEquipment;
  final String? availableEquipment;
  final String? exerciseTypes;
  final String? primaryMuscles;
  final String? secondaryMuscles;
  final String? bodyParts;
  final double? startingWeightLbs;
  final double? startingWeightKg;
  final double? defaultWarmupWeight;
  final String? description;
  final String? instructions;
  final String? tips;
  final String? videoUrl;
  final String? imageUrlSmall;
  final String? imageUrlLarge;
  final bool hasCustomImage;
  final int difficultyLevel;
  final int safetyRating;
  final bool isCompound;
  final bool isUnilateral;
  final bool requiresSpotter;
  final bool isActive;
  final bool isCustom;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const Exercise({
    required this.id,
    required this.exerciseId,
    required this.name,
    required this.defaultEquipment,
    this.availableEquipment,
    this.exerciseTypes,
    this.primaryMuscles,
    this.secondaryMuscles,
    this.bodyParts,
    this.startingWeightLbs,
    this.startingWeightKg,
    this.defaultWarmupWeight,
    this.description,
    this.instructions,
    this.tips,
    this.videoUrl,
    this.imageUrlSmall,
    this.imageUrlLarge,
    required this.hasCustomImage,
    required this.difficultyLevel,
    required this.safetyRating,
    required this.isCompound,
    required this.isUnilateral,
    required this.requiresSpotter,
    required this.isActive,
    required this.isCustom,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['name'] = Variable<String>(name);
    map['default_equipment'] = Variable<String>(defaultEquipment);
    if (!nullToAbsent || availableEquipment != null) {
      map['available_equipment'] = Variable<String>(availableEquipment);
    }
    if (!nullToAbsent || exerciseTypes != null) {
      map['exercise_types'] = Variable<String>(exerciseTypes);
    }
    if (!nullToAbsent || primaryMuscles != null) {
      map['primary_muscles'] = Variable<String>(primaryMuscles);
    }
    if (!nullToAbsent || secondaryMuscles != null) {
      map['secondary_muscles'] = Variable<String>(secondaryMuscles);
    }
    if (!nullToAbsent || bodyParts != null) {
      map['body_parts'] = Variable<String>(bodyParts);
    }
    if (!nullToAbsent || startingWeightLbs != null) {
      map['starting_weight_lbs'] = Variable<double>(startingWeightLbs);
    }
    if (!nullToAbsent || startingWeightKg != null) {
      map['starting_weight_kg'] = Variable<double>(startingWeightKg);
    }
    if (!nullToAbsent || defaultWarmupWeight != null) {
      map['default_warmup_weight'] = Variable<double>(defaultWarmupWeight);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || instructions != null) {
      map['instructions'] = Variable<String>(instructions);
    }
    if (!nullToAbsent || tips != null) {
      map['tips'] = Variable<String>(tips);
    }
    if (!nullToAbsent || videoUrl != null) {
      map['video_url'] = Variable<String>(videoUrl);
    }
    if (!nullToAbsent || imageUrlSmall != null) {
      map['image_url_small'] = Variable<String>(imageUrlSmall);
    }
    if (!nullToAbsent || imageUrlLarge != null) {
      map['image_url_large'] = Variable<String>(imageUrlLarge);
    }
    map['has_custom_image'] = Variable<bool>(hasCustomImage);
    map['difficulty_level'] = Variable<int>(difficultyLevel);
    map['safety_rating'] = Variable<int>(safetyRating);
    map['is_compound'] = Variable<bool>(isCompound);
    map['is_unilateral'] = Variable<bool>(isUnilateral);
    map['requires_spotter'] = Variable<bool>(requiresSpotter);
    map['is_active'] = Variable<bool>(isActive);
    map['is_custom'] = Variable<bool>(isCustom);
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      id: Value(id),
      exerciseId: Value(exerciseId),
      name: Value(name),
      defaultEquipment: Value(defaultEquipment),
      availableEquipment: availableEquipment == null && nullToAbsent
          ? const Value.absent()
          : Value(availableEquipment),
      exerciseTypes: exerciseTypes == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseTypes),
      primaryMuscles: primaryMuscles == null && nullToAbsent
          ? const Value.absent()
          : Value(primaryMuscles),
      secondaryMuscles: secondaryMuscles == null && nullToAbsent
          ? const Value.absent()
          : Value(secondaryMuscles),
      bodyParts: bodyParts == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyParts),
      startingWeightLbs: startingWeightLbs == null && nullToAbsent
          ? const Value.absent()
          : Value(startingWeightLbs),
      startingWeightKg: startingWeightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(startingWeightKg),
      defaultWarmupWeight: defaultWarmupWeight == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultWarmupWeight),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      instructions: instructions == null && nullToAbsent
          ? const Value.absent()
          : Value(instructions),
      tips: tips == null && nullToAbsent ? const Value.absent() : Value(tips),
      videoUrl: videoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(videoUrl),
      imageUrlSmall: imageUrlSmall == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrlSmall),
      imageUrlLarge: imageUrlLarge == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrlLarge),
      hasCustomImage: Value(hasCustomImage),
      difficultyLevel: Value(difficultyLevel),
      safetyRating: Value(safetyRating),
      isCompound: Value(isCompound),
      isUnilateral: Value(isUnilateral),
      requiresSpotter: Value(requiresSpotter),
      isActive: Value(isActive),
      isCustom: Value(isCustom),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Exercise.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      id: serializer.fromJson<String>(json['id']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      name: serializer.fromJson<String>(json['name']),
      defaultEquipment: serializer.fromJson<String>(json['defaultEquipment']),
      availableEquipment: serializer.fromJson<String?>(
        json['availableEquipment'],
      ),
      exerciseTypes: serializer.fromJson<String?>(json['exerciseTypes']),
      primaryMuscles: serializer.fromJson<String?>(json['primaryMuscles']),
      secondaryMuscles: serializer.fromJson<String?>(json['secondaryMuscles']),
      bodyParts: serializer.fromJson<String?>(json['bodyParts']),
      startingWeightLbs: serializer.fromJson<double?>(
        json['startingWeightLbs'],
      ),
      startingWeightKg: serializer.fromJson<double?>(json['startingWeightKg']),
      defaultWarmupWeight: serializer.fromJson<double?>(
        json['defaultWarmupWeight'],
      ),
      description: serializer.fromJson<String?>(json['description']),
      instructions: serializer.fromJson<String?>(json['instructions']),
      tips: serializer.fromJson<String?>(json['tips']),
      videoUrl: serializer.fromJson<String?>(json['videoUrl']),
      imageUrlSmall: serializer.fromJson<String?>(json['imageUrlSmall']),
      imageUrlLarge: serializer.fromJson<String?>(json['imageUrlLarge']),
      hasCustomImage: serializer.fromJson<bool>(json['hasCustomImage']),
      difficultyLevel: serializer.fromJson<int>(json['difficultyLevel']),
      safetyRating: serializer.fromJson<int>(json['safetyRating']),
      isCompound: serializer.fromJson<bool>(json['isCompound']),
      isUnilateral: serializer.fromJson<bool>(json['isUnilateral']),
      requiresSpotter: serializer.fromJson<bool>(json['requiresSpotter']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isCustom: serializer.fromJson<bool>(json['isCustom']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'name': serializer.toJson<String>(name),
      'defaultEquipment': serializer.toJson<String>(defaultEquipment),
      'availableEquipment': serializer.toJson<String?>(availableEquipment),
      'exerciseTypes': serializer.toJson<String?>(exerciseTypes),
      'primaryMuscles': serializer.toJson<String?>(primaryMuscles),
      'secondaryMuscles': serializer.toJson<String?>(secondaryMuscles),
      'bodyParts': serializer.toJson<String?>(bodyParts),
      'startingWeightLbs': serializer.toJson<double?>(startingWeightLbs),
      'startingWeightKg': serializer.toJson<double?>(startingWeightKg),
      'defaultWarmupWeight': serializer.toJson<double?>(defaultWarmupWeight),
      'description': serializer.toJson<String?>(description),
      'instructions': serializer.toJson<String?>(instructions),
      'tips': serializer.toJson<String?>(tips),
      'videoUrl': serializer.toJson<String?>(videoUrl),
      'imageUrlSmall': serializer.toJson<String?>(imageUrlSmall),
      'imageUrlLarge': serializer.toJson<String?>(imageUrlLarge),
      'hasCustomImage': serializer.toJson<bool>(hasCustomImage),
      'difficultyLevel': serializer.toJson<int>(difficultyLevel),
      'safetyRating': serializer.toJson<int>(safetyRating),
      'isCompound': serializer.toJson<bool>(isCompound),
      'isUnilateral': serializer.toJson<bool>(isUnilateral),
      'requiresSpotter': serializer.toJson<bool>(requiresSpotter),
      'isActive': serializer.toJson<bool>(isActive),
      'isCustom': serializer.toJson<bool>(isCustom),
      'createdBy': serializer.toJson<String?>(createdBy),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Exercise copyWith({
    String? id,
    String? exerciseId,
    String? name,
    String? defaultEquipment,
    Value<String?> availableEquipment = const Value.absent(),
    Value<String?> exerciseTypes = const Value.absent(),
    Value<String?> primaryMuscles = const Value.absent(),
    Value<String?> secondaryMuscles = const Value.absent(),
    Value<String?> bodyParts = const Value.absent(),
    Value<double?> startingWeightLbs = const Value.absent(),
    Value<double?> startingWeightKg = const Value.absent(),
    Value<double?> defaultWarmupWeight = const Value.absent(),
    Value<String?> description = const Value.absent(),
    Value<String?> instructions = const Value.absent(),
    Value<String?> tips = const Value.absent(),
    Value<String?> videoUrl = const Value.absent(),
    Value<String?> imageUrlSmall = const Value.absent(),
    Value<String?> imageUrlLarge = const Value.absent(),
    bool? hasCustomImage,
    int? difficultyLevel,
    int? safetyRating,
    bool? isCompound,
    bool? isUnilateral,
    bool? requiresSpotter,
    bool? isActive,
    bool? isCustom,
    Value<String?> createdBy = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Exercise(
    id: id ?? this.id,
    exerciseId: exerciseId ?? this.exerciseId,
    name: name ?? this.name,
    defaultEquipment: defaultEquipment ?? this.defaultEquipment,
    availableEquipment: availableEquipment.present
        ? availableEquipment.value
        : this.availableEquipment,
    exerciseTypes: exerciseTypes.present
        ? exerciseTypes.value
        : this.exerciseTypes,
    primaryMuscles: primaryMuscles.present
        ? primaryMuscles.value
        : this.primaryMuscles,
    secondaryMuscles: secondaryMuscles.present
        ? secondaryMuscles.value
        : this.secondaryMuscles,
    bodyParts: bodyParts.present ? bodyParts.value : this.bodyParts,
    startingWeightLbs: startingWeightLbs.present
        ? startingWeightLbs.value
        : this.startingWeightLbs,
    startingWeightKg: startingWeightKg.present
        ? startingWeightKg.value
        : this.startingWeightKg,
    defaultWarmupWeight: defaultWarmupWeight.present
        ? defaultWarmupWeight.value
        : this.defaultWarmupWeight,
    description: description.present ? description.value : this.description,
    instructions: instructions.present ? instructions.value : this.instructions,
    tips: tips.present ? tips.value : this.tips,
    videoUrl: videoUrl.present ? videoUrl.value : this.videoUrl,
    imageUrlSmall: imageUrlSmall.present
        ? imageUrlSmall.value
        : this.imageUrlSmall,
    imageUrlLarge: imageUrlLarge.present
        ? imageUrlLarge.value
        : this.imageUrlLarge,
    hasCustomImage: hasCustomImage ?? this.hasCustomImage,
    difficultyLevel: difficultyLevel ?? this.difficultyLevel,
    safetyRating: safetyRating ?? this.safetyRating,
    isCompound: isCompound ?? this.isCompound,
    isUnilateral: isUnilateral ?? this.isUnilateral,
    requiresSpotter: requiresSpotter ?? this.requiresSpotter,
    isActive: isActive ?? this.isActive,
    isCustom: isCustom ?? this.isCustom,
    createdBy: createdBy.present ? createdBy.value : this.createdBy,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      id: data.id.present ? data.id.value : this.id,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      name: data.name.present ? data.name.value : this.name,
      defaultEquipment: data.defaultEquipment.present
          ? data.defaultEquipment.value
          : this.defaultEquipment,
      availableEquipment: data.availableEquipment.present
          ? data.availableEquipment.value
          : this.availableEquipment,
      exerciseTypes: data.exerciseTypes.present
          ? data.exerciseTypes.value
          : this.exerciseTypes,
      primaryMuscles: data.primaryMuscles.present
          ? data.primaryMuscles.value
          : this.primaryMuscles,
      secondaryMuscles: data.secondaryMuscles.present
          ? data.secondaryMuscles.value
          : this.secondaryMuscles,
      bodyParts: data.bodyParts.present ? data.bodyParts.value : this.bodyParts,
      startingWeightLbs: data.startingWeightLbs.present
          ? data.startingWeightLbs.value
          : this.startingWeightLbs,
      startingWeightKg: data.startingWeightKg.present
          ? data.startingWeightKg.value
          : this.startingWeightKg,
      defaultWarmupWeight: data.defaultWarmupWeight.present
          ? data.defaultWarmupWeight.value
          : this.defaultWarmupWeight,
      description: data.description.present
          ? data.description.value
          : this.description,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      tips: data.tips.present ? data.tips.value : this.tips,
      videoUrl: data.videoUrl.present ? data.videoUrl.value : this.videoUrl,
      imageUrlSmall: data.imageUrlSmall.present
          ? data.imageUrlSmall.value
          : this.imageUrlSmall,
      imageUrlLarge: data.imageUrlLarge.present
          ? data.imageUrlLarge.value
          : this.imageUrlLarge,
      hasCustomImage: data.hasCustomImage.present
          ? data.hasCustomImage.value
          : this.hasCustomImage,
      difficultyLevel: data.difficultyLevel.present
          ? data.difficultyLevel.value
          : this.difficultyLevel,
      safetyRating: data.safetyRating.present
          ? data.safetyRating.value
          : this.safetyRating,
      isCompound: data.isCompound.present
          ? data.isCompound.value
          : this.isCompound,
      isUnilateral: data.isUnilateral.present
          ? data.isUnilateral.value
          : this.isUnilateral,
      requiresSpotter: data.requiresSpotter.present
          ? data.requiresSpotter.value
          : this.requiresSpotter,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isCustom: data.isCustom.present ? data.isCustom.value : this.isCustom,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('name: $name, ')
          ..write('defaultEquipment: $defaultEquipment, ')
          ..write('availableEquipment: $availableEquipment, ')
          ..write('exerciseTypes: $exerciseTypes, ')
          ..write('primaryMuscles: $primaryMuscles, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('bodyParts: $bodyParts, ')
          ..write('startingWeightLbs: $startingWeightLbs, ')
          ..write('startingWeightKg: $startingWeightKg, ')
          ..write('defaultWarmupWeight: $defaultWarmupWeight, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('tips: $tips, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('imageUrlSmall: $imageUrlSmall, ')
          ..write('imageUrlLarge: $imageUrlLarge, ')
          ..write('hasCustomImage: $hasCustomImage, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('safetyRating: $safetyRating, ')
          ..write('isCompound: $isCompound, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('requiresSpotter: $requiresSpotter, ')
          ..write('isActive: $isActive, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    exerciseId,
    name,
    defaultEquipment,
    availableEquipment,
    exerciseTypes,
    primaryMuscles,
    secondaryMuscles,
    bodyParts,
    startingWeightLbs,
    startingWeightKg,
    defaultWarmupWeight,
    description,
    instructions,
    tips,
    videoUrl,
    imageUrlSmall,
    imageUrlLarge,
    hasCustomImage,
    difficultyLevel,
    safetyRating,
    isCompound,
    isUnilateral,
    requiresSpotter,
    isActive,
    isCustom,
    createdBy,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Exercise &&
          other.id == this.id &&
          other.exerciseId == this.exerciseId &&
          other.name == this.name &&
          other.defaultEquipment == this.defaultEquipment &&
          other.availableEquipment == this.availableEquipment &&
          other.exerciseTypes == this.exerciseTypes &&
          other.primaryMuscles == this.primaryMuscles &&
          other.secondaryMuscles == this.secondaryMuscles &&
          other.bodyParts == this.bodyParts &&
          other.startingWeightLbs == this.startingWeightLbs &&
          other.startingWeightKg == this.startingWeightKg &&
          other.defaultWarmupWeight == this.defaultWarmupWeight &&
          other.description == this.description &&
          other.instructions == this.instructions &&
          other.tips == this.tips &&
          other.videoUrl == this.videoUrl &&
          other.imageUrlSmall == this.imageUrlSmall &&
          other.imageUrlLarge == this.imageUrlLarge &&
          other.hasCustomImage == this.hasCustomImage &&
          other.difficultyLevel == this.difficultyLevel &&
          other.safetyRating == this.safetyRating &&
          other.isCompound == this.isCompound &&
          other.isUnilateral == this.isUnilateral &&
          other.requiresSpotter == this.requiresSpotter &&
          other.isActive == this.isActive &&
          other.isCustom == this.isCustom &&
          other.createdBy == this.createdBy &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> id;
  final Value<String> exerciseId;
  final Value<String> name;
  final Value<String> defaultEquipment;
  final Value<String?> availableEquipment;
  final Value<String?> exerciseTypes;
  final Value<String?> primaryMuscles;
  final Value<String?> secondaryMuscles;
  final Value<String?> bodyParts;
  final Value<double?> startingWeightLbs;
  final Value<double?> startingWeightKg;
  final Value<double?> defaultWarmupWeight;
  final Value<String?> description;
  final Value<String?> instructions;
  final Value<String?> tips;
  final Value<String?> videoUrl;
  final Value<String?> imageUrlSmall;
  final Value<String?> imageUrlLarge;
  final Value<bool> hasCustomImage;
  final Value<int> difficultyLevel;
  final Value<int> safetyRating;
  final Value<bool> isCompound;
  final Value<bool> isUnilateral;
  final Value<bool> requiresSpotter;
  final Value<bool> isActive;
  final Value<bool> isCustom;
  final Value<String?> createdBy;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.id = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.name = const Value.absent(),
    this.defaultEquipment = const Value.absent(),
    this.availableEquipment = const Value.absent(),
    this.exerciseTypes = const Value.absent(),
    this.primaryMuscles = const Value.absent(),
    this.secondaryMuscles = const Value.absent(),
    this.bodyParts = const Value.absent(),
    this.startingWeightLbs = const Value.absent(),
    this.startingWeightKg = const Value.absent(),
    this.defaultWarmupWeight = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.tips = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.imageUrlSmall = const Value.absent(),
    this.imageUrlLarge = const Value.absent(),
    this.hasCustomImage = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.safetyRating = const Value.absent(),
    this.isCompound = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.requiresSpotter = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String id,
    required String exerciseId,
    required String name,
    required String defaultEquipment,
    this.availableEquipment = const Value.absent(),
    this.exerciseTypes = const Value.absent(),
    this.primaryMuscles = const Value.absent(),
    this.secondaryMuscles = const Value.absent(),
    this.bodyParts = const Value.absent(),
    this.startingWeightLbs = const Value.absent(),
    this.startingWeightKg = const Value.absent(),
    this.defaultWarmupWeight = const Value.absent(),
    this.description = const Value.absent(),
    this.instructions = const Value.absent(),
    this.tips = const Value.absent(),
    this.videoUrl = const Value.absent(),
    this.imageUrlSmall = const Value.absent(),
    this.imageUrlLarge = const Value.absent(),
    this.hasCustomImage = const Value.absent(),
    this.difficultyLevel = const Value.absent(),
    this.safetyRating = const Value.absent(),
    this.isCompound = const Value.absent(),
    this.isUnilateral = const Value.absent(),
    this.requiresSpotter = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isCustom = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       exerciseId = Value(exerciseId),
       name = Value(name),
       defaultEquipment = Value(defaultEquipment);
  static Insertable<Exercise> custom({
    Expression<String>? id,
    Expression<String>? exerciseId,
    Expression<String>? name,
    Expression<String>? defaultEquipment,
    Expression<String>? availableEquipment,
    Expression<String>? exerciseTypes,
    Expression<String>? primaryMuscles,
    Expression<String>? secondaryMuscles,
    Expression<String>? bodyParts,
    Expression<double>? startingWeightLbs,
    Expression<double>? startingWeightKg,
    Expression<double>? defaultWarmupWeight,
    Expression<String>? description,
    Expression<String>? instructions,
    Expression<String>? tips,
    Expression<String>? videoUrl,
    Expression<String>? imageUrlSmall,
    Expression<String>? imageUrlLarge,
    Expression<bool>? hasCustomImage,
    Expression<int>? difficultyLevel,
    Expression<int>? safetyRating,
    Expression<bool>? isCompound,
    Expression<bool>? isUnilateral,
    Expression<bool>? requiresSpotter,
    Expression<bool>? isActive,
    Expression<bool>? isCustom,
    Expression<String>? createdBy,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (name != null) 'name': name,
      if (defaultEquipment != null) 'default_equipment': defaultEquipment,
      if (availableEquipment != null) 'available_equipment': availableEquipment,
      if (exerciseTypes != null) 'exercise_types': exerciseTypes,
      if (primaryMuscles != null) 'primary_muscles': primaryMuscles,
      if (secondaryMuscles != null) 'secondary_muscles': secondaryMuscles,
      if (bodyParts != null) 'body_parts': bodyParts,
      if (startingWeightLbs != null) 'starting_weight_lbs': startingWeightLbs,
      if (startingWeightKg != null) 'starting_weight_kg': startingWeightKg,
      if (defaultWarmupWeight != null)
        'default_warmup_weight': defaultWarmupWeight,
      if (description != null) 'description': description,
      if (instructions != null) 'instructions': instructions,
      if (tips != null) 'tips': tips,
      if (videoUrl != null) 'video_url': videoUrl,
      if (imageUrlSmall != null) 'image_url_small': imageUrlSmall,
      if (imageUrlLarge != null) 'image_url_large': imageUrlLarge,
      if (hasCustomImage != null) 'has_custom_image': hasCustomImage,
      if (difficultyLevel != null) 'difficulty_level': difficultyLevel,
      if (safetyRating != null) 'safety_rating': safetyRating,
      if (isCompound != null) 'is_compound': isCompound,
      if (isUnilateral != null) 'is_unilateral': isUnilateral,
      if (requiresSpotter != null) 'requires_spotter': requiresSpotter,
      if (isActive != null) 'is_active': isActive,
      if (isCustom != null) 'is_custom': isCustom,
      if (createdBy != null) 'created_by': createdBy,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({
    Value<String>? id,
    Value<String>? exerciseId,
    Value<String>? name,
    Value<String>? defaultEquipment,
    Value<String?>? availableEquipment,
    Value<String?>? exerciseTypes,
    Value<String?>? primaryMuscles,
    Value<String?>? secondaryMuscles,
    Value<String?>? bodyParts,
    Value<double?>? startingWeightLbs,
    Value<double?>? startingWeightKg,
    Value<double?>? defaultWarmupWeight,
    Value<String?>? description,
    Value<String?>? instructions,
    Value<String?>? tips,
    Value<String?>? videoUrl,
    Value<String?>? imageUrlSmall,
    Value<String?>? imageUrlLarge,
    Value<bool>? hasCustomImage,
    Value<int>? difficultyLevel,
    Value<int>? safetyRating,
    Value<bool>? isCompound,
    Value<bool>? isUnilateral,
    Value<bool>? requiresSpotter,
    Value<bool>? isActive,
    Value<bool>? isCustom,
    Value<String?>? createdBy,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ExercisesCompanion(
      id: id ?? this.id,
      exerciseId: exerciseId ?? this.exerciseId,
      name: name ?? this.name,
      defaultEquipment: defaultEquipment ?? this.defaultEquipment,
      availableEquipment: availableEquipment ?? this.availableEquipment,
      exerciseTypes: exerciseTypes ?? this.exerciseTypes,
      primaryMuscles: primaryMuscles ?? this.primaryMuscles,
      secondaryMuscles: secondaryMuscles ?? this.secondaryMuscles,
      bodyParts: bodyParts ?? this.bodyParts,
      startingWeightLbs: startingWeightLbs ?? this.startingWeightLbs,
      startingWeightKg: startingWeightKg ?? this.startingWeightKg,
      defaultWarmupWeight: defaultWarmupWeight ?? this.defaultWarmupWeight,
      description: description ?? this.description,
      instructions: instructions ?? this.instructions,
      tips: tips ?? this.tips,
      videoUrl: videoUrl ?? this.videoUrl,
      imageUrlSmall: imageUrlSmall ?? this.imageUrlSmall,
      imageUrlLarge: imageUrlLarge ?? this.imageUrlLarge,
      hasCustomImage: hasCustomImage ?? this.hasCustomImage,
      difficultyLevel: difficultyLevel ?? this.difficultyLevel,
      safetyRating: safetyRating ?? this.safetyRating,
      isCompound: isCompound ?? this.isCompound,
      isUnilateral: isUnilateral ?? this.isUnilateral,
      requiresSpotter: requiresSpotter ?? this.requiresSpotter,
      isActive: isActive ?? this.isActive,
      isCustom: isCustom ?? this.isCustom,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (defaultEquipment.present) {
      map['default_equipment'] = Variable<String>(defaultEquipment.value);
    }
    if (availableEquipment.present) {
      map['available_equipment'] = Variable<String>(availableEquipment.value);
    }
    if (exerciseTypes.present) {
      map['exercise_types'] = Variable<String>(exerciseTypes.value);
    }
    if (primaryMuscles.present) {
      map['primary_muscles'] = Variable<String>(primaryMuscles.value);
    }
    if (secondaryMuscles.present) {
      map['secondary_muscles'] = Variable<String>(secondaryMuscles.value);
    }
    if (bodyParts.present) {
      map['body_parts'] = Variable<String>(bodyParts.value);
    }
    if (startingWeightLbs.present) {
      map['starting_weight_lbs'] = Variable<double>(startingWeightLbs.value);
    }
    if (startingWeightKg.present) {
      map['starting_weight_kg'] = Variable<double>(startingWeightKg.value);
    }
    if (defaultWarmupWeight.present) {
      map['default_warmup_weight'] = Variable<double>(
        defaultWarmupWeight.value,
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (tips.present) {
      map['tips'] = Variable<String>(tips.value);
    }
    if (videoUrl.present) {
      map['video_url'] = Variable<String>(videoUrl.value);
    }
    if (imageUrlSmall.present) {
      map['image_url_small'] = Variable<String>(imageUrlSmall.value);
    }
    if (imageUrlLarge.present) {
      map['image_url_large'] = Variable<String>(imageUrlLarge.value);
    }
    if (hasCustomImage.present) {
      map['has_custom_image'] = Variable<bool>(hasCustomImage.value);
    }
    if (difficultyLevel.present) {
      map['difficulty_level'] = Variable<int>(difficultyLevel.value);
    }
    if (safetyRating.present) {
      map['safety_rating'] = Variable<int>(safetyRating.value);
    }
    if (isCompound.present) {
      map['is_compound'] = Variable<bool>(isCompound.value);
    }
    if (isUnilateral.present) {
      map['is_unilateral'] = Variable<bool>(isUnilateral.value);
    }
    if (requiresSpotter.present) {
      map['requires_spotter'] = Variable<bool>(requiresSpotter.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isCustom.present) {
      map['is_custom'] = Variable<bool>(isCustom.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('id: $id, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('name: $name, ')
          ..write('defaultEquipment: $defaultEquipment, ')
          ..write('availableEquipment: $availableEquipment, ')
          ..write('exerciseTypes: $exerciseTypes, ')
          ..write('primaryMuscles: $primaryMuscles, ')
          ..write('secondaryMuscles: $secondaryMuscles, ')
          ..write('bodyParts: $bodyParts, ')
          ..write('startingWeightLbs: $startingWeightLbs, ')
          ..write('startingWeightKg: $startingWeightKg, ')
          ..write('defaultWarmupWeight: $defaultWarmupWeight, ')
          ..write('description: $description, ')
          ..write('instructions: $instructions, ')
          ..write('tips: $tips, ')
          ..write('videoUrl: $videoUrl, ')
          ..write('imageUrlSmall: $imageUrlSmall, ')
          ..write('imageUrlLarge: $imageUrlLarge, ')
          ..write('hasCustomImage: $hasCustomImage, ')
          ..write('difficultyLevel: $difficultyLevel, ')
          ..write('safetyRating: $safetyRating, ')
          ..write('isCompound: $isCompound, ')
          ..write('isUnilateral: $isUnilateral, ')
          ..write('requiresSpotter: $requiresSpotter, ')
          ..write('isActive: $isActive, ')
          ..write('isCustom: $isCustom, ')
          ..write('createdBy: $createdBy, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgramsTable extends Programs with TableInfo<$ProgramsTable, Program> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgramsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationWeeksMeta = const VerificationMeta(
    'durationWeeks',
  );
  @override
  late final GeneratedColumn<int> durationWeeks = GeneratedColumn<int>(
    'duration_weeks',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sessionsPerWeekMeta = const VerificationMeta(
    'sessionsPerWeek',
  );
  @override
  late final GeneratedColumn<int> sessionsPerWeek = GeneratedColumn<int>(
    'sessions_per_week',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _difficultyMeta = const VerificationMeta(
    'difficulty',
  );
  @override
  late final GeneratedColumn<String> difficulty = GeneratedColumn<String>(
    'difficulty',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('intermediate'),
  );
  static const VerificationMeta _configurationMeta = const VerificationMeta(
    'configuration',
  );
  @override
  late final GeneratedColumn<String> configuration = GeneratedColumn<String>(
    'configuration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isTemplateMeta = const VerificationMeta(
    'isTemplate',
  );
  @override
  late final GeneratedColumn<bool> isTemplate = GeneratedColumn<bool>(
    'is_template',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_template" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    description,
    durationWeeks,
    sessionsPerWeek,
    difficulty,
    configuration,
    isTemplate,
    isActive,
    startedAt,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'programs';
  @override
  VerificationContext validateIntegrity(
    Insertable<Program> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('duration_weeks')) {
      context.handle(
        _durationWeeksMeta,
        durationWeeks.isAcceptableOrUnknown(
          data['duration_weeks']!,
          _durationWeeksMeta,
        ),
      );
    }
    if (data.containsKey('sessions_per_week')) {
      context.handle(
        _sessionsPerWeekMeta,
        sessionsPerWeek.isAcceptableOrUnknown(
          data['sessions_per_week']!,
          _sessionsPerWeekMeta,
        ),
      );
    }
    if (data.containsKey('difficulty')) {
      context.handle(
        _difficultyMeta,
        difficulty.isAcceptableOrUnknown(data['difficulty']!, _difficultyMeta),
      );
    }
    if (data.containsKey('configuration')) {
      context.handle(
        _configurationMeta,
        configuration.isAcceptableOrUnknown(
          data['configuration']!,
          _configurationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_configurationMeta);
    }
    if (data.containsKey('is_template')) {
      context.handle(
        _isTemplateMeta,
        isTemplate.isAcceptableOrUnknown(data['is_template']!, _isTemplateMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Program map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Program(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      durationWeeks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_weeks'],
      ),
      sessionsPerWeek: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sessions_per_week'],
      ),
      difficulty: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}difficulty'],
      )!,
      configuration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}configuration'],
      )!,
      isTemplate: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_template'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProgramsTable createAlias(String alias) {
    return $ProgramsTable(attachedDatabase, alias);
  }
}

class Program extends DataClass implements Insertable<Program> {
  final String id;
  final String userId;
  final String name;
  final String? description;
  final int? durationWeeks;
  final int? sessionsPerWeek;
  final String difficulty;
  final String configuration;
  final bool isTemplate;
  final bool isActive;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const Program({
    required this.id,
    required this.userId,
    required this.name,
    this.description,
    this.durationWeeks,
    this.sessionsPerWeek,
    required this.difficulty,
    required this.configuration,
    required this.isTemplate,
    required this.isActive,
    this.startedAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || durationWeeks != null) {
      map['duration_weeks'] = Variable<int>(durationWeeks);
    }
    if (!nullToAbsent || sessionsPerWeek != null) {
      map['sessions_per_week'] = Variable<int>(sessionsPerWeek);
    }
    map['difficulty'] = Variable<String>(difficulty);
    map['configuration'] = Variable<String>(configuration);
    map['is_template'] = Variable<bool>(isTemplate);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProgramsCompanion toCompanion(bool nullToAbsent) {
    return ProgramsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      durationWeeks: durationWeeks == null && nullToAbsent
          ? const Value.absent()
          : Value(durationWeeks),
      sessionsPerWeek: sessionsPerWeek == null && nullToAbsent
          ? const Value.absent()
          : Value(sessionsPerWeek),
      difficulty: Value(difficulty),
      configuration: Value(configuration),
      isTemplate: Value(isTemplate),
      isActive: Value(isActive),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Program.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Program(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      durationWeeks: serializer.fromJson<int?>(json['durationWeeks']),
      sessionsPerWeek: serializer.fromJson<int?>(json['sessionsPerWeek']),
      difficulty: serializer.fromJson<String>(json['difficulty']),
      configuration: serializer.fromJson<String>(json['configuration']),
      isTemplate: serializer.fromJson<bool>(json['isTemplate']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'durationWeeks': serializer.toJson<int?>(durationWeeks),
      'sessionsPerWeek': serializer.toJson<int?>(sessionsPerWeek),
      'difficulty': serializer.toJson<String>(difficulty),
      'configuration': serializer.toJson<String>(configuration),
      'isTemplate': serializer.toJson<bool>(isTemplate),
      'isActive': serializer.toJson<bool>(isActive),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Program copyWith({
    String? id,
    String? userId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<int?> durationWeeks = const Value.absent(),
    Value<int?> sessionsPerWeek = const Value.absent(),
    String? difficulty,
    String? configuration,
    bool? isTemplate,
    bool? isActive,
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Program(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    durationWeeks: durationWeeks.present
        ? durationWeeks.value
        : this.durationWeeks,
    sessionsPerWeek: sessionsPerWeek.present
        ? sessionsPerWeek.value
        : this.sessionsPerWeek,
    difficulty: difficulty ?? this.difficulty,
    configuration: configuration ?? this.configuration,
    isTemplate: isTemplate ?? this.isTemplate,
    isActive: isActive ?? this.isActive,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Program copyWithCompanion(ProgramsCompanion data) {
    return Program(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      durationWeeks: data.durationWeeks.present
          ? data.durationWeeks.value
          : this.durationWeeks,
      sessionsPerWeek: data.sessionsPerWeek.present
          ? data.sessionsPerWeek.value
          : this.sessionsPerWeek,
      difficulty: data.difficulty.present
          ? data.difficulty.value
          : this.difficulty,
      configuration: data.configuration.present
          ? data.configuration.value
          : this.configuration,
      isTemplate: data.isTemplate.present
          ? data.isTemplate.value
          : this.isTemplate,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Program(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('durationWeeks: $durationWeeks, ')
          ..write('sessionsPerWeek: $sessionsPerWeek, ')
          ..write('difficulty: $difficulty, ')
          ..write('configuration: $configuration, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('isActive: $isActive, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    description,
    durationWeeks,
    sessionsPerWeek,
    difficulty,
    configuration,
    isTemplate,
    isActive,
    startedAt,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Program &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.description == this.description &&
          other.durationWeeks == this.durationWeeks &&
          other.sessionsPerWeek == this.sessionsPerWeek &&
          other.difficulty == this.difficulty &&
          other.configuration == this.configuration &&
          other.isTemplate == this.isTemplate &&
          other.isActive == this.isActive &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class ProgramsCompanion extends UpdateCompanion<Program> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<String?> description;
  final Value<int?> durationWeeks;
  final Value<int?> sessionsPerWeek;
  final Value<String> difficulty;
  final Value<String> configuration;
  final Value<bool> isTemplate;
  final Value<bool> isActive;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProgramsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.durationWeeks = const Value.absent(),
    this.sessionsPerWeek = const Value.absent(),
    this.difficulty = const Value.absent(),
    this.configuration = const Value.absent(),
    this.isTemplate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgramsCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.description = const Value.absent(),
    this.durationWeeks = const Value.absent(),
    this.sessionsPerWeek = const Value.absent(),
    this.difficulty = const Value.absent(),
    required String configuration,
    this.isTemplate = const Value.absent(),
    this.isActive = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       configuration = Value(configuration);
  static Insertable<Program> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? durationWeeks,
    Expression<int>? sessionsPerWeek,
    Expression<String>? difficulty,
    Expression<String>? configuration,
    Expression<bool>? isTemplate,
    Expression<bool>? isActive,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (durationWeeks != null) 'duration_weeks': durationWeeks,
      if (sessionsPerWeek != null) 'sessions_per_week': sessionsPerWeek,
      if (difficulty != null) 'difficulty': difficulty,
      if (configuration != null) 'configuration': configuration,
      if (isTemplate != null) 'is_template': isTemplate,
      if (isActive != null) 'is_active': isActive,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgramsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<String?>? description,
    Value<int?>? durationWeeks,
    Value<int?>? sessionsPerWeek,
    Value<String>? difficulty,
    Value<String>? configuration,
    Value<bool>? isTemplate,
    Value<bool>? isActive,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ProgramsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      durationWeeks: durationWeeks ?? this.durationWeeks,
      sessionsPerWeek: sessionsPerWeek ?? this.sessionsPerWeek,
      difficulty: difficulty ?? this.difficulty,
      configuration: configuration ?? this.configuration,
      isTemplate: isTemplate ?? this.isTemplate,
      isActive: isActive ?? this.isActive,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (durationWeeks.present) {
      map['duration_weeks'] = Variable<int>(durationWeeks.value);
    }
    if (sessionsPerWeek.present) {
      map['sessions_per_week'] = Variable<int>(sessionsPerWeek.value);
    }
    if (difficulty.present) {
      map['difficulty'] = Variable<String>(difficulty.value);
    }
    if (configuration.present) {
      map['configuration'] = Variable<String>(configuration.value);
    }
    if (isTemplate.present) {
      map['is_template'] = Variable<bool>(isTemplate.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgramsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('durationWeeks: $durationWeeks, ')
          ..write('sessionsPerWeek: $sessionsPerWeek, ')
          ..write('difficulty: $difficulty, ')
          ..write('configuration: $configuration, ')
          ..write('isTemplate: $isTemplate, ')
          ..write('isActive: $isActive, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutsTable extends Workouts with TableInfo<$WorkoutsTable, Workout> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _programIdMeta = const VerificationMeta(
    'programId',
  );
  @override
  late final GeneratedColumn<String> programId = GeneratedColumn<String>(
    'program_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 200,
    ),
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
  static const VerificationMeta _startedAtMeta = const VerificationMeta(
    'startedAt',
  );
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
    'started_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _totalSetsMeta = const VerificationMeta(
    'totalSets',
  );
  @override
  late final GeneratedColumn<int> totalSets = GeneratedColumn<int>(
    'total_sets',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalRepsMeta = const VerificationMeta(
    'totalReps',
  );
  @override
  late final GeneratedColumn<int> totalReps = GeneratedColumn<int>(
    'total_reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalVolumeMeta = const VerificationMeta(
    'totalVolume',
  );
  @override
  late final GeneratedColumn<double> totalVolume = GeneratedColumn<double>(
    'total_volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('planned'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    programId,
    name,
    notes,
    startedAt,
    completedAt,
    totalSets,
    totalReps,
    totalVolume,
    durationMinutes,
    status,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workouts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Workout> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('program_id')) {
      context.handle(
        _programIdMeta,
        programId.isAcceptableOrUnknown(data['program_id']!, _programIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('started_at')) {
      context.handle(
        _startedAtMeta,
        startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('total_sets')) {
      context.handle(
        _totalSetsMeta,
        totalSets.isAcceptableOrUnknown(data['total_sets']!, _totalSetsMeta),
      );
    }
    if (data.containsKey('total_reps')) {
      context.handle(
        _totalRepsMeta,
        totalReps.isAcceptableOrUnknown(data['total_reps']!, _totalRepsMeta),
      );
    }
    if (data.containsKey('total_volume')) {
      context.handle(
        _totalVolumeMeta,
        totalVolume.isAcceptableOrUnknown(
          data['total_volume']!,
          _totalVolumeMeta,
        ),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Workout map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Workout(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      programId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}program_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      startedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}started_at'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      totalSets: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_sets'],
      )!,
      totalReps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_reps'],
      )!,
      totalVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_volume'],
      )!,
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $WorkoutsTable createAlias(String alias) {
    return $WorkoutsTable(attachedDatabase, alias);
  }
}

class Workout extends DataClass implements Insertable<Workout> {
  final String id;
  final String userId;
  final String? programId;
  final String name;
  final String? notes;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final int totalSets;
  final int totalReps;
  final double totalVolume;
  final int? durationMinutes;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const Workout({
    required this.id,
    required this.userId,
    this.programId,
    required this.name,
    this.notes,
    this.startedAt,
    this.completedAt,
    required this.totalSets,
    required this.totalReps,
    required this.totalVolume,
    this.durationMinutes,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || programId != null) {
      map['program_id'] = Variable<String>(programId);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || startedAt != null) {
      map['started_at'] = Variable<DateTime>(startedAt);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['total_sets'] = Variable<int>(totalSets);
    map['total_reps'] = Variable<int>(totalReps);
    map['total_volume'] = Variable<double>(totalVolume);
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  WorkoutsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutsCompanion(
      id: Value(id),
      userId: Value(userId),
      programId: programId == null && nullToAbsent
          ? const Value.absent()
          : Value(programId),
      name: Value(name),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      startedAt: startedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(startedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      totalSets: Value(totalSets),
      totalReps: Value(totalReps),
      totalVolume: Value(totalVolume),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      status: Value(status),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory Workout.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Workout(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      programId: serializer.fromJson<String?>(json['programId']),
      name: serializer.fromJson<String>(json['name']),
      notes: serializer.fromJson<String?>(json['notes']),
      startedAt: serializer.fromJson<DateTime?>(json['startedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      totalSets: serializer.fromJson<int>(json['totalSets']),
      totalReps: serializer.fromJson<int>(json['totalReps']),
      totalVolume: serializer.fromJson<double>(json['totalVolume']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'programId': serializer.toJson<String?>(programId),
      'name': serializer.toJson<String>(name),
      'notes': serializer.toJson<String?>(notes),
      'startedAt': serializer.toJson<DateTime?>(startedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'totalSets': serializer.toJson<int>(totalSets),
      'totalReps': serializer.toJson<int>(totalReps),
      'totalVolume': serializer.toJson<double>(totalVolume),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  Workout copyWith({
    String? id,
    String? userId,
    Value<String?> programId = const Value.absent(),
    String? name,
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> startedAt = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    int? totalSets,
    int? totalReps,
    double? totalVolume,
    Value<int?> durationMinutes = const Value.absent(),
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => Workout(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    programId: programId.present ? programId.value : this.programId,
    name: name ?? this.name,
    notes: notes.present ? notes.value : this.notes,
    startedAt: startedAt.present ? startedAt.value : this.startedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    totalSets: totalSets ?? this.totalSets,
    totalReps: totalReps ?? this.totalReps,
    totalVolume: totalVolume ?? this.totalVolume,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  Workout copyWithCompanion(WorkoutsCompanion data) {
    return Workout(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      programId: data.programId.present ? data.programId.value : this.programId,
      name: data.name.present ? data.name.value : this.name,
      notes: data.notes.present ? data.notes.value : this.notes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      totalSets: data.totalSets.present ? data.totalSets.value : this.totalSets,
      totalReps: data.totalReps.present ? data.totalReps.value : this.totalReps,
      totalVolume: data.totalVolume.present
          ? data.totalVolume.value
          : this.totalVolume,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Workout(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('programId: $programId, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('totalSets: $totalSets, ')
          ..write('totalReps: $totalReps, ')
          ..write('totalVolume: $totalVolume, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    programId,
    name,
    notes,
    startedAt,
    completedAt,
    totalSets,
    totalReps,
    totalVolume,
    durationMinutes,
    status,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Workout &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.programId == this.programId &&
          other.name == this.name &&
          other.notes == this.notes &&
          other.startedAt == this.startedAt &&
          other.completedAt == this.completedAt &&
          other.totalSets == this.totalSets &&
          other.totalReps == this.totalReps &&
          other.totalVolume == this.totalVolume &&
          other.durationMinutes == this.durationMinutes &&
          other.status == this.status &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class WorkoutsCompanion extends UpdateCompanion<Workout> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> programId;
  final Value<String> name;
  final Value<String?> notes;
  final Value<DateTime?> startedAt;
  final Value<DateTime?> completedAt;
  final Value<int> totalSets;
  final Value<int> totalReps;
  final Value<double> totalVolume;
  final Value<int?> durationMinutes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const WorkoutsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.programId = const Value.absent(),
    this.name = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.totalSets = const Value.absent(),
    this.totalReps = const Value.absent(),
    this.totalVolume = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutsCompanion.insert({
    required String id,
    required String userId,
    this.programId = const Value.absent(),
    required String name,
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.totalSets = const Value.absent(),
    this.totalReps = const Value.absent(),
    this.totalVolume = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name);
  static Insertable<Workout> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? programId,
    Expression<String>? name,
    Expression<String>? notes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? totalSets,
    Expression<int>? totalReps,
    Expression<double>? totalVolume,
    Expression<int>? durationMinutes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (programId != null) 'program_id': programId,
      if (name != null) 'name': name,
      if (notes != null) 'notes': notes,
      if (startedAt != null) 'started_at': startedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (totalSets != null) 'total_sets': totalSets,
      if (totalReps != null) 'total_reps': totalReps,
      if (totalVolume != null) 'total_volume': totalVolume,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutsCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? programId,
    Value<String>? name,
    Value<String?>? notes,
    Value<DateTime?>? startedAt,
    Value<DateTime?>? completedAt,
    Value<int>? totalSets,
    Value<int>? totalReps,
    Value<double>? totalVolume,
    Value<int?>? durationMinutes,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return WorkoutsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      programId: programId ?? this.programId,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      totalSets: totalSets ?? this.totalSets,
      totalReps: totalReps ?? this.totalReps,
      totalVolume: totalVolume ?? this.totalVolume,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (programId.present) {
      map['program_id'] = Variable<String>(programId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (totalSets.present) {
      map['total_sets'] = Variable<int>(totalSets.value);
    }
    if (totalReps.present) {
      map['total_reps'] = Variable<int>(totalReps.value);
    }
    if (totalVolume.present) {
      map['total_volume'] = Variable<double>(totalVolume.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('programId: $programId, ')
          ..write('name: $name, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('totalSets: $totalSets, ')
          ..write('totalReps: $totalReps, ')
          ..write('totalVolume: $totalVolume, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutSetsTable extends WorkoutSets
    with TableInfo<$WorkoutSetsTable, WorkoutSet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutSetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _workoutIdMeta = const VerificationMeta(
    'workoutId',
  );
  @override
  late final GeneratedColumn<String> workoutId = GeneratedColumn<String>(
    'workout_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _setNumberMeta = const VerificationMeta(
    'setNumber',
  );
  @override
  late final GeneratedColumn<int> setNumber = GeneratedColumn<int>(
    'set_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
    'reps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
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
  static const VerificationMeta _rpeMeta = const VerificationMeta('rpe');
  @override
  late final GeneratedColumn<double> rpe = GeneratedColumn<double>(
    'rpe',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _restSecondsMeta = const VerificationMeta(
    'restSeconds',
  );
  @override
  late final GeneratedColumn<int> restSeconds = GeneratedColumn<int>(
    'rest_seconds',
    aliasedName,
    true,
    type: DriftSqlType.int,
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
  static const VerificationMeta _isCompletedMeta = const VerificationMeta(
    'isCompleted',
  );
  @override
  late final GeneratedColumn<bool> isCompleted = GeneratedColumn<bool>(
    'is_completed',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_completed" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    workoutId,
    exerciseId,
    setNumber,
    reps,
    weight,
    rpe,
    restSeconds,
    notes,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_sets';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutSet> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('workout_id')) {
      context.handle(
        _workoutIdMeta,
        workoutId.isAcceptableOrUnknown(data['workout_id']!, _workoutIdMeta),
      );
    } else if (isInserting) {
      context.missing(_workoutIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('set_number')) {
      context.handle(
        _setNumberMeta,
        setNumber.isAcceptableOrUnknown(data['set_number']!, _setNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_setNumberMeta);
    }
    if (data.containsKey('reps')) {
      context.handle(
        _repsMeta,
        reps.isAcceptableOrUnknown(data['reps']!, _repsMeta),
      );
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(
        _weightMeta,
        weight.isAcceptableOrUnknown(data['weight']!, _weightMeta),
      );
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('rpe')) {
      context.handle(
        _rpeMeta,
        rpe.isAcceptableOrUnknown(data['rpe']!, _rpeMeta),
      );
    }
    if (data.containsKey('rest_seconds')) {
      context.handle(
        _restSecondsMeta,
        restSeconds.isAcceptableOrUnknown(
          data['rest_seconds']!,
          _restSecondsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('is_completed')) {
      context.handle(
        _isCompletedMeta,
        isCompleted.isAcceptableOrUnknown(
          data['is_completed']!,
          _isCompletedMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutSet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutSet(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      workoutId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}workout_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      setNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}set_number'],
      )!,
      reps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reps'],
      )!,
      weight: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight'],
      )!,
      rpe: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpe'],
      ),
      restSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rest_seconds'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      isCompleted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_completed'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $WorkoutSetsTable createAlias(String alias) {
    return $WorkoutSetsTable(attachedDatabase, alias);
  }
}

class WorkoutSet extends DataClass implements Insertable<WorkoutSet> {
  final String id;
  final String workoutId;
  final String exerciseId;
  final int setNumber;
  final int reps;
  final double weight;
  final double? rpe;
  final int? restSeconds;
  final String? notes;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const WorkoutSet({
    required this.id,
    required this.workoutId,
    required this.exerciseId,
    required this.setNumber,
    required this.reps,
    required this.weight,
    this.rpe,
    this.restSeconds,
    this.notes,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['workout_id'] = Variable<String>(workoutId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['set_number'] = Variable<int>(setNumber);
    map['reps'] = Variable<int>(reps);
    map['weight'] = Variable<double>(weight);
    if (!nullToAbsent || rpe != null) {
      map['rpe'] = Variable<double>(rpe);
    }
    if (!nullToAbsent || restSeconds != null) {
      map['rest_seconds'] = Variable<int>(restSeconds);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['is_completed'] = Variable<bool>(isCompleted);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  WorkoutSetsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutSetsCompanion(
      id: Value(id),
      workoutId: Value(workoutId),
      exerciseId: Value(exerciseId),
      setNumber: Value(setNumber),
      reps: Value(reps),
      weight: Value(weight),
      rpe: rpe == null && nullToAbsent ? const Value.absent() : Value(rpe),
      restSeconds: restSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(restSeconds),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      isCompleted: Value(isCompleted),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory WorkoutSet.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutSet(
      id: serializer.fromJson<String>(json['id']),
      workoutId: serializer.fromJson<String>(json['workoutId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      setNumber: serializer.fromJson<int>(json['setNumber']),
      reps: serializer.fromJson<int>(json['reps']),
      weight: serializer.fromJson<double>(json['weight']),
      rpe: serializer.fromJson<double?>(json['rpe']),
      restSeconds: serializer.fromJson<int?>(json['restSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      isCompleted: serializer.fromJson<bool>(json['isCompleted']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'workoutId': serializer.toJson<String>(workoutId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'setNumber': serializer.toJson<int>(setNumber),
      'reps': serializer.toJson<int>(reps),
      'weight': serializer.toJson<double>(weight),
      'rpe': serializer.toJson<double?>(rpe),
      'restSeconds': serializer.toJson<int?>(restSeconds),
      'notes': serializer.toJson<String?>(notes),
      'isCompleted': serializer.toJson<bool>(isCompleted),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  WorkoutSet copyWith({
    String? id,
    String? workoutId,
    String? exerciseId,
    int? setNumber,
    int? reps,
    double? weight,
    Value<double?> rpe = const Value.absent(),
    Value<int?> restSeconds = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    bool? isCompleted,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => WorkoutSet(
    id: id ?? this.id,
    workoutId: workoutId ?? this.workoutId,
    exerciseId: exerciseId ?? this.exerciseId,
    setNumber: setNumber ?? this.setNumber,
    reps: reps ?? this.reps,
    weight: weight ?? this.weight,
    rpe: rpe.present ? rpe.value : this.rpe,
    restSeconds: restSeconds.present ? restSeconds.value : this.restSeconds,
    notes: notes.present ? notes.value : this.notes,
    isCompleted: isCompleted ?? this.isCompleted,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  WorkoutSet copyWithCompanion(WorkoutSetsCompanion data) {
    return WorkoutSet(
      id: data.id.present ? data.id.value : this.id,
      workoutId: data.workoutId.present ? data.workoutId.value : this.workoutId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      setNumber: data.setNumber.present ? data.setNumber.value : this.setNumber,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      rpe: data.rpe.present ? data.rpe.value : this.rpe,
      restSeconds: data.restSeconds.present
          ? data.restSeconds.value
          : this.restSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      isCompleted: data.isCompleted.present
          ? data.isCompleted.value
          : this.isCompleted,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSet(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('rpe: $rpe, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    workoutId,
    exerciseId,
    setNumber,
    reps,
    weight,
    rpe,
    restSeconds,
    notes,
    isCompleted,
    completedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutSet &&
          other.id == this.id &&
          other.workoutId == this.workoutId &&
          other.exerciseId == this.exerciseId &&
          other.setNumber == this.setNumber &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.rpe == this.rpe &&
          other.restSeconds == this.restSeconds &&
          other.notes == this.notes &&
          other.isCompleted == this.isCompleted &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class WorkoutSetsCompanion extends UpdateCompanion<WorkoutSet> {
  final Value<String> id;
  final Value<String> workoutId;
  final Value<String> exerciseId;
  final Value<int> setNumber;
  final Value<int> reps;
  final Value<double> weight;
  final Value<double?> rpe;
  final Value<int?> restSeconds;
  final Value<String?> notes;
  final Value<bool> isCompleted;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const WorkoutSetsCompanion({
    this.id = const Value.absent(),
    this.workoutId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.setNumber = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.rpe = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutSetsCompanion.insert({
    required String id,
    required String workoutId,
    required String exerciseId,
    required int setNumber,
    required int reps,
    required double weight,
    this.rpe = const Value.absent(),
    this.restSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.isCompleted = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       workoutId = Value(workoutId),
       exerciseId = Value(exerciseId),
       setNumber = Value(setNumber),
       reps = Value(reps),
       weight = Value(weight);
  static Insertable<WorkoutSet> custom({
    Expression<String>? id,
    Expression<String>? workoutId,
    Expression<String>? exerciseId,
    Expression<int>? setNumber,
    Expression<int>? reps,
    Expression<double>? weight,
    Expression<double>? rpe,
    Expression<int>? restSeconds,
    Expression<String>? notes,
    Expression<bool>? isCompleted,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (workoutId != null) 'workout_id': workoutId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (setNumber != null) 'set_number': setNumber,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (rpe != null) 'rpe': rpe,
      if (restSeconds != null) 'rest_seconds': restSeconds,
      if (notes != null) 'notes': notes,
      if (isCompleted != null) 'is_completed': isCompleted,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutSetsCompanion copyWith({
    Value<String>? id,
    Value<String>? workoutId,
    Value<String>? exerciseId,
    Value<int>? setNumber,
    Value<int>? reps,
    Value<double>? weight,
    Value<double?>? rpe,
    Value<int?>? restSeconds,
    Value<String?>? notes,
    Value<bool>? isCompleted,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return WorkoutSetsCompanion(
      id: id ?? this.id,
      workoutId: workoutId ?? this.workoutId,
      exerciseId: exerciseId ?? this.exerciseId,
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      rpe: rpe ?? this.rpe,
      restSeconds: restSeconds ?? this.restSeconds,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (workoutId.present) {
      map['workout_id'] = Variable<String>(workoutId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (setNumber.present) {
      map['set_number'] = Variable<int>(setNumber.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (rpe.present) {
      map['rpe'] = Variable<double>(rpe.value);
    }
    if (restSeconds.present) {
      map['rest_seconds'] = Variable<int>(restSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (isCompleted.present) {
      map['is_completed'] = Variable<bool>(isCompleted.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutSetsCompanion(')
          ..write('id: $id, ')
          ..write('workoutId: $workoutId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('setNumber: $setNumber, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('rpe: $rpe, ')
          ..write('restSeconds: $restSeconds, ')
          ..write('notes: $notes, ')
          ..write('isCompleted: $isCompleted, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProgressEntriesTable extends ProgressEntries
    with TableInfo<$ProgressEntriesTable, ProgressEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProgressEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyPartMeta = const VerificationMeta(
    'bodyPart',
  );
  @override
  late final GeneratedColumn<String> bodyPart = GeneratedColumn<String>(
    'body_part',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
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
  static const VerificationMeta _photoUrlMeta = const VerificationMeta(
    'photoUrl',
  );
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
    'photo_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _versionMeta = const VerificationMeta(
    'version',
  );
  @override
  late final GeneratedColumn<int> version = GeneratedColumn<int>(
    'version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _syncStatusMeta = const VerificationMeta(
    'syncStatus',
  );
  @override
  late final GeneratedColumn<String> syncStatus = GeneratedColumn<String>(
    'sync_status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 20,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('local'),
  );
  static const VerificationMeta _deletedAtMeta = const VerificationMeta(
    'deletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
    'deleted_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    type,
    exerciseId,
    value,
    unit,
    bodyPart,
    notes,
    photoUrl,
    recordedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'progress_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProgressEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('body_part')) {
      context.handle(
        _bodyPartMeta,
        bodyPart.isAcceptableOrUnknown(data['body_part']!, _bodyPartMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo_url')) {
      context.handle(
        _photoUrlMeta,
        photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('version')) {
      context.handle(
        _versionMeta,
        version.isAcceptableOrUnknown(data['version']!, _versionMeta),
      );
    }
    if (data.containsKey('sync_status')) {
      context.handle(
        _syncStatusMeta,
        syncStatus.isAcceptableOrUnknown(data['sync_status']!, _syncStatusMeta),
      );
    }
    if (data.containsKey('deleted_at')) {
      context.handle(
        _deletedAtMeta,
        deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProgressEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProgressEntry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      ),
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      bodyPart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body_part'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photoUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_url'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      version: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}version'],
      )!,
      syncStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_status'],
      )!,
      deletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deleted_at'],
      ),
    );
  }

  @override
  $ProgressEntriesTable createAlias(String alias) {
    return $ProgressEntriesTable(attachedDatabase, alias);
  }
}

class ProgressEntry extends DataClass implements Insertable<ProgressEntry> {
  final String id;
  final String userId;
  final String type;
  final String? exerciseId;
  final double value;
  final String unit;
  final String? bodyPart;
  final String? notes;
  final String? photoUrl;
  final DateTime recordedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int version;
  final String syncStatus;
  final DateTime? deletedAt;
  const ProgressEntry({
    required this.id,
    required this.userId,
    required this.type,
    this.exerciseId,
    required this.value,
    required this.unit,
    this.bodyPart,
    this.notes,
    this.photoUrl,
    required this.recordedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
    required this.syncStatus,
    this.deletedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || exerciseId != null) {
      map['exercise_id'] = Variable<String>(exerciseId);
    }
    map['value'] = Variable<double>(value);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || bodyPart != null) {
      map['body_part'] = Variable<String>(bodyPart);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['version'] = Variable<int>(version);
    map['sync_status'] = Variable<String>(syncStatus);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  ProgressEntriesCompanion toCompanion(bool nullToAbsent) {
    return ProgressEntriesCompanion(
      id: Value(id),
      userId: Value(userId),
      type: Value(type),
      exerciseId: exerciseId == null && nullToAbsent
          ? const Value.absent()
          : Value(exerciseId),
      value: Value(value),
      unit: Value(unit),
      bodyPart: bodyPart == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyPart),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      recordedAt: Value(recordedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      version: Value(version),
      syncStatus: Value(syncStatus),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory ProgressEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProgressEntry(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      type: serializer.fromJson<String>(json['type']),
      exerciseId: serializer.fromJson<String?>(json['exerciseId']),
      value: serializer.fromJson<double>(json['value']),
      unit: serializer.fromJson<String>(json['unit']),
      bodyPart: serializer.fromJson<String?>(json['bodyPart']),
      notes: serializer.fromJson<String?>(json['notes']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      version: serializer.fromJson<int>(json['version']),
      syncStatus: serializer.fromJson<String>(json['syncStatus']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'type': serializer.toJson<String>(type),
      'exerciseId': serializer.toJson<String?>(exerciseId),
      'value': serializer.toJson<double>(value),
      'unit': serializer.toJson<String>(unit),
      'bodyPart': serializer.toJson<String?>(bodyPart),
      'notes': serializer.toJson<String?>(notes),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'version': serializer.toJson<int>(version),
      'syncStatus': serializer.toJson<String>(syncStatus),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  ProgressEntry copyWith({
    String? id,
    String? userId,
    String? type,
    Value<String?> exerciseId = const Value.absent(),
    double? value,
    String? unit,
    Value<String?> bodyPart = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> photoUrl = const Value.absent(),
    DateTime? recordedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
    String? syncStatus,
    Value<DateTime?> deletedAt = const Value.absent(),
  }) => ProgressEntry(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    type: type ?? this.type,
    exerciseId: exerciseId.present ? exerciseId.value : this.exerciseId,
    value: value ?? this.value,
    unit: unit ?? this.unit,
    bodyPart: bodyPart.present ? bodyPart.value : this.bodyPart,
    notes: notes.present ? notes.value : this.notes,
    photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
    recordedAt: recordedAt ?? this.recordedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    version: version ?? this.version,
    syncStatus: syncStatus ?? this.syncStatus,
    deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
  );
  ProgressEntry copyWithCompanion(ProgressEntriesCompanion data) {
    return ProgressEntry(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      type: data.type.present ? data.type.value : this.type,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      value: data.value.present ? data.value.value : this.value,
      unit: data.unit.present ? data.unit.value : this.unit,
      bodyPart: data.bodyPart.present ? data.bodyPart.value : this.bodyPart,
      notes: data.notes.present ? data.notes.value : this.notes,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      version: data.version.present ? data.version.value : this.version,
      syncStatus: data.syncStatus.present
          ? data.syncStatus.value
          : this.syncStatus,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProgressEntry(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    type,
    exerciseId,
    value,
    unit,
    bodyPart,
    notes,
    photoUrl,
    recordedAt,
    createdAt,
    updatedAt,
    version,
    syncStatus,
    deletedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProgressEntry &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.type == this.type &&
          other.exerciseId == this.exerciseId &&
          other.value == this.value &&
          other.unit == this.unit &&
          other.bodyPart == this.bodyPart &&
          other.notes == this.notes &&
          other.photoUrl == this.photoUrl &&
          other.recordedAt == this.recordedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.version == this.version &&
          other.syncStatus == this.syncStatus &&
          other.deletedAt == this.deletedAt);
}

class ProgressEntriesCompanion extends UpdateCompanion<ProgressEntry> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> type;
  final Value<String?> exerciseId;
  final Value<double> value;
  final Value<String> unit;
  final Value<String?> bodyPart;
  final Value<String?> notes;
  final Value<String?> photoUrl;
  final Value<DateTime> recordedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> version;
  final Value<String> syncStatus;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const ProgressEntriesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.type = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.value = const Value.absent(),
    this.unit = const Value.absent(),
    this.bodyPart = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProgressEntriesCompanion.insert({
    required String id,
    required String userId,
    required String type,
    this.exerciseId = const Value.absent(),
    required double value,
    required String unit,
    this.bodyPart = const Value.absent(),
    this.notes = const Value.absent(),
    this.photoUrl = const Value.absent(),
    required DateTime recordedAt,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.version = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       type = Value(type),
       value = Value(value),
       unit = Value(unit),
       recordedAt = Value(recordedAt);
  static Insertable<ProgressEntry> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? type,
    Expression<String>? exerciseId,
    Expression<double>? value,
    Expression<String>? unit,
    Expression<String>? bodyPart,
    Expression<String>? notes,
    Expression<String>? photoUrl,
    Expression<DateTime>? recordedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? version,
    Expression<String>? syncStatus,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (type != null) 'type': type,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (value != null) 'value': value,
      if (unit != null) 'unit': unit,
      if (bodyPart != null) 'body_part': bodyPart,
      if (notes != null) 'notes': notes,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (version != null) 'version': version,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProgressEntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? type,
    Value<String?>? exerciseId,
    Value<double>? value,
    Value<String>? unit,
    Value<String?>? bodyPart,
    Value<String?>? notes,
    Value<String?>? photoUrl,
    Value<DateTime>? recordedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? version,
    Value<String>? syncStatus,
    Value<DateTime?>? deletedAt,
    Value<int>? rowid,
  }) {
    return ProgressEntriesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      exerciseId: exerciseId ?? this.exerciseId,
      value: value ?? this.value,
      unit: unit ?? this.unit,
      bodyPart: bodyPart ?? this.bodyPart,
      notes: notes ?? this.notes,
      photoUrl: photoUrl ?? this.photoUrl,
      recordedAt: recordedAt ?? this.recordedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
      syncStatus: syncStatus ?? this.syncStatus,
      deletedAt: deletedAt ?? this.deletedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (bodyPart.present) {
      map['body_part'] = Variable<String>(bodyPart.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (version.present) {
      map['version'] = Variable<int>(version.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(syncStatus.value);
    }
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProgressEntriesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('type: $type, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('value: $value, ')
          ..write('unit: $unit, ')
          ..write('bodyPart: $bodyPart, ')
          ..write('notes: $notes, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('version: $version, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EquipmentTable extends Equipment
    with TableInfo<$EquipmentTable, EquipmentData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquipmentTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _equipmentIdMeta = const VerificationMeta(
    'equipmentId',
  );
  @override
  late final GeneratedColumn<String> equipmentId = GeneratedColumn<String>(
    'equipment_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    equipmentId,
    name,
    description,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipment';
  @override
  VerificationContext validateIntegrity(
    Insertable<EquipmentData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('equipment_id')) {
      context.handle(
        _equipmentIdMeta,
        equipmentId.isAcceptableOrUnknown(
          data['equipment_id']!,
          _equipmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_equipmentIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EquipmentData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EquipmentData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      equipmentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}equipment_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EquipmentTable createAlias(String alias) {
    return $EquipmentTable(attachedDatabase, alias);
  }
}

class EquipmentData extends DataClass implements Insertable<EquipmentData> {
  final String id;
  final String equipmentId;
  final String name;
  final String? description;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EquipmentData({
    required this.id,
    required this.equipmentId,
    required this.name,
    this.description,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['equipment_id'] = Variable<String>(equipmentId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EquipmentCompanion toCompanion(bool nullToAbsent) {
    return EquipmentCompanion(
      id: Value(id),
      equipmentId: Value(equipmentId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EquipmentData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EquipmentData(
      id: serializer.fromJson<String>(json['id']),
      equipmentId: serializer.fromJson<String>(json['equipmentId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'equipmentId': serializer.toJson<String>(equipmentId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EquipmentData copyWith({
    String? id,
    String? equipmentId,
    String? name,
    Value<String?> description = const Value.absent(),
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EquipmentData(
    id: id ?? this.id,
    equipmentId: equipmentId ?? this.equipmentId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EquipmentData copyWithCompanion(EquipmentCompanion data) {
    return EquipmentData(
      id: data.id.present ? data.id.value : this.id,
      equipmentId: data.equipmentId.present
          ? data.equipmentId.value
          : this.equipmentId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentData(')
          ..write('id: $id, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    equipmentId,
    name,
    description,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EquipmentData &&
          other.id == this.id &&
          other.equipmentId == this.equipmentId &&
          other.name == this.name &&
          other.description == this.description &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EquipmentCompanion extends UpdateCompanion<EquipmentData> {
  final Value<String> id;
  final Value<String> equipmentId;
  final Value<String> name;
  final Value<String?> description;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EquipmentCompanion({
    this.id = const Value.absent(),
    this.equipmentId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EquipmentCompanion.insert({
    required String id,
    required String equipmentId,
    required String name,
    this.description = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       equipmentId = Value(equipmentId),
       name = Value(name);
  static Insertable<EquipmentData> custom({
    Expression<String>? id,
    Expression<String>? equipmentId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipmentId != null) 'equipment_id': equipmentId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EquipmentCompanion copyWith({
    Value<String>? id,
    Value<String>? equipmentId,
    Value<String>? name,
    Value<String?>? description,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EquipmentCompanion(
      id: id ?? this.id,
      equipmentId: equipmentId ?? this.equipmentId,
      name: name ?? this.name,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (equipmentId.present) {
      map['equipment_id'] = Variable<String>(equipmentId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquipmentCompanion(')
          ..write('id: $id, ')
          ..write('equipmentId: $equipmentId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseCategoriesTable extends ExerciseCategories
    with TableInfo<$ExerciseCategoriesTable, ExerciseCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<String> color = GeneratedColumn<String>(
    'color',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 10,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoryId,
    name,
    description,
    color,
    icon,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_categories';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseCategory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseCategory(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color'],
      ),
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExerciseCategoriesTable createAlias(String alias) {
    return $ExerciseCategoriesTable(attachedDatabase, alias);
  }
}

class ExerciseCategory extends DataClass
    implements Insertable<ExerciseCategory> {
  final String id;
  final String categoryId;
  final String name;
  final String? description;
  final String? color;
  final String? icon;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExerciseCategory({
    required this.id,
    required this.categoryId,
    required this.name,
    this.description,
    this.color,
    this.icon,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category_id'] = Variable<String>(categoryId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || color != null) {
      map['color'] = Variable<String>(color);
    }
    if (!nullToAbsent || icon != null) {
      map['icon'] = Variable<String>(icon);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExerciseCategoriesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseCategoriesCompanion(
      id: Value(id),
      categoryId: Value(categoryId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      color: color == null && nullToAbsent
          ? const Value.absent()
          : Value(color),
      icon: icon == null && nullToAbsent ? const Value.absent() : Value(icon),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExerciseCategory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseCategory(
      id: serializer.fromJson<String>(json['id']),
      categoryId: serializer.fromJson<String>(json['categoryId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      color: serializer.fromJson<String?>(json['color']),
      icon: serializer.fromJson<String?>(json['icon']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoryId': serializer.toJson<String>(categoryId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'color': serializer.toJson<String?>(color),
      'icon': serializer.toJson<String?>(icon),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExerciseCategory copyWith({
    String? id,
    String? categoryId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> color = const Value.absent(),
    Value<String?> icon = const Value.absent(),
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExerciseCategory(
    id: id ?? this.id,
    categoryId: categoryId ?? this.categoryId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    color: color.present ? color.value : this.color,
    icon: icon.present ? icon.value : this.icon,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExerciseCategory copyWithCompanion(ExerciseCategoriesCompanion data) {
    return ExerciseCategory(
      id: data.id.present ? data.id.value : this.id,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      color: data.color.present ? data.color.value : this.color,
      icon: data.icon.present ? data.icon.value : this.icon,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategory(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoryId,
    name,
    description,
    color,
    icon,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseCategory &&
          other.id == this.id &&
          other.categoryId == this.categoryId &&
          other.name == this.name &&
          other.description == this.description &&
          other.color == this.color &&
          other.icon == this.icon &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExerciseCategoriesCompanion extends UpdateCompanion<ExerciseCategory> {
  final Value<String> id;
  final Value<String> categoryId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> color;
  final Value<String?> icon;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExerciseCategoriesCompanion({
    this.id = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseCategoriesCompanion.insert({
    required String id,
    required String categoryId,
    required String name,
    this.description = const Value.absent(),
    this.color = const Value.absent(),
    this.icon = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoryId = Value(categoryId),
       name = Value(name);
  static Insertable<ExerciseCategory> custom({
    Expression<String>? id,
    Expression<String>? categoryId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? color,
    Expression<String>? icon,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoryId != null) 'category_id': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (color != null) 'color': color,
      if (icon != null) 'icon': icon,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseCategoriesCompanion copyWith({
    Value<String>? id,
    Value<String>? categoryId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? color,
    Value<String?>? icon,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExerciseCategoriesCompanion(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      name: name ?? this.name,
      description: description ?? this.description,
      color: color ?? this.color,
      icon: icon ?? this.icon,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (color.present) {
      map['color'] = Variable<String>(color.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('categoryId: $categoryId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('color: $color, ')
          ..write('icon: $icon, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalProgressTable extends GoalProgress
    with TableInfo<$GoalProgressTable, GoalProgressData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalProgressTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
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
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _recordedAtMeta = const VerificationMeta(
    'recordedAt',
  );
  @override
  late final GeneratedColumn<DateTime> recordedAt = GeneratedColumn<DateTime>(
    'recorded_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalId,
    value,
    notes,
    recordedAt,
    userId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_progress';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalProgressData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('recorded_at')) {
      context.handle(
        _recordedAtMeta,
        recordedAt.isAcceptableOrUnknown(data['recorded_at']!, _recordedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalProgressData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalProgressData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      recordedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}recorded_at'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $GoalProgressTable createAlias(String alias) {
    return $GoalProgressTable(attachedDatabase, alias);
  }
}

class GoalProgressData extends DataClass
    implements Insertable<GoalProgressData> {
  final String id;
  final String goalId;
  final double value;
  final String? notes;
  final DateTime recordedAt;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const GoalProgressData({
    required this.id,
    required this.goalId,
    required this.value,
    this.notes,
    required this.recordedAt,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['value'] = Variable<double>(value);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['recorded_at'] = Variable<DateTime>(recordedAt);
    map['user_id'] = Variable<String>(userId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  GoalProgressCompanion toCompanion(bool nullToAbsent) {
    return GoalProgressCompanion(
      id: Value(id),
      goalId: Value(goalId),
      value: Value(value),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      recordedAt: Value(recordedAt),
      userId: Value(userId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory GoalProgressData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalProgressData(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      value: serializer.fromJson<double>(json['value']),
      notes: serializer.fromJson<String?>(json['notes']),
      recordedAt: serializer.fromJson<DateTime>(json['recordedAt']),
      userId: serializer.fromJson<String>(json['userId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'value': serializer.toJson<double>(value),
      'notes': serializer.toJson<String?>(notes),
      'recordedAt': serializer.toJson<DateTime>(recordedAt),
      'userId': serializer.toJson<String>(userId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  GoalProgressData copyWith({
    String? id,
    String? goalId,
    double? value,
    Value<String?> notes = const Value.absent(),
    DateTime? recordedAt,
    String? userId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => GoalProgressData(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    value: value ?? this.value,
    notes: notes.present ? notes.value : this.notes,
    recordedAt: recordedAt ?? this.recordedAt,
    userId: userId ?? this.userId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  GoalProgressData copyWithCompanion(GoalProgressCompanion data) {
    return GoalProgressData(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      value: data.value.present ? data.value.value : this.value,
      notes: data.notes.present ? data.notes.value : this.notes,
      recordedAt: data.recordedAt.present
          ? data.recordedAt.value
          : this.recordedAt,
      userId: data.userId.present ? data.userId.value : this.userId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalProgressData(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('value: $value, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    goalId,
    value,
    notes,
    recordedAt,
    userId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalProgressData &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.value == this.value &&
          other.notes == this.notes &&
          other.recordedAt == this.recordedAt &&
          other.userId == this.userId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class GoalProgressCompanion extends UpdateCompanion<GoalProgressData> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<double> value;
  final Value<String?> notes;
  final Value<DateTime> recordedAt;
  final Value<String> userId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const GoalProgressCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.value = const Value.absent(),
    this.notes = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.userId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalProgressCompanion.insert({
    required String id,
    required String goalId,
    required double value,
    this.notes = const Value.absent(),
    required DateTime recordedAt,
    required String userId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       value = Value(value),
       recordedAt = Value(recordedAt),
       userId = Value(userId);
  static Insertable<GoalProgressData> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<double>? value,
    Expression<String>? notes,
    Expression<DateTime>? recordedAt,
    Expression<String>? userId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (value != null) 'value': value,
      if (notes != null) 'notes': notes,
      if (recordedAt != null) 'recorded_at': recordedAt,
      if (userId != null) 'user_id': userId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalProgressCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<double>? value,
    Value<String?>? notes,
    Value<DateTime>? recordedAt,
    Value<String>? userId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return GoalProgressCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      value: value ?? this.value,
      notes: notes ?? this.notes,
      recordedAt: recordedAt ?? this.recordedAt,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (recordedAt.present) {
      map['recorded_at'] = Variable<DateTime>(recordedAt.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalProgressCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('value: $value, ')
          ..write('notes: $notes, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('userId: $userId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExerciseFavoritesTable extends ExerciseFavorites
    with TableInfo<$ExerciseFavoritesTable, ExerciseFavorite> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExerciseFavoritesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _exerciseIdMeta = const VerificationMeta(
    'exerciseId',
  );
  @override
  late final GeneratedColumn<String> exerciseId = GeneratedColumn<String>(
    'exercise_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    exerciseId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercise_favorites';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExerciseFavorite> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('exercise_id')) {
      context.handle(
        _exerciseIdMeta,
        exerciseId.isAcceptableOrUnknown(data['exercise_id']!, _exerciseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_exerciseIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ExerciseFavorite map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExerciseFavorite(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      exerciseId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}exercise_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ExerciseFavoritesTable createAlias(String alias) {
    return $ExerciseFavoritesTable(attachedDatabase, alias);
  }
}

class ExerciseFavorite extends DataClass
    implements Insertable<ExerciseFavorite> {
  final String id;
  final String userId;
  final String exerciseId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ExerciseFavorite({
    required this.id,
    required this.userId,
    required this.exerciseId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['exercise_id'] = Variable<String>(exerciseId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ExerciseFavoritesCompanion toCompanion(bool nullToAbsent) {
    return ExerciseFavoritesCompanion(
      id: Value(id),
      userId: Value(userId),
      exerciseId: Value(exerciseId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ExerciseFavorite.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExerciseFavorite(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      exerciseId: serializer.fromJson<String>(json['exerciseId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'exerciseId': serializer.toJson<String>(exerciseId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ExerciseFavorite copyWith({
    String? id,
    String? userId,
    String? exerciseId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ExerciseFavorite(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    exerciseId: exerciseId ?? this.exerciseId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ExerciseFavorite copyWithCompanion(ExerciseFavoritesCompanion data) {
    return ExerciseFavorite(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      exerciseId: data.exerciseId.present
          ? data.exerciseId.value
          : this.exerciseId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseFavorite(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, exerciseId, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExerciseFavorite &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.exerciseId == this.exerciseId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ExerciseFavoritesCompanion extends UpdateCompanion<ExerciseFavorite> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> exerciseId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ExerciseFavoritesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.exerciseId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExerciseFavoritesCompanion.insert({
    required String id,
    required String userId,
    required String exerciseId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       exerciseId = Value(exerciseId);
  static Insertable<ExerciseFavorite> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? exerciseId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (exerciseId != null) 'exercise_id': exerciseId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExerciseFavoritesCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? exerciseId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ExerciseFavoritesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      exerciseId: exerciseId ?? this.exerciseId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (exerciseId.present) {
      map['exercise_id'] = Variable<String>(exerciseId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExerciseFavoritesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('exerciseId: $exerciseId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $ProgramsTable programs = $ProgramsTable(this);
  late final $WorkoutsTable workouts = $WorkoutsTable(this);
  late final $WorkoutSetsTable workoutSets = $WorkoutSetsTable(this);
  late final $ProgressEntriesTable progressEntries = $ProgressEntriesTable(
    this,
  );
  late final $EquipmentTable equipment = $EquipmentTable(this);
  late final $ExerciseCategoriesTable exerciseCategories =
      $ExerciseCategoriesTable(this);
  late final $GoalProgressTable goalProgress = $GoalProgressTable(this);
  late final $ExerciseFavoritesTable exerciseFavorites =
      $ExerciseFavoritesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    goals,
    exercises,
    programs,
    workouts,
    workoutSets,
    progressEntries,
    equipment,
    exerciseCategories,
    goalProgress,
    exerciseFavorites,
  ];
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      required String id,
      required String email,
      required String firstName,
      required String lastName,
      Value<DateTime?> dateOfBirth,
      Value<String?> gender,
      Value<double?> height,
      Value<double?> weight,
      Value<String> experienceLevel,
      Value<String?> preferences,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<String> id,
      Value<String> email,
      Value<String> firstName,
      Value<String> lastName,
      Value<DateTime?> dateOfBirth,
      Value<String?> gender,
      Value<double?> height,
      Value<double?> weight,
      Value<String> experienceLevel,
      Value<String?> preferences,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get firstName => $composableBuilder(
    column: $table.firstName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastName => $composableBuilder(
    column: $table.lastName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gender => $composableBuilder(
    column: $table.gender,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get height => $composableBuilder(
    column: $table.height,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<DateTime> get dateOfBirth => $composableBuilder(
    column: $table.dateOfBirth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<String> get experienceLevel => $composableBuilder(
    column: $table.experienceLevel,
    builder: (column) => column,
  );

  GeneratedColumn<String> get preferences => $composableBuilder(
    column: $table.preferences,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> firstName = const Value.absent(),
                Value<String> lastName = const Value.absent(),
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String> experienceLevel = const Value.absent(),
                Value<String?> preferences = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                email: email,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                gender: gender,
                height: height,
                weight: weight,
                experienceLevel: experienceLevel,
                preferences: preferences,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String email,
                required String firstName,
                required String lastName,
                Value<DateTime?> dateOfBirth = const Value.absent(),
                Value<String?> gender = const Value.absent(),
                Value<double?> height = const Value.absent(),
                Value<double?> weight = const Value.absent(),
                Value<String> experienceLevel = const Value.absent(),
                Value<String?> preferences = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                email: email,
                firstName: firstName,
                lastName: lastName,
                dateOfBirth: dateOfBirth,
                gender: gender,
                height: height,
                weight: weight,
                experienceLevel: experienceLevel,
                preferences: preferences,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder =
    GoalsCompanion Function({
      required String id,
      required String userId,
      required String name,
      Value<String?> description,
      Value<String?> color,
      required String goalType,
      Value<String?> exerciseId,
      Value<String?> exerciseName,
      required double targetValue,
      Value<double> currentValue,
      required String unit,
      Value<DateTime?> startDate,
      Value<DateTime?> targetDate,
      Value<bool> isArchived,
      Value<int> displayOrder,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$GoalsTableUpdateCompanionBuilder =
    GoalsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<String?> color,
      Value<String> goalType,
      Value<String?> exerciseId,
      Value<String?> exerciseName,
      Value<double> targetValue,
      Value<double> currentValue,
      Value<String> unit,
      Value<DateTime?> startDate,
      Value<DateTime?> targetDate,
      Value<bool> isArchived,
      Value<int> displayOrder,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalType => $composableBuilder(
    column: $table.goalType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
    column: $table.startDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseName => $composableBuilder(
    column: $table.exerciseName,
    builder: (column) => column,
  );

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get currentValue => $composableBuilder(
    column: $table.currentValue,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<int> get displayOrder => $composableBuilder(
    column: $table.displayOrder,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
          Goal,
          PrefetchHooks Function()
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String> goalType = const Value.absent(),
                Value<String?> exerciseId = const Value.absent(),
                Value<String?> exerciseName = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<double> currentValue = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                color: color,
                goalType: goalType,
                exerciseId: exerciseId,
                exerciseName: exerciseName,
                targetValue: targetValue,
                currentValue: currentValue,
                unit: unit,
                startDate: startDate,
                targetDate: targetDate,
                isArchived: isArchived,
                displayOrder: displayOrder,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> color = const Value.absent(),
                required String goalType,
                Value<String?> exerciseId = const Value.absent(),
                Value<String?> exerciseName = const Value.absent(),
                required double targetValue,
                Value<double> currentValue = const Value.absent(),
                required String unit,
                Value<DateTime?> startDate = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<int> displayOrder = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                color: color,
                goalType: goalType,
                exerciseId: exerciseId,
                exerciseName: exerciseName,
                targetValue: targetValue,
                currentValue: currentValue,
                unit: unit,
                startDate: startDate,
                targetDate: targetDate,
                isArchived: isArchived,
                displayOrder: displayOrder,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, BaseReferences<_$AppDatabase, $GoalsTable, Goal>),
      Goal,
      PrefetchHooks Function()
    >;
typedef $$ExercisesTableCreateCompanionBuilder =
    ExercisesCompanion Function({
      required String id,
      required String exerciseId,
      required String name,
      required String defaultEquipment,
      Value<String?> availableEquipment,
      Value<String?> exerciseTypes,
      Value<String?> primaryMuscles,
      Value<String?> secondaryMuscles,
      Value<String?> bodyParts,
      Value<double?> startingWeightLbs,
      Value<double?> startingWeightKg,
      Value<double?> defaultWarmupWeight,
      Value<String?> description,
      Value<String?> instructions,
      Value<String?> tips,
      Value<String?> videoUrl,
      Value<String?> imageUrlSmall,
      Value<String?> imageUrlLarge,
      Value<bool> hasCustomImage,
      Value<int> difficultyLevel,
      Value<int> safetyRating,
      Value<bool> isCompound,
      Value<bool> isUnilateral,
      Value<bool> requiresSpotter,
      Value<bool> isActive,
      Value<bool> isCustom,
      Value<String?> createdBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ExercisesTableUpdateCompanionBuilder =
    ExercisesCompanion Function({
      Value<String> id,
      Value<String> exerciseId,
      Value<String> name,
      Value<String> defaultEquipment,
      Value<String?> availableEquipment,
      Value<String?> exerciseTypes,
      Value<String?> primaryMuscles,
      Value<String?> secondaryMuscles,
      Value<String?> bodyParts,
      Value<double?> startingWeightLbs,
      Value<double?> startingWeightKg,
      Value<double?> defaultWarmupWeight,
      Value<String?> description,
      Value<String?> instructions,
      Value<String?> tips,
      Value<String?> videoUrl,
      Value<String?> imageUrlSmall,
      Value<String?> imageUrlLarge,
      Value<bool> hasCustomImage,
      Value<int> difficultyLevel,
      Value<int> safetyRating,
      Value<bool> isCompound,
      Value<bool> isUnilateral,
      Value<bool> requiresSpotter,
      Value<bool> isActive,
      Value<bool> isCustom,
      Value<String?> createdBy,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$ExercisesTableFilterComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultEquipment => $composableBuilder(
    column: $table.defaultEquipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get availableEquipment => $composableBuilder(
    column: $table.availableEquipment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseTypes => $composableBuilder(
    column: $table.exerciseTypes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyParts => $composableBuilder(
    column: $table.bodyParts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startingWeightLbs => $composableBuilder(
    column: $table.startingWeightLbs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startingWeightKg => $composableBuilder(
    column: $table.startingWeightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultWarmupWeight => $composableBuilder(
    column: $table.defaultWarmupWeight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tips => $composableBuilder(
    column: $table.tips,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasCustomImage => $composableBuilder(
    column: $table.hasCustomImage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get safetyRating => $composableBuilder(
    column: $table.safetyRating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompound => $composableBuilder(
    column: $table.isCompound,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get requiresSpotter => $composableBuilder(
    column: $table.requiresSpotter,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExercisesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultEquipment => $composableBuilder(
    column: $table.defaultEquipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get availableEquipment => $composableBuilder(
    column: $table.availableEquipment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseTypes => $composableBuilder(
    column: $table.exerciseTypes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyParts => $composableBuilder(
    column: $table.bodyParts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startingWeightLbs => $composableBuilder(
    column: $table.startingWeightLbs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startingWeightKg => $composableBuilder(
    column: $table.startingWeightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultWarmupWeight => $composableBuilder(
    column: $table.defaultWarmupWeight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tips => $composableBuilder(
    column: $table.tips,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get videoUrl => $composableBuilder(
    column: $table.videoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasCustomImage => $composableBuilder(
    column: $table.hasCustomImage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get safetyRating => $composableBuilder(
    column: $table.safetyRating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompound => $composableBuilder(
    column: $table.isCompound,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get requiresSpotter => $composableBuilder(
    column: $table.requiresSpotter,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCustom => $composableBuilder(
    column: $table.isCustom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get createdBy => $composableBuilder(
    column: $table.createdBy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExercisesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get defaultEquipment => $composableBuilder(
    column: $table.defaultEquipment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get availableEquipment => $composableBuilder(
    column: $table.availableEquipment,
    builder: (column) => column,
  );

  GeneratedColumn<String> get exerciseTypes => $composableBuilder(
    column: $table.exerciseTypes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryMuscles => $composableBuilder(
    column: $table.primaryMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryMuscles => $composableBuilder(
    column: $table.secondaryMuscles,
    builder: (column) => column,
  );

  GeneratedColumn<String> get bodyParts =>
      $composableBuilder(column: $table.bodyParts, builder: (column) => column);

  GeneratedColumn<double> get startingWeightLbs => $composableBuilder(
    column: $table.startingWeightLbs,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startingWeightKg => $composableBuilder(
    column: $table.startingWeightKg,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultWarmupWeight => $composableBuilder(
    column: $table.defaultWarmupWeight,
    builder: (column) => column,
  );

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tips =>
      $composableBuilder(column: $table.tips, builder: (column) => column);

  GeneratedColumn<String> get videoUrl =>
      $composableBuilder(column: $table.videoUrl, builder: (column) => column);

  GeneratedColumn<String> get imageUrlSmall => $composableBuilder(
    column: $table.imageUrlSmall,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageUrlLarge => $composableBuilder(
    column: $table.imageUrlLarge,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get hasCustomImage => $composableBuilder(
    column: $table.hasCustomImage,
    builder: (column) => column,
  );

  GeneratedColumn<int> get difficultyLevel => $composableBuilder(
    column: $table.difficultyLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get safetyRating => $composableBuilder(
    column: $table.safetyRating,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isCompound => $composableBuilder(
    column: $table.isCompound,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isUnilateral => $composableBuilder(
    column: $table.isUnilateral,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get requiresSpotter => $composableBuilder(
    column: $table.requiresSpotter,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isCustom =>
      $composableBuilder(column: $table.isCustom, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ExercisesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExercisesTable,
          Exercise,
          $$ExercisesTableFilterComposer,
          $$ExercisesTableOrderingComposer,
          $$ExercisesTableAnnotationComposer,
          $$ExercisesTableCreateCompanionBuilder,
          $$ExercisesTableUpdateCompanionBuilder,
          (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
          Exercise,
          PrefetchHooks Function()
        > {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExercisesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExercisesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExercisesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> defaultEquipment = const Value.absent(),
                Value<String?> availableEquipment = const Value.absent(),
                Value<String?> exerciseTypes = const Value.absent(),
                Value<String?> primaryMuscles = const Value.absent(),
                Value<String?> secondaryMuscles = const Value.absent(),
                Value<String?> bodyParts = const Value.absent(),
                Value<double?> startingWeightLbs = const Value.absent(),
                Value<double?> startingWeightKg = const Value.absent(),
                Value<double?> defaultWarmupWeight = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> tips = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<String?> imageUrlSmall = const Value.absent(),
                Value<String?> imageUrlLarge = const Value.absent(),
                Value<bool> hasCustomImage = const Value.absent(),
                Value<int> difficultyLevel = const Value.absent(),
                Value<int> safetyRating = const Value.absent(),
                Value<bool> isCompound = const Value.absent(),
                Value<bool> isUnilateral = const Value.absent(),
                Value<bool> requiresSpotter = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion(
                id: id,
                exerciseId: exerciseId,
                name: name,
                defaultEquipment: defaultEquipment,
                availableEquipment: availableEquipment,
                exerciseTypes: exerciseTypes,
                primaryMuscles: primaryMuscles,
                secondaryMuscles: secondaryMuscles,
                bodyParts: bodyParts,
                startingWeightLbs: startingWeightLbs,
                startingWeightKg: startingWeightKg,
                defaultWarmupWeight: defaultWarmupWeight,
                description: description,
                instructions: instructions,
                tips: tips,
                videoUrl: videoUrl,
                imageUrlSmall: imageUrlSmall,
                imageUrlLarge: imageUrlLarge,
                hasCustomImage: hasCustomImage,
                difficultyLevel: difficultyLevel,
                safetyRating: safetyRating,
                isCompound: isCompound,
                isUnilateral: isUnilateral,
                requiresSpotter: requiresSpotter,
                isActive: isActive,
                isCustom: isCustom,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String exerciseId,
                required String name,
                required String defaultEquipment,
                Value<String?> availableEquipment = const Value.absent(),
                Value<String?> exerciseTypes = const Value.absent(),
                Value<String?> primaryMuscles = const Value.absent(),
                Value<String?> secondaryMuscles = const Value.absent(),
                Value<String?> bodyParts = const Value.absent(),
                Value<double?> startingWeightLbs = const Value.absent(),
                Value<double?> startingWeightKg = const Value.absent(),
                Value<double?> defaultWarmupWeight = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> instructions = const Value.absent(),
                Value<String?> tips = const Value.absent(),
                Value<String?> videoUrl = const Value.absent(),
                Value<String?> imageUrlSmall = const Value.absent(),
                Value<String?> imageUrlLarge = const Value.absent(),
                Value<bool> hasCustomImage = const Value.absent(),
                Value<int> difficultyLevel = const Value.absent(),
                Value<int> safetyRating = const Value.absent(),
                Value<bool> isCompound = const Value.absent(),
                Value<bool> isUnilateral = const Value.absent(),
                Value<bool> requiresSpotter = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<bool> isCustom = const Value.absent(),
                Value<String?> createdBy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExercisesCompanion.insert(
                id: id,
                exerciseId: exerciseId,
                name: name,
                defaultEquipment: defaultEquipment,
                availableEquipment: availableEquipment,
                exerciseTypes: exerciseTypes,
                primaryMuscles: primaryMuscles,
                secondaryMuscles: secondaryMuscles,
                bodyParts: bodyParts,
                startingWeightLbs: startingWeightLbs,
                startingWeightKg: startingWeightKg,
                defaultWarmupWeight: defaultWarmupWeight,
                description: description,
                instructions: instructions,
                tips: tips,
                videoUrl: videoUrl,
                imageUrlSmall: imageUrlSmall,
                imageUrlLarge: imageUrlLarge,
                hasCustomImage: hasCustomImage,
                difficultyLevel: difficultyLevel,
                safetyRating: safetyRating,
                isCompound: isCompound,
                isUnilateral: isUnilateral,
                requiresSpotter: requiresSpotter,
                isActive: isActive,
                isCustom: isCustom,
                createdBy: createdBy,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExercisesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExercisesTable,
      Exercise,
      $$ExercisesTableFilterComposer,
      $$ExercisesTableOrderingComposer,
      $$ExercisesTableAnnotationComposer,
      $$ExercisesTableCreateCompanionBuilder,
      $$ExercisesTableUpdateCompanionBuilder,
      (Exercise, BaseReferences<_$AppDatabase, $ExercisesTable, Exercise>),
      Exercise,
      PrefetchHooks Function()
    >;
typedef $$ProgramsTableCreateCompanionBuilder =
    ProgramsCompanion Function({
      required String id,
      required String userId,
      required String name,
      Value<String?> description,
      Value<int?> durationWeeks,
      Value<int?> sessionsPerWeek,
      Value<String> difficulty,
      required String configuration,
      Value<bool> isTemplate,
      Value<bool> isActive,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ProgramsTableUpdateCompanionBuilder =
    ProgramsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<String?> description,
      Value<int?> durationWeeks,
      Value<int?> sessionsPerWeek,
      Value<String> difficulty,
      Value<String> configuration,
      Value<bool> isTemplate,
      Value<bool> isActive,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$ProgramsTableFilterComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationWeeks => $composableBuilder(
    column: $table.durationWeeks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get configuration => $composableBuilder(
    column: $table.configuration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgramsTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationWeeks => $composableBuilder(
    column: $table.durationWeeks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get configuration => $composableBuilder(
    column: $table.configuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgramsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgramsTable> {
  $$ProgramsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationWeeks => $composableBuilder(
    column: $table.durationWeeks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sessionsPerWeek => $composableBuilder(
    column: $table.sessionsPerWeek,
    builder: (column) => column,
  );

  GeneratedColumn<String> get difficulty => $composableBuilder(
    column: $table.difficulty,
    builder: (column) => column,
  );

  GeneratedColumn<String> get configuration => $composableBuilder(
    column: $table.configuration,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isTemplate => $composableBuilder(
    column: $table.isTemplate,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ProgramsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgramsTable,
          Program,
          $$ProgramsTableFilterComposer,
          $$ProgramsTableOrderingComposer,
          $$ProgramsTableAnnotationComposer,
          $$ProgramsTableCreateCompanionBuilder,
          $$ProgramsTableUpdateCompanionBuilder,
          (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
          Program,
          PrefetchHooks Function()
        > {
  $$ProgramsTableTableManager(_$AppDatabase db, $ProgramsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgramsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgramsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgramsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<int?> durationWeeks = const Value.absent(),
                Value<int?> sessionsPerWeek = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                Value<String> configuration = const Value.absent(),
                Value<bool> isTemplate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion(
                id: id,
                userId: userId,
                name: name,
                description: description,
                durationWeeks: durationWeeks,
                sessionsPerWeek: sessionsPerWeek,
                difficulty: difficulty,
                configuration: configuration,
                isTemplate: isTemplate,
                isActive: isActive,
                startedAt: startedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<int?> durationWeeks = const Value.absent(),
                Value<int?> sessionsPerWeek = const Value.absent(),
                Value<String> difficulty = const Value.absent(),
                required String configuration,
                Value<bool> isTemplate = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgramsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                description: description,
                durationWeeks: durationWeeks,
                sessionsPerWeek: sessionsPerWeek,
                difficulty: difficulty,
                configuration: configuration,
                isTemplate: isTemplate,
                isActive: isActive,
                startedAt: startedAt,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgramsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgramsTable,
      Program,
      $$ProgramsTableFilterComposer,
      $$ProgramsTableOrderingComposer,
      $$ProgramsTableAnnotationComposer,
      $$ProgramsTableCreateCompanionBuilder,
      $$ProgramsTableUpdateCompanionBuilder,
      (Program, BaseReferences<_$AppDatabase, $ProgramsTable, Program>),
      Program,
      PrefetchHooks Function()
    >;
typedef $$WorkoutsTableCreateCompanionBuilder =
    WorkoutsCompanion Function({
      required String id,
      required String userId,
      Value<String?> programId,
      required String name,
      Value<String?> notes,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int> totalSets,
      Value<int> totalReps,
      Value<double> totalVolume,
      Value<int?> durationMinutes,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$WorkoutsTableUpdateCompanionBuilder =
    WorkoutsCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> programId,
      Value<String> name,
      Value<String?> notes,
      Value<DateTime?> startedAt,
      Value<DateTime?> completedAt,
      Value<int> totalSets,
      Value<int> totalReps,
      Value<double> totalVolume,
      Value<int?> durationMinutes,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$WorkoutsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalSets => $composableBuilder(
    column: $table.totalSets,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalReps => $composableBuilder(
    column: $table.totalReps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalVolume => $composableBuilder(
    column: $table.totalVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get programId => $composableBuilder(
    column: $table.programId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
    column: $table.startedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalSets => $composableBuilder(
    column: $table.totalSets,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalReps => $composableBuilder(
    column: $table.totalReps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalVolume => $composableBuilder(
    column: $table.totalVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutsTable> {
  $$WorkoutsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get programId =>
      $composableBuilder(column: $table.programId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalSets =>
      $composableBuilder(column: $table.totalSets, builder: (column) => column);

  GeneratedColumn<int> get totalReps =>
      $composableBuilder(column: $table.totalReps, builder: (column) => column);

  GeneratedColumn<double> get totalVolume => $composableBuilder(
    column: $table.totalVolume,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$WorkoutsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutsTable,
          Workout,
          $$WorkoutsTableFilterComposer,
          $$WorkoutsTableOrderingComposer,
          $$WorkoutsTableAnnotationComposer,
          $$WorkoutsTableCreateCompanionBuilder,
          $$WorkoutsTableUpdateCompanionBuilder,
          (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
          Workout,
          PrefetchHooks Function()
        > {
  $$WorkoutsTableTableManager(_$AppDatabase db, $WorkoutsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> programId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> totalSets = const Value.absent(),
                Value<int> totalReps = const Value.absent(),
                Value<double> totalVolume = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion(
                id: id,
                userId: userId,
                programId: programId,
                name: name,
                notes: notes,
                startedAt: startedAt,
                completedAt: completedAt,
                totalSets: totalSets,
                totalReps: totalReps,
                totalVolume: totalVolume,
                durationMinutes: durationMinutes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<String?> programId = const Value.absent(),
                required String name,
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> startedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> totalSets = const Value.absent(),
                Value<int> totalReps = const Value.absent(),
                Value<double> totalVolume = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutsCompanion.insert(
                id: id,
                userId: userId,
                programId: programId,
                name: name,
                notes: notes,
                startedAt: startedAt,
                completedAt: completedAt,
                totalSets: totalSets,
                totalReps: totalReps,
                totalVolume: totalVolume,
                durationMinutes: durationMinutes,
                status: status,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutsTable,
      Workout,
      $$WorkoutsTableFilterComposer,
      $$WorkoutsTableOrderingComposer,
      $$WorkoutsTableAnnotationComposer,
      $$WorkoutsTableCreateCompanionBuilder,
      $$WorkoutsTableUpdateCompanionBuilder,
      (Workout, BaseReferences<_$AppDatabase, $WorkoutsTable, Workout>),
      Workout,
      PrefetchHooks Function()
    >;
typedef $$WorkoutSetsTableCreateCompanionBuilder =
    WorkoutSetsCompanion Function({
      required String id,
      required String workoutId,
      required String exerciseId,
      required int setNumber,
      required int reps,
      required double weight,
      Value<double?> rpe,
      Value<int?> restSeconds,
      Value<String?> notes,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$WorkoutSetsTableUpdateCompanionBuilder =
    WorkoutSetsCompanion Function({
      Value<String> id,
      Value<String> workoutId,
      Value<String> exerciseId,
      Value<int> setNumber,
      Value<int> reps,
      Value<double> weight,
      Value<double?> rpe,
      Value<int?> restSeconds,
      Value<String?> notes,
      Value<bool> isCompleted,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$WorkoutSetsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WorkoutSetsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get workoutId => $composableBuilder(
    column: $table.workoutId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setNumber => $composableBuilder(
    column: $table.setNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reps => $composableBuilder(
    column: $table.reps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weight => $composableBuilder(
    column: $table.weight,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpe => $composableBuilder(
    column: $table.rpe,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WorkoutSetsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutSetsTable> {
  $$WorkoutSetsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get workoutId =>
      $composableBuilder(column: $table.workoutId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get setNumber =>
      $composableBuilder(column: $table.setNumber, builder: (column) => column);

  GeneratedColumn<int> get reps =>
      $composableBuilder(column: $table.reps, builder: (column) => column);

  GeneratedColumn<double> get weight =>
      $composableBuilder(column: $table.weight, builder: (column) => column);

  GeneratedColumn<double> get rpe =>
      $composableBuilder(column: $table.rpe, builder: (column) => column);

  GeneratedColumn<int> get restSeconds => $composableBuilder(
    column: $table.restSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get isCompleted => $composableBuilder(
    column: $table.isCompleted,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$WorkoutSetsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutSetsTable,
          WorkoutSet,
          $$WorkoutSetsTableFilterComposer,
          $$WorkoutSetsTableOrderingComposer,
          $$WorkoutSetsTableAnnotationComposer,
          $$WorkoutSetsTableCreateCompanionBuilder,
          $$WorkoutSetsTableUpdateCompanionBuilder,
          (
            WorkoutSet,
            BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet>,
          ),
          WorkoutSet,
          PrefetchHooks Function()
        > {
  $$WorkoutSetsTableTableManager(_$AppDatabase db, $WorkoutSetsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutSetsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutSetsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutSetsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> workoutId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<int> setNumber = const Value.absent(),
                Value<int> reps = const Value.absent(),
                Value<double> weight = const Value.absent(),
                Value<double?> rpe = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSetsCompanion(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                reps: reps,
                weight: weight,
                rpe: rpe,
                restSeconds: restSeconds,
                notes: notes,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String workoutId,
                required String exerciseId,
                required int setNumber,
                required int reps,
                required double weight,
                Value<double?> rpe = const Value.absent(),
                Value<int?> restSeconds = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> isCompleted = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutSetsCompanion.insert(
                id: id,
                workoutId: workoutId,
                exerciseId: exerciseId,
                setNumber: setNumber,
                reps: reps,
                weight: weight,
                rpe: rpe,
                restSeconds: restSeconds,
                notes: notes,
                isCompleted: isCompleted,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WorkoutSetsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutSetsTable,
      WorkoutSet,
      $$WorkoutSetsTableFilterComposer,
      $$WorkoutSetsTableOrderingComposer,
      $$WorkoutSetsTableAnnotationComposer,
      $$WorkoutSetsTableCreateCompanionBuilder,
      $$WorkoutSetsTableUpdateCompanionBuilder,
      (
        WorkoutSet,
        BaseReferences<_$AppDatabase, $WorkoutSetsTable, WorkoutSet>,
      ),
      WorkoutSet,
      PrefetchHooks Function()
    >;
typedef $$ProgressEntriesTableCreateCompanionBuilder =
    ProgressEntriesCompanion Function({
      required String id,
      required String userId,
      required String type,
      Value<String?> exerciseId,
      required double value,
      required String unit,
      Value<String?> bodyPart,
      Value<String?> notes,
      Value<String?> photoUrl,
      required DateTime recordedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });
typedef $$ProgressEntriesTableUpdateCompanionBuilder =
    ProgressEntriesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> type,
      Value<String?> exerciseId,
      Value<double> value,
      Value<String> unit,
      Value<String?> bodyPart,
      Value<String?> notes,
      Value<String?> photoUrl,
      Value<DateTime> recordedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> version,
      Value<String> syncStatus,
      Value<DateTime?> deletedAt,
      Value<int> rowid,
    });

class $$ProgressEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProgressEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bodyPart => $composableBuilder(
    column: $table.bodyPart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoUrl => $composableBuilder(
    column: $table.photoUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get version => $composableBuilder(
    column: $table.version,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
    column: $table.deletedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProgressEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProgressEntriesTable> {
  $$ProgressEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get bodyPart =>
      $composableBuilder(column: $table.bodyPart, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<int> get version =>
      $composableBuilder(column: $table.version, builder: (column) => column);

  GeneratedColumn<String> get syncStatus => $composableBuilder(
    column: $table.syncStatus,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);
}

class $$ProgressEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProgressEntriesTable,
          ProgressEntry,
          $$ProgressEntriesTableFilterComposer,
          $$ProgressEntriesTableOrderingComposer,
          $$ProgressEntriesTableAnnotationComposer,
          $$ProgressEntriesTableCreateCompanionBuilder,
          $$ProgressEntriesTableUpdateCompanionBuilder,
          (
            ProgressEntry,
            BaseReferences<_$AppDatabase, $ProgressEntriesTable, ProgressEntry>,
          ),
          ProgressEntry,
          PrefetchHooks Function()
        > {
  $$ProgressEntriesTableTableManager(
    _$AppDatabase db,
    $ProgressEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProgressEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProgressEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProgressEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String?> exerciseId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> bodyPart = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressEntriesCompanion(
                id: id,
                userId: userId,
                type: type,
                exerciseId: exerciseId,
                value: value,
                unit: unit,
                bodyPart: bodyPart,
                notes: notes,
                photoUrl: photoUrl,
                recordedAt: recordedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String type,
                Value<String?> exerciseId = const Value.absent(),
                required double value,
                required String unit,
                Value<String?> bodyPart = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photoUrl = const Value.absent(),
                required DateTime recordedAt,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> version = const Value.absent(),
                Value<String> syncStatus = const Value.absent(),
                Value<DateTime?> deletedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProgressEntriesCompanion.insert(
                id: id,
                userId: userId,
                type: type,
                exerciseId: exerciseId,
                value: value,
                unit: unit,
                bodyPart: bodyPart,
                notes: notes,
                photoUrl: photoUrl,
                recordedAt: recordedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                version: version,
                syncStatus: syncStatus,
                deletedAt: deletedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProgressEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProgressEntriesTable,
      ProgressEntry,
      $$ProgressEntriesTableFilterComposer,
      $$ProgressEntriesTableOrderingComposer,
      $$ProgressEntriesTableAnnotationComposer,
      $$ProgressEntriesTableCreateCompanionBuilder,
      $$ProgressEntriesTableUpdateCompanionBuilder,
      (
        ProgressEntry,
        BaseReferences<_$AppDatabase, $ProgressEntriesTable, ProgressEntry>,
      ),
      ProgressEntry,
      PrefetchHooks Function()
    >;
typedef $$EquipmentTableCreateCompanionBuilder =
    EquipmentCompanion Function({
      required String id,
      required String equipmentId,
      required String name,
      Value<String?> description,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$EquipmentTableUpdateCompanionBuilder =
    EquipmentCompanion Function({
      Value<String> id,
      Value<String> equipmentId,
      Value<String> name,
      Value<String?> description,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EquipmentTableFilterComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EquipmentTableOrderingComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EquipmentTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquipmentTable> {
  $$EquipmentTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get equipmentId => $composableBuilder(
    column: $table.equipmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EquipmentTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquipmentTable,
          EquipmentData,
          $$EquipmentTableFilterComposer,
          $$EquipmentTableOrderingComposer,
          $$EquipmentTableAnnotationComposer,
          $$EquipmentTableCreateCompanionBuilder,
          $$EquipmentTableUpdateCompanionBuilder,
          (
            EquipmentData,
            BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>,
          ),
          EquipmentData,
          PrefetchHooks Function()
        > {
  $$EquipmentTableTableManager(_$AppDatabase db, $EquipmentTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquipmentTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquipmentTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquipmentTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> equipmentId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion(
                id: id,
                equipmentId: equipmentId,
                name: name,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String equipmentId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EquipmentCompanion.insert(
                id: id,
                equipmentId: equipmentId,
                name: name,
                description: description,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EquipmentTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquipmentTable,
      EquipmentData,
      $$EquipmentTableFilterComposer,
      $$EquipmentTableOrderingComposer,
      $$EquipmentTableAnnotationComposer,
      $$EquipmentTableCreateCompanionBuilder,
      $$EquipmentTableUpdateCompanionBuilder,
      (
        EquipmentData,
        BaseReferences<_$AppDatabase, $EquipmentTable, EquipmentData>,
      ),
      EquipmentData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseCategoriesTableCreateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      required String id,
      required String categoryId,
      required String name,
      Value<String?> description,
      Value<String?> color,
      Value<String?> icon,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ExerciseCategoriesTableUpdateCompanionBuilder =
    ExerciseCategoriesCompanion Function({
      Value<String> id,
      Value<String> categoryId,
      Value<String> name,
      Value<String?> description,
      Value<String?> color,
      Value<String?> icon,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ExerciseCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseCategoriesTable> {
  $$ExerciseCategoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExerciseCategoriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory,
          $$ExerciseCategoriesTableFilterComposer,
          $$ExerciseCategoriesTableOrderingComposer,
          $$ExerciseCategoriesTableAnnotationComposer,
          $$ExerciseCategoriesTableCreateCompanionBuilder,
          $$ExerciseCategoriesTableUpdateCompanionBuilder,
          (
            ExerciseCategory,
            BaseReferences<
              _$AppDatabase,
              $ExerciseCategoriesTable,
              ExerciseCategory
            >,
          ),
          ExerciseCategory,
          PrefetchHooks Function()
        > {
  $$ExerciseCategoriesTableTableManager(
    _$AppDatabase db,
    $ExerciseCategoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseCategoriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseCategoriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseCategoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoryId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseCategoriesCompanion(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                color: color,
                icon: icon,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoryId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> color = const Value.absent(),
                Value<String?> icon = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseCategoriesCompanion.insert(
                id: id,
                categoryId: categoryId,
                name: name,
                description: description,
                color: color,
                icon: icon,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseCategoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseCategoriesTable,
      ExerciseCategory,
      $$ExerciseCategoriesTableFilterComposer,
      $$ExerciseCategoriesTableOrderingComposer,
      $$ExerciseCategoriesTableAnnotationComposer,
      $$ExerciseCategoriesTableCreateCompanionBuilder,
      $$ExerciseCategoriesTableUpdateCompanionBuilder,
      (
        ExerciseCategory,
        BaseReferences<
          _$AppDatabase,
          $ExerciseCategoriesTable,
          ExerciseCategory
        >,
      ),
      ExerciseCategory,
      PrefetchHooks Function()
    >;
typedef $$GoalProgressTableCreateCompanionBuilder =
    GoalProgressCompanion Function({
      required String id,
      required String goalId,
      required double value,
      Value<String?> notes,
      required DateTime recordedAt,
      required String userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$GoalProgressTableUpdateCompanionBuilder =
    GoalProgressCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<double> value,
      Value<String?> notes,
      Value<DateTime> recordedAt,
      Value<String> userId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$GoalProgressTableFilterComposer
    extends Composer<_$AppDatabase, $GoalProgressTable> {
  $$GoalProgressTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GoalProgressTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalProgressTable> {
  $$GoalProgressTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get goalId => $composableBuilder(
    column: $table.goalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalProgressTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalProgressTable> {
  $$GoalProgressTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get goalId =>
      $composableBuilder(column: $table.goalId, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get recordedAt => $composableBuilder(
    column: $table.recordedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$GoalProgressTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalProgressTable,
          GoalProgressData,
          $$GoalProgressTableFilterComposer,
          $$GoalProgressTableOrderingComposer,
          $$GoalProgressTableAnnotationComposer,
          $$GoalProgressTableCreateCompanionBuilder,
          $$GoalProgressTableUpdateCompanionBuilder,
          (
            GoalProgressData,
            BaseReferences<_$AppDatabase, $GoalProgressTable, GoalProgressData>,
          ),
          GoalProgressData,
          PrefetchHooks Function()
        > {
  $$GoalProgressTableTableManager(_$AppDatabase db, $GoalProgressTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalProgressTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalProgressTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalProgressTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<double> value = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> recordedAt = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalProgressCompanion(
                id: id,
                goalId: goalId,
                value: value,
                notes: notes,
                recordedAt: recordedAt,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required double value,
                Value<String?> notes = const Value.absent(),
                required DateTime recordedAt,
                required String userId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalProgressCompanion.insert(
                id: id,
                goalId: goalId,
                value: value,
                notes: notes,
                recordedAt: recordedAt,
                userId: userId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GoalProgressTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalProgressTable,
      GoalProgressData,
      $$GoalProgressTableFilterComposer,
      $$GoalProgressTableOrderingComposer,
      $$GoalProgressTableAnnotationComposer,
      $$GoalProgressTableCreateCompanionBuilder,
      $$GoalProgressTableUpdateCompanionBuilder,
      (
        GoalProgressData,
        BaseReferences<_$AppDatabase, $GoalProgressTable, GoalProgressData>,
      ),
      GoalProgressData,
      PrefetchHooks Function()
    >;
typedef $$ExerciseFavoritesTableCreateCompanionBuilder =
    ExerciseFavoritesCompanion Function({
      required String id,
      required String userId,
      required String exerciseId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$ExerciseFavoritesTableUpdateCompanionBuilder =
    ExerciseFavoritesCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> exerciseId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ExerciseFavoritesTableFilterComposer
    extends Composer<_$AppDatabase, $ExerciseFavoritesTable> {
  $$ExerciseFavoritesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExerciseFavoritesTableOrderingComposer
    extends Composer<_$AppDatabase, $ExerciseFavoritesTable> {
  $$ExerciseFavoritesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExerciseFavoritesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ExerciseFavoritesTable> {
  $$ExerciseFavoritesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get exerciseId => $composableBuilder(
    column: $table.exerciseId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ExerciseFavoritesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ExerciseFavoritesTable,
          ExerciseFavorite,
          $$ExerciseFavoritesTableFilterComposer,
          $$ExerciseFavoritesTableOrderingComposer,
          $$ExerciseFavoritesTableAnnotationComposer,
          $$ExerciseFavoritesTableCreateCompanionBuilder,
          $$ExerciseFavoritesTableUpdateCompanionBuilder,
          (
            ExerciseFavorite,
            BaseReferences<
              _$AppDatabase,
              $ExerciseFavoritesTable,
              ExerciseFavorite
            >,
          ),
          ExerciseFavorite,
          PrefetchHooks Function()
        > {
  $$ExerciseFavoritesTableTableManager(
    _$AppDatabase db,
    $ExerciseFavoritesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ExerciseFavoritesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ExerciseFavoritesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ExerciseFavoritesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> exerciseId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseFavoritesCompanion(
                id: id,
                userId: userId,
                exerciseId: exerciseId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String exerciseId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExerciseFavoritesCompanion.insert(
                id: id,
                userId: userId,
                exerciseId: exerciseId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ExerciseFavoritesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ExerciseFavoritesTable,
      ExerciseFavorite,
      $$ExerciseFavoritesTableFilterComposer,
      $$ExerciseFavoritesTableOrderingComposer,
      $$ExerciseFavoritesTableAnnotationComposer,
      $$ExerciseFavoritesTableCreateCompanionBuilder,
      $$ExerciseFavoritesTableUpdateCompanionBuilder,
      (
        ExerciseFavorite,
        BaseReferences<
          _$AppDatabase,
          $ExerciseFavoritesTable,
          ExerciseFavorite
        >,
      ),
      ExerciseFavorite,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$ProgramsTableTableManager get programs =>
      $$ProgramsTableTableManager(_db, _db.programs);
  $$WorkoutsTableTableManager get workouts =>
      $$WorkoutsTableTableManager(_db, _db.workouts);
  $$WorkoutSetsTableTableManager get workoutSets =>
      $$WorkoutSetsTableTableManager(_db, _db.workoutSets);
  $$ProgressEntriesTableTableManager get progressEntries =>
      $$ProgressEntriesTableTableManager(_db, _db.progressEntries);
  $$EquipmentTableTableManager get equipment =>
      $$EquipmentTableTableManager(_db, _db.equipment);
  $$ExerciseCategoriesTableTableManager get exerciseCategories =>
      $$ExerciseCategoriesTableTableManager(_db, _db.exerciseCategories);
  $$GoalProgressTableTableManager get goalProgress =>
      $$GoalProgressTableTableManager(_db, _db.goalProgress);
  $$ExerciseFavoritesTableTableManager get exerciseFavorites =>
      $$ExerciseFavoritesTableTableManager(_db, _db.exerciseFavorites);
}
