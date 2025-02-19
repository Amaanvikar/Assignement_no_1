import 'dart:convert';
import 'package:assignment/models/service_request_models.dart';
import 'package:assignment/service/api_services.dart';
import 'package:assignment/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import '../../models/db_helper.dart';
import 'details_page.dart';

class fetchData extends StatefulWidget {
  @override
  _fetchDataState createState() => _fetchDataState();
}

class _fetchDataState extends State<fetchData> {
  List<ServiceRequest> serviceRequests = [];
  final DatabaseService dbHelper = DatabaseService.instance;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final localData = await dbHelper.getServiceRequests();
    print("Checking Local Database Data...");
    if (localData.isEmpty) {
      await fetchAndStoreData();
    } else {
      print("Local Data Loaded Successfully.");
      print(localData[0].toMap());
      setState(() {
        serviceRequests = localData;
      });
    }
  }

  Future<void> fetchAndStoreData() async {
    try {
      final response = await ApiService.fetchSyncData();

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['SyncData'] != null) {
          List<ServiceRequest> fetchedRequests = (data['SyncData'] as List)
              .map((json) => ServiceRequest.fromMap(json))
              .toList();

          for (var request in fetchedRequests) {
            await dbHelper.insertServiceRequest(request);
          }

          setState(() {
            serviceRequests = fetchedRequests;
          });

          print("Data successfully fetched and stored.");
        } else {
          print("No data found in API response.");
        }
      } else {
        print("Failed to load data, Status Code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Service Requests")),
      drawer: const DrawerWidget(),
      body: serviceRequests.isEmpty
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: fetchAndStoreData,
              child: ListView.builder(
                itemCount: serviceRequests.length,
                itemBuilder: (context, index) {
                  final item = serviceRequests[index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text("SR No: ${item.srnumber}"),
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
