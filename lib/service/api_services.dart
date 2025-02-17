import 'package:assignment/service/key_service.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> fetchSyncData() async {
    KeyService keyService = KeyService();
    await keyService.init();
    Map<String, dynamic>? keyStoreData = await keyService.retrieveUserData();

    String url = getSyncDataUrl(
      dealerBranchesID: keyStoreData!["DealerBranchID"],
      dealerID: keyStoreData["DealerID"],
      magicCode: keyStoreData["DealerCode"],
      roleID: keyStoreData["RoleID"],
      roleLevelID: keyStoreData["RoleLevelID"],
      loginID: keyStoreData["LoginId"],
    );

    print(url);

    final response = await http.get(Uri.parse(url));
    return response;
  }

  static String getSyncDataUrl({
    required int dealerBranchesID,
    required int dealerID,
    required String magicCode,
    required int roleID,
    required int roleLevelID,
    required String loginID,
  }) {
    print(magicCode);

    return 'https://epoweroluat.mahindra.com/PowerolMWS/PowerolDMS_MWS.asmx/SyncDataForEVEFSR'
        '?DealerBranchesID=$dealerBranchesID'
        '&DealerID=$dealerID'
        '&MagiecCode=$magicCode'
        '&RoleID=$roleID'
        '&RoleLevelID=$roleLevelID'
        '&LoginID=$loginID';
  }
}
