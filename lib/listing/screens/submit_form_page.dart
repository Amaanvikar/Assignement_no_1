import 'package:assignment/common/connectivity_helper.dart';
import 'package:flutter/material.dart';

class SubmitFormPage extends StatefulWidget {
  const SubmitFormPage({super.key});

  @override
  State<SubmitFormPage> createState() => _SubmitFormPageState();
}

class _SubmitFormPageState extends State<SubmitFormPage> {
  final TextEditingController submitController = TextEditingController();

  void submitForm() async {
    bool isConnected = await ConnectivityHelper.isConnected();

    if (isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Form Submitted Succesfully!'),
        duration: Duration(seconds: 1),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('No Internet Connection!'),
        duration: Duration(seconds: 1),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'check Connectivity Form',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: submitController,
              decoration: InputDecoration(
                  labelText: "Enter", border: OutlineInputBorder()),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: submitForm,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
