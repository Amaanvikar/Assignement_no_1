import 'dart:convert';
import 'package:assignment/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'db_helper.dart';
import 'details_page.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  List<ServiceRequest> serviceRequests = [];
  final DBHelper dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final localData = await dbHelper.getServiceRequests();
    if (localData.isNotEmpty) {
      setState(() {
        serviceRequests = localData;
      });
    } else {
      await fetchAndStoreData();
    }
  }

  Future<void> fetchAndStoreData() async {
    final response = await http.get(Uri.parse(
        'https://epoweroluat.mahindra.com/PowerolMWS/PowerolDMS_MWS.asmx/SyncDataForEVEFSR?DealerBranchesID=536&DealerID=536&MagiecCode=SDTEST01&RoleID=28&RoleLevelID=3&LoginID=SDEMPTSD00002'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<ServiceRequest> fetchedRequests = (data['SyncData'] as List)
          .map((json) => ServiceRequest.fromJson(json))
          .toList();

      for (var request in fetchedRequests) {
        await dbHelper.insertServiceRequest(request);
      }

      setState(() {
        serviceRequests = fetchedRequests;
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Service Requests")),
      body: serviceRequests.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchAndStoreData,
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (context, index) {
                  final item = serviceRequests[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text("SR No: ${item.srNumber}"),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Customer: ${item.customerName}"),
                          Text("Status: ${item.srStatus}"),
                          Text("Type: ${item.srType}"),
                          Text("Dealer: ${item.dealerName}"),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(data: item),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
    );
  }
}
