// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class NasaImage extends DataClass implements Insertable<NasaImage> {
  final String url;
  final String title;
  final String description;
  final String copyright;
  final DateTime date;
  NasaImage(
      {@required this.url,
      @required this.title,
      this.description,
      this.copyright,
      this.date});
  factory NasaImage.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    return NasaImage(
      url: stringType.mapFromDatabaseResponse(data['${effectivePrefix}url']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      copyright: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}copyright']),
      date:
          dateTimeType.mapFromDatabaseResponse(data['${effectivePrefix}date']),
    );
  }
  factory NasaImage.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return NasaImage(
      url: serializer.fromJson<String>(json['url']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      copyright: serializer.fromJson<String>(json['copyright']),
      date: serializer.fromJson<DateTime>(json['date']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'url': serializer.toJson<String>(url),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'copyright': serializer.toJson<String>(copyright),
      'date': serializer.toJson<DateTime>(date),
    };
  }

  @override
  NasaImagesCompanion createCompanion(bool nullToAbsent) {
    return NasaImagesCompanion(
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      copyright: copyright == null && nullToAbsent
          ? const Value.absent()
          : Value(copyright),
      date: date == null && nullToAbsent ? const Value.absent() : Value(date),
    );
  }

  NasaImage copyWith(
          {String url,
          String title,
          String description,
          String copyright,
          DateTime date}) =>
      NasaImage(
        url: url ?? this.url,
        title: title ?? this.title,
        description: description ?? this.description,
        copyright: copyright ?? this.copyright,
        date: date ?? this.date,
      );
  @override
  String toString() {
    return (StringBuffer('NasaImage(')
          ..write('url: $url, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('copyright: $copyright, ')
          ..write('date: $date')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      url.hashCode,
      $mrjc(
          title.hashCode,
          $mrjc(description.hashCode,
              $mrjc(copyright.hashCode, date.hashCode)))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is NasaImage &&
          other.url == this.url &&
          other.title == this.title &&
          other.description == this.description &&
          other.copyright == this.copyright &&
          other.date == this.date);
}

class NasaImagesCompanion extends UpdateCompanion<NasaImage> {
  final Value<String> url;
  final Value<String> title;
  final Value<String> description;
  final Value<String> copyright;
  final Value<DateTime> date;
  const NasaImagesCompanion({
    this.url = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.copyright = const Value.absent(),
    this.date = const Value.absent(),
  });
  NasaImagesCompanion.insert({
    @required String url,
    @required String title,
    this.description = const Value.absent(),
    this.copyright = const Value.absent(),
    this.date = const Value.absent(),
  })  : url = Value(url),
        title = Value(title);
  NasaImagesCompanion copyWith(
      {Value<String> url,
      Value<String> title,
      Value<String> description,
      Value<String> copyright,
      Value<DateTime> date}) {
    return NasaImagesCompanion(
      url: url ?? this.url,
      title: title ?? this.title,
      description: description ?? this.description,
      copyright: copyright ?? this.copyright,
      date: date ?? this.date,
    );
  }
}

class NasaImages extends Table with TableInfo<NasaImages, NasaImage> {
  final GeneratedDatabase _db;
  final String _alias;
  NasaImages(this._db, [this._alias]);
  final VerificationMeta _urlMeta = const VerificationMeta('url');
  GeneratedTextColumn _url;
  GeneratedTextColumn get url => _url ??= _constructUrl();
  GeneratedTextColumn _constructUrl() {
    return GeneratedTextColumn('url', $tableName, false,
        $customConstraints: 'NOT NULL PRIMARY KEY');
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', $tableName, false,
        $customConstraints: 'NOT NULL');
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', $tableName, true,
        $customConstraints: '');
  }

  final VerificationMeta _copyrightMeta = const VerificationMeta('copyright');
  GeneratedTextColumn _copyright;
  GeneratedTextColumn get copyright => _copyright ??= _constructCopyright();
  GeneratedTextColumn _constructCopyright() {
    return GeneratedTextColumn('copyright', $tableName, true,
        $customConstraints: '');
  }

  final VerificationMeta _dateMeta = const VerificationMeta('date');
  GeneratedDateTimeColumn _date;
  GeneratedDateTimeColumn get date => _date ??= _constructDate();
  GeneratedDateTimeColumn _constructDate() {
    return GeneratedDateTimeColumn('date', $tableName, true,
        $customConstraints: '');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [url, title, description, copyright, date];
  @override
  NasaImages get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'nasa_images';
  @override
  final String actualTableName = 'nasa_images';
  @override
  VerificationContext validateIntegrity(NasaImagesCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.url.present) {
      context.handle(_urlMeta, url.isAcceptableValue(d.url.value, _urlMeta));
    } else if (url.isRequired && isInserting) {
      context.missing(_urlMeta);
    }
    if (d.title.present) {
      context.handle(
          _titleMeta, title.isAcceptableValue(d.title.value, _titleMeta));
    } else if (title.isRequired && isInserting) {
      context.missing(_titleMeta);
    }
    if (d.description.present) {
      context.handle(_descriptionMeta,
          description.isAcceptableValue(d.description.value, _descriptionMeta));
    } else if (description.isRequired && isInserting) {
      context.missing(_descriptionMeta);
    }
    if (d.copyright.present) {
      context.handle(_copyrightMeta,
          copyright.isAcceptableValue(d.copyright.value, _copyrightMeta));
    } else if (copyright.isRequired && isInserting) {
      context.missing(_copyrightMeta);
    }
    if (d.date.present) {
      context.handle(
          _dateMeta, date.isAcceptableValue(d.date.value, _dateMeta));
    } else if (date.isRequired && isInserting) {
      context.missing(_dateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {url};
  @override
  NasaImage map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return NasaImage.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(NasaImagesCompanion d) {
    final map = <String, Variable>{};
    if (d.url.present) {
      map['url'] = Variable<String, StringType>(d.url.value);
    }
    if (d.title.present) {
      map['title'] = Variable<String, StringType>(d.title.value);
    }
    if (d.description.present) {
      map['description'] = Variable<String, StringType>(d.description.value);
    }
    if (d.copyright.present) {
      map['copyright'] = Variable<String, StringType>(d.copyright.value);
    }
    if (d.date.present) {
      map['date'] = Variable<DateTime, DateTimeType>(d.date.value);
    }
    return map;
  }

  @override
  NasaImages createAlias(String alias) {
    return NasaImages(_db, alias);
  }

  @override
  final bool dontWriteConstraints = true;
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  NasaImages _nasaImages;
  NasaImages get nasaImages => _nasaImages ??= NasaImages(this);
  Future<int> insertImage(String url, String title, String description,
      String copyright, DateTime date) {
    return customInsert(
      'INSERT OR REPLACE INTO nasa_images (url, title, description, copyright, date) VALUES (:url, :title, :description, :copyright, :date)',
      variables: [
        Variable.withString(url),
        Variable.withString(title),
        Variable.withString(description),
        Variable.withString(copyright),
        Variable.withDateTime(date)
      ],
      updates: {nasaImages},
    );
  }

  NasaImage _rowToNasaImage(QueryRow row) {
    return NasaImage(
      url: row.readString('url'),
      title: row.readString('title'),
      description: row.readString('description'),
      copyright: row.readString('copyright'),
      date: row.readDateTime('date'),
    );
  }

  Selectable<NasaImage> allImages() {
    return customSelectQuery('SELECT * FROM nasa_images ORDER BY date DESC',
        variables: [], readsFrom: {nasaImages}).map(_rowToNasaImage);
  }

  @override
  List<TableInfo> get allTables => [nasaImages];
}
