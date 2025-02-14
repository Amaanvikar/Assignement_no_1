import 'package:http/http.dart' as http;

class ApiService {
  static Future<http.Response> fetchSyncData({
    required int dealerBranchesID,
    required int dealerID,
    required String magicCode,
    required int roleID,
    required int roleLevelID,
    required String loginID,
  }) async {
    String url = getSyncDataUrl(
      dealerBranchesID: dealerBranchesID,
      dealerID: dealerID,
      magicCode: magicCode,
      roleID: roleID,
      roleLevelID: roleLevelID,
      loginID: loginID,
    );

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
    return 'https://epoweroluat.mahindra.com/PowerolMWS/PowerolDMS_MWS.asmx/SyncDataForEVEFSR'
        '?DealerBranchesID=$dealerBranchesID'
        '&DealerID=$dealerID'
        '&MagiecCode=$magicCode'
        '&RoleID=$roleID'
        '&RoleLevelID=$roleLevelID'
        '&LoginID=$loginID';
  }
}
