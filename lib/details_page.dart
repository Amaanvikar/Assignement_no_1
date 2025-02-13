import 'package:assignment/models.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final ServiceRequest data;
  DetailsPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Details")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Booking Ref: ${data.bookingReferenceNo}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Complaint: ${data.complaintDescription}"),
            Text("Requested Date: ${data.requestedDate}"),
            Text("Planned Start: ${data.plannedStartDate}"),
            Text("Location: ${data.siteAddress}"),
            Text("Engineer: ${data.srEngineerName}"),
            Text("Customer Contact: ${data.custContactNo}"),
          ],
        ),
      ),
    );
  }
}
