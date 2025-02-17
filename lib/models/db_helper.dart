import 'package:assignment/models/service_request_models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;
  static final DatabaseService instance = DatabaseService._init();

  DatabaseService._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('service_requests.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(path,
        version: 2, onCreate: _createDB, onUpgrade: _upgradeDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE requests (
      bookingReferenceNo TEXT PRIMARY KEY,
      complaintDescription TEXT,
      srnumber TEXT,
      customerName TEXT,
      customerType TEXT,
      srid TEXT,
      requestedDate TEXT,
      kVA TEXT,
      dealerCode TEXT,
      dealerName TEXT,
      stateID TEXT,
      stateName TEXT,
      srTypeID TEXT,
      srType TEXT,
      plannedStartDate TEXT,
      plannedStartDate2 TEXT,
      plannedStartDate3 TEXT,
      custContactNo TEXT,
      srStatusID TEXT,
      srStatus TEXT,
      sREngineerName TEXT,
      dealerID TEXT,
      dealerBranchesID TEXT,
      verticalId TEXT,
      sContactNo TEXT,
      modifiedDate TEXT,
      districtID TEXT,
      districtName TEXT,
      applicationId TEXT,
      description TEXT,
      isManualCall INTEGER,
      chargerSerialNo TEXT,
      chargerModel TEXT,
      parntGroup TEXT,
      loctnCd TEXT,
      stageStatus TEXT,
      overallStatus TEXT,
      proofDocURL TEXT,
      siteAddress TEXT,
      vehicleModel TEXT,
      locationLevelOfParking TEXT,
      uniqueID TEXT,
      vinNo TEXT,
      adJSON TEXT,
      surveyReportSRNumber TEXT,
      siteValidationRequestSRNumber TEXT,
      installationRequestSRNumber TEXT,
      dealerLocation TEXT,
      surveyCableSize TEXT,
      surveyCableLength TEXT,
      surveySrID TEXT,
      newAddress TEXT,
      imagePath TEXT
    )
  ''');
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute('ALTER TABLE requests ADD COLUMN imagePath TEXT');
    }
  }

  Future<void> insertServiceRequest(ServiceRequest request) async {
    final db = await database;
    await db.insert('requests', request.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateServiceRequest(ServiceRequest request) async {
    final db = await database;
    await db.update(
      'requests',
      request.toMap(),
      where: 'bookingReferenceNo = ?',
      whereArgs: [request.bookingReferenceNo],
    );
  }

  Future<List<ServiceRequest>> getServiceRequests(
      [String? bookingReferenceNo]) async {
    final db = await database;
    List<Map<String, dynamic>> maps;

    if (bookingReferenceNo != null) {
      maps = await db.query(
        'requests',
        where: 'bookingReferenceNo = ?',
        whereArgs: [bookingReferenceNo],
      );
    } else {
      maps = await db.query('requests');
    }

    return List.generate(maps.length, (i) {
      return ServiceRequest.dbFromMap(maps[i]);
    });
  }

  Future<ServiceRequest?> getServiceRequestByBookingReference(
      String bookingReferenceNo) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'requests',
      where: 'bookingReferenceNo = ?',
      whereArgs: [bookingReferenceNo],
    );

    if (maps.isNotEmpty) {
      return ServiceRequest.dbFromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<void> insertImagePath(
      {required String bookingReferenceNo, required String imagePath}) async {
    final db = await database;

    await db.insert(
      'requests',
      {'bookingReferenceNo': bookingReferenceNo, 'imagePath': imagePath},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
