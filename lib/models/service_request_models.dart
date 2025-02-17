class ServiceRequest {
  String bookingReferenceNo;
  String complaintDescription;
  String srnumber;
  String customerName;
  String customerType;
  String srid;
  String requestedDate;
  String kVA;
  String dealerCode;
  String dealerName;
  String stateID;
  String stateName;
  String srTypeID;
  String srType;
  String plannedStartDate;
  String plannedStartDate2;
  String plannedStartDate3;
  String custContactNo;
  String srStatusID;
  String srStatus;
  String sREngineerName;
  String dealerID;
  String dealerBranchesID;
  String verticalId;
  String sContactNo;
  String modifiedDate;
  String districtID;
  String districtName;
  String applicationId;
  String? description;
  bool isManualCall;
  String? chargerSerialNo;
  String? chargerModel;
  String? parntGroup;
  String? loctnCd;
  String stageStatus;
  String overallStatus;
  String proofDocURL;
  String siteAddress;
  String? vehicleModel;
  String? locationLevelOfParking;
  String? uniqueID;
  String? vinNo;
  String adJSON;
  String surveyReportSRNumber;
  String siteValidationRequestSRNumber;
  String installationRequestSRNumber;
  String dealerLocation;
  String? surveyCableSize;
  String? surveyCableLength;
  String? surveySrID;
  String newAddress;
  String? imagePath;

  ServiceRequest({
    required this.bookingReferenceNo,
    required this.complaintDescription,
    required this.srnumber,
    required this.customerName,
    required this.customerType,
    required this.srid,
    required this.requestedDate,
    required this.kVA,
    required this.dealerCode,
    required this.dealerName,
    required this.stateID,
    required this.stateName,
    required this.srTypeID,
    required this.srType,
    required this.plannedStartDate,
    required this.plannedStartDate2,
    required this.plannedStartDate3,
    required this.custContactNo,
    required this.srStatusID,
    required this.srStatus,
    required this.sREngineerName,
    required this.dealerID,
    required this.dealerBranchesID,
    required this.verticalId,
    required this.sContactNo,
    required this.modifiedDate,
    required this.districtID,
    required this.districtName,
    required this.applicationId,
    this.description,
    required this.isManualCall,
    this.chargerSerialNo,
    this.chargerModel,
    this.parntGroup,
    this.loctnCd,
    required this.stageStatus,
    required this.overallStatus,
    required this.proofDocURL,
    required this.siteAddress,
    this.vehicleModel,
    this.locationLevelOfParking,
    this.uniqueID,
    this.vinNo,
    required this.adJSON,
    required this.surveyReportSRNumber,
    required this.siteValidationRequestSRNumber,
    required this.installationRequestSRNumber,
    required this.dealerLocation,
    this.surveyCableSize,
    this.surveyCableLength,
    this.surveySrID,
    required this.newAddress,
    this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookingReferenceNo': bookingReferenceNo,
      'complaintDescription': complaintDescription,
      'srnumber': srnumber,
      'customerName': customerName,
      'customerType': customerType,
      'srid': srid,
      'requestedDate': requestedDate,
      'kVA': kVA,
      'dealerCode': dealerCode,
      'dealerName': dealerName,
      'stateID': stateID,
      'stateName': stateName,
      'srTypeID': srTypeID,
      'srType': srType,
      'plannedStartDate': plannedStartDate,
      'plannedStartDate2': plannedStartDate2,
      'plannedStartDate3': plannedStartDate3,
      'custContactNo': custContactNo,
      'srStatusID': srStatusID,
      'srStatus': srStatus,
      'sREngineerName': sREngineerName,
      'dealerID': dealerID,
      'dealerBranchesID': dealerBranchesID,
      'verticalId': verticalId,
      'sContactNo': sContactNo,
      'modifiedDate': modifiedDate,
      'districtID': districtID,
      'districtName': districtName,
      'applicationId': applicationId,
      'description': description,
      'isManualCall': isManualCall ? 1 : 0,
      'stageStatus': stageStatus,
      'overallStatus': overallStatus,
      'proofDocURL': proofDocURL,
      'siteAddress': siteAddress,
      'adJSON': adJSON,
      'surveyReportSRNumber': surveyReportSRNumber,
      'siteValidationRequestSRNumber': siteValidationRequestSRNumber,
      'installationRequestSRNumber': installationRequestSRNumber,
      'dealerLocation': dealerLocation,
      'newAddress': newAddress,
      'imagePath': imagePath,
    };
  }

  factory ServiceRequest.fromMap(Map<String, dynamic> map) {
    return ServiceRequest(
      bookingReferenceNo: map['BookingReferenceNo'] ?? '',
      complaintDescription: map['ComplaintDescription'] ?? '',
      srnumber: map['srnumber'] ?? '',
      customerName: map['CustomerName'] ?? '',
      customerType: map['CustomerType'] ?? '',
      srid: map['SRID'] ?? '',
      requestedDate: map['RequestedDate'] ?? '',
      kVA: map['kVA'] ?? '',
      dealerCode: map['DealerCode'] ?? '',
      dealerName: map['DealerName'] ?? '',
      stateID: map['StateID'] ?? '',
      stateName: map['StateName'] ?? '',
      srTypeID: map['SRTypeID'] ?? '',
      srType: map['SRType'] ?? '',
      plannedStartDate: map['PlannedStartDate'] ?? '',
      plannedStartDate2: map['PlannedStartDate2'] ?? '',
      plannedStartDate3: map['PlannedStartDate3'] ?? '',
      custContactNo: map['CustContactNo'] ?? '',
      srStatusID: map['SRStatusID'] ?? '',
      srStatus: map['SRStatus'] ?? '',
      sREngineerName: map['SREngineerName'] ?? '',
      dealerID: map['DealerID'] ?? '',
      dealerBranchesID: map['DealerBranchesID'] ?? '',
      verticalId: map['VerticalId'] ?? '',
      sContactNo: map['SContactNo'] ?? '',
      modifiedDate: map['ModifiedDate'] ?? '',
      districtID: map['DistrictID'] ?? '',
      districtName: map['DistrictName'] ?? '',
      applicationId: map['ApplicationId'] ?? '',
      description: map['Description'],
      isManualCall: map['IsManualCall'] ?? false,
      chargerSerialNo: map['ChargerSerialNo'],
      chargerModel: map['ChargerModel'],
      parntGroup: map['parntGroup'],
      loctnCd: map['loctnCd'],
      stageStatus: map['stageStatus'] ?? '',
      overallStatus: map['overallStatus'] ?? '',
      proofDocURL: map['proofDocURL'] ?? '',
      siteAddress: map['SiteAddress'] ?? '',
      vehicleModel: map['VehicleModel'],
      locationLevelOfParking: map['LocationLevelOfParking'],
      uniqueID: map['UniqueID'],
      vinNo: map['VINNo'],
      adJSON: map['ADJSON'] ?? '',
      surveyReportSRNumber: map['SurveyReportSRNumber'] ?? '',
      siteValidationRequestSRNumber: map['SiteValidationRequestSRNumber'] ?? '',
      installationRequestSRNumber: map['InstallationRequestSRNumber'] ?? '',
      dealerLocation: map['DealerLocation'] ?? '',
      surveyCableSize: map['SurveyCableSize'],
      surveyCableLength: map['SurveyCableLength'],
      surveySrID: map['SurveySrID'],
      newAddress: map['NewAddress'] ?? '',
      imagePath: map['imagePath'],
    );
  }

  factory ServiceRequest.dbFromMap(Map<String, dynamic> map) {
    return ServiceRequest(
      bookingReferenceNo: map['bookingReferenceNo'] ?? '',
      complaintDescription: map['complaintDescription'] ?? '',
      srnumber: map['srnumber'] ?? '',
      customerName: map['customerName'] ?? '',
      customerType: map['customerType'] ?? '',
      srid: map['srid'] ?? '',
      requestedDate: map['requestedDate'] ?? '',
      kVA: map['kVA'] ?? '',
      dealerCode: map['dealerCode'] ?? '',
      dealerName: map['dealerName'] ?? '',
      stateID: map['stateID'] ?? '',
      stateName: map['stateName'] ?? '',
      srTypeID: map['srTypeID'] ?? '',
      srType: map['srType'] ?? '',
      plannedStartDate: map['plannedStartDate'] ?? '',
      plannedStartDate2: map['plannedStartDate2'] ?? '',
      plannedStartDate3: map['plannedStartDate3'] ?? '',
      custContactNo: map['custContactNo'] ?? '',
      srStatusID: map['srStatusID'] ?? '',
      srStatus: map['srStatus'] ?? '',
      sREngineerName: map['sREngineerName'] ?? '',
      dealerID: map['dealerID'] ?? '',
      dealerBranchesID: map['dealerBranchesID'] ?? '',
      verticalId: map['verticalId'] ?? '',
      sContactNo: map['sContactNo'] ?? '',
      modifiedDate: map['modifiedDate'] ?? '',
      districtID: map['districtID'] ?? '',
      districtName: map['districtName'] ?? '',
      applicationId: map['applicationId'] ?? '',
      description: map['description'],
      isManualCall: (map['isManualCall'] ?? 0) == 1,
      stageStatus: map['stageStatus'] ?? '',
      overallStatus: map['overallStatus'] ?? '',
      proofDocURL: map['proofDocURL'] ?? '',
      siteAddress: map['siteAddress'] ?? '',
      adJSON: map['adJSON'] ?? '',
      surveyReportSRNumber: map['surveyReportSRNumber'] ?? '',
      siteValidationRequestSRNumber: map['siteValidationRequestSRNumber'] ?? '',
      installationRequestSRNumber: map['installationRequestSRNumber'] ?? '',
      dealerLocation: map['dealerLocation'] ?? '',
      newAddress: map['newAddress'] ?? '',
      imagePath: map['imagePath'],
    );
  }
}
