import 'dart:convert';

class ServiceRequest {
  final String bookingReferenceNo;
  final String complaintDescription;
  final String srNumber;
  final String customerName;
  final String customerType;
  final String srId;
  final String requestedDate;
  final String kVA;
  final String dealerCode;
  final String dealerName;
  final String stateId;
  final String stateName;
  final String srTypeId;
  final String srType;
  final String? latitude;
  final String? longitude;
  final String plannedStartDate;
  final String plannedStartDate2;
  final String plannedStartDate3;
  final String custContactNo;
  final String srStatusId;
  final String srStatus;
  final String srEngineerName;
  final String dealerId;
  final String dealerBranchesId;
  final String verticalId;
  final String sContactNo;
  final String modifiedDate;
  final String districtId;
  final String districtName;
  final String applicationId;
  final String? description;
  final bool isManualCall;
  final String? chargerSerialNo;
  final String? chargerModel;
  final String? parntGroup;
  final String? loctnCd;
  final String stageStatus;
  final String overallStatus;
  final String proofDocURL;
  final String siteAddress;
  final String? vehicleModel;
  final String? locationLevelOfParking;
  final String? uniqueId;
  final String? vinNo;
  final String adJson;
  final String surveyReportSRNumber;
  final String siteValidationRequestSRNumber;
  final String installationRequestSRNumber;
  final String dealerLocation;
  final String? surveyCableSize;
  final String? surveyCableLength;
  final String? surveySrId;
  final String newAddress;

  ServiceRequest({
    required this.bookingReferenceNo,
    required this.complaintDescription,
    required this.srNumber,
    required this.customerName,
    required this.customerType,
    required this.srId,
    required this.requestedDate,
    required this.kVA,
    required this.dealerCode,
    required this.dealerName,
    required this.stateId,
    required this.stateName,
    required this.srTypeId,
    required this.srType,
    this.latitude,
    this.longitude,
    required this.plannedStartDate,
    required this.plannedStartDate2,
    required this.plannedStartDate3,
    required this.custContactNo,
    required this.srStatusId,
    required this.srStatus,
    required this.srEngineerName,
    required this.dealerId,
    required this.dealerBranchesId,
    required this.verticalId,
    required this.sContactNo,
    required this.modifiedDate,
    required this.districtId,
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
    this.uniqueId,
    this.vinNo,
    required this.adJson,
    required this.surveyReportSRNumber,
    required this.siteValidationRequestSRNumber,
    required this.installationRequestSRNumber,
    required this.dealerLocation,
    this.surveyCableSize,
    this.surveyCableLength,
    this.surveySrId,
    required this.newAddress,
  });

  factory ServiceRequest.fromJson(Map<String, dynamic> json) {
    return ServiceRequest(
      bookingReferenceNo: json['BookingReferenceNo'] ?? '',
      complaintDescription: json['ComplaintDescription'] ?? '',
      srNumber: json['srnumber'] ?? '',
      customerName: json['CustomerName'] ?? '',
      customerType: json['CustomerType'] ?? '',
      srId: json['SRID'] ?? '',
      requestedDate: json['RequestedDate'] ?? '',
      kVA: json['kVA'] ?? '',
      dealerCode: json['DealerCode'] ?? '',
      dealerName: json['DealerName'] ?? '',
      stateId: json['StateID'] ?? '',
      stateName: json['StateName'] ?? '',
      srTypeId: json['SRTypeID'] ?? '',
      srType: json['SRType'] ?? '',
      latitude: json['Latitude'],
      longitude: json['Longitude'],
      plannedStartDate: json['PlannedStartDate'] ?? '',
      plannedStartDate2: json['PlannedStartDate2'] ?? '',
      plannedStartDate3: json['PlannedStartDate3'] ?? '',
      custContactNo: json['CustContactNo'] ?? '',
      srStatusId: json['SRStatusID'] ?? '',
      srStatus: json['SRStatus'] ?? '',
      srEngineerName: json['SREngineerName'] ?? '',
      dealerId: json['DealerID'] ?? '',
      dealerBranchesId: json['DealerBranchesID'] ?? '',
      verticalId: json['VerticalId'] ?? '',
      sContactNo: json['SContactNo'] ?? '',
      modifiedDate: json['ModifiedDate'] ?? '',
      districtId: json['DistrictID'] ?? '',
      districtName: json['DistrictName'] ?? '',
      applicationId: json['ApplicationId'] ?? '',
      description: json['Description'],
      isManualCall: json['IsManualCall'] ?? false,
      chargerSerialNo: json['ChargerSerialNo'],
      chargerModel: json['ChargerModel'],
      parntGroup: json['parntGroup'],
      loctnCd: json['loctnCd'],
      stageStatus: json['stageStatus'] ?? '',
      overallStatus: json['overallStatus'] ?? '',
      proofDocURL: json['proofDocURL'] ?? '',
      siteAddress: json['SiteAddress'] ?? '',
      vehicleModel: json['VehicleModel'],
      locationLevelOfParking: json['LocationLevelOfParking'],
      uniqueId: json['UniqueID'],
      vinNo: json['VINNo'],
      adJson: json['ADJSON'] ?? '',
      surveyReportSRNumber: json['SurveyReportSRNumber'] ?? '',
      siteValidationRequestSRNumber:
          json['SiteValidationRequestSRNumber'] ?? '',
      installationRequestSRNumber: json['InstallationRequestSRNumber'] ?? '',
      dealerLocation: json['DealerLocation'] ?? '',
      surveyCableSize: json['SurveyCableSize'],
      surveyCableLength: json['SurveyCableLength'],
      surveySrId: json['SurveySrID'],
      newAddress: json['NewAddress'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'BookingReferenceNo': bookingReferenceNo,
      'ComplaintDescription': complaintDescription,
      'srnumber': srNumber,
      'CustomerName': customerName,
      'CustomerType': customerType,
      'SRID': srId,
      'RequestedDate': requestedDate,
      'kVA': kVA,
      'DealerCode': dealerCode,
      'DealerName': dealerName,
      'StateID': stateId,
      'StateName': stateName,
      'SRTypeID': srTypeId,
      'SRType': srType,
      'Latitude': latitude,
      'Longitude': longitude,
      'PlannedStartDate': plannedStartDate,
      'PlannedStartDate2': plannedStartDate2,
      'PlannedStartDate3': plannedStartDate3,
      'CustContactNo': custContactNo,
      'SRStatusID': srStatusId,
      'SRStatus': srStatus,
      'SREngineerName': srEngineerName,
      'DealerID': dealerId,
      'DealerBranchesID': dealerBranchesId,
      'VerticalId': verticalId,
      'SContactNo': sContactNo,
      'ModifiedDate': modifiedDate,
      'DistrictID': districtId,
      'DistrictName': districtName,
      'ApplicationId': applicationId,
      'Description': description,
      'IsManualCall': isManualCall,
      'ChargerSerialNo': chargerSerialNo,
      'ChargerModel': chargerModel,
      'stageStatus': stageStatus,
      'overallStatus': overallStatus,
      'proofDocURL': proofDocURL,
      'SiteAddress': siteAddress,
      'DealerLocation': dealerLocation,
      'NewAddress': newAddress,
    };
  }
}
