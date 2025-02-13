import 'package:assignment/models.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _database;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'service_requests.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE service_requests (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      bookingReferenceNo TEXT NOT NULL,
      complaintDescription TEXT NOT NULL,
      srNumber TEXT NOT NULL,
      customerName TEXT NOT NULL,
      customerType TEXT NOT NULL,
      srId TEXT NOT NULL,
      requestedDate TEXT NOT NULL,
      kVA TEXT NOT NULL,
      dealerCode TEXT NOT NULL,
      dealerName TEXT NOT NULL,
      stateId TEXT NOT NULL,
      stateName TEXT NOT NULL,
      srTypeId TEXT NOT NULL,
      srType TEXT NOT NULL,
      latitude TEXT,  
      longitude TEXT, 
      plannedStartDate TEXT NOT NULL,
      plannedStartDate2 TEXT NOT NULL,
      plannedStartDate3 TEXT NOT NULL,
      custContactNo TEXT NOT NULL,
      srStatusId TEXT NOT NULL,
      srStatus TEXT NOT NULL,
      srEngineerName TEXT NOT NULL,
      dealerId TEXT NOT NULL,
      dealerBranchesId TEXT NOT NULL,
      verticalId TEXT NOT NULL,
      sContactNo TEXT NOT NULL,
      modifiedDate TEXT NOT NULL,
      districtId TEXT NOT NULL,
      districtName TEXT NOT NULL,
      applicationId TEXT NOT NULL,
      description TEXT,
      isManualCall INTEGER NOT NULL,
      chargerSerialNo TEXT,
      chargerModel TEXT,
      parntGroup TEXT,
      loctnCd TEXT,
      stageStatus TEXT NOT NULL,
      overallStatus TEXT NOT NULL,
      proofDocURL TEXT NOT NULL,
      siteAddress TEXT NOT NULL,
      dealerLocation TEXT NOT NULL,
      newAddress TEXT NOT NULL
  )
  ''');
      },
    );
  }

  Future<void> insertServiceRequest(ServiceRequest request) async {
    final db = await database;
    await db.insert(
      'service_requests',
      request.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ServiceRequest>> getServiceRequests() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('service_requests');
    return List.generate(maps.length, (i) {
      return ServiceRequest.fromJson(maps[i]);
    });
  }

  Future<void> clearDatabase() async {
    final db = await database;
    // await db.delete('service_requests');
  }
}
