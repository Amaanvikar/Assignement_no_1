// import 'package:flutter/material.dart';
// import 'package:assignment/models.dart';
// import 'db_helper.dart';
// import 'details_page.dart';

// class ListingPage extends StatefulWidget {
//   @override
//   _ListingPageState createState() => _ListingPageState();
// }

// class _ListingPageState extends State<ListingPage> {
//   List<ServiceRequest> serviceRequests = [];
//   final DBHelper dbHelper = DBHelper();

//   @override
//   void initState() {
//     super.initState();
//     _loadDataFromLocalDB();
//   }

//   Future<void> _loadDataFromLocalDB() async {
//     final localData = await dbHelper.getServiceRequests();
//     setState(() {
//       serviceRequests = localData;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Service Requests")),
//       body: serviceRequests.isEmpty
//           ? Center(child: Text("No data available."))
//           : ListView.builder(
//               itemCount: serviceRequests.length,
//               itemBuilder: (context, index) {
//                 final item = serviceRequests[index];
//                 return Card(
//                   margin: EdgeInsets.all(8.0),
//                   child: ListTile(
//                     title: Text("SR No: ${item.srNumber}"),
//                     subtitle: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Customer: ${item.customerName}"),
//                         Text("Status: ${item.srStatus}"),
//                         Text("Type: ${item.srType}"),
//                         Text("Dealer: ${item.dealerName}"),
//                       ],
//                     ),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => DetailsPage(data: item),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../auth/login_page.dart';

class ListingPage extends StatefulWidget {
  @override
  _ListingPageState createState() => _ListingPageState();
}

class _ListingPageState extends State<ListingPage> {
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Service Requests"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: logout, // Logout action
          )
        ],
      ),
      body: const Center(child: Text("Listing Page Content Here")),
    );
  }
}
