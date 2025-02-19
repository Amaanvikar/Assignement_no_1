import 'package:assignment/pagination/screens/pagination_screen.dart';
import 'package:assignment/service/key_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController loginIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  bool isLoading = false;
  String errorMessage = '';

  final String apiUrl =
      "https://epoweroluat.mahindra.com/PowerolMWS/PowerolDMS_MWS.asmx/LoginCheck";

  Future<void> login() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });

    String loginId = loginIdController.text.trim();
    String password = passwordController.text.trim();
    String uniqueCode = usernameController.text.trim();

    try {
      Uri finalUri = Uri.parse(apiUrl).replace(
        queryParameters: {
          "LoginId": loginId,
          "Password": password,
          "UniqueCode": uniqueCode,
        },
      );

      final response = await http.get(finalUri);
      print(response.toString());
      setState(() {
        isLoading = false;
      });

      if (response.statusCode == 200) {
        final decoded_response = jsonDecode(response.body);
        print(decoded_response);
        Map<String, dynamic> data = decoded_response["LoginCheck"][0];

        KeyService keyService = KeyService();
        await keyService.init();
        final userData = {
          "UserId": data["UserId"],
          "LoginId": data["LoginId"],
          "RoleID": data["RoleID"],
          "RoleLevelID": data["RoleLevelID"],
          "DealerID": data["DealerID"],
          "DealerBranchID": data["DealerBranchID"],
          "UserName": data["UserName"],
          "EmailID": data["EmailID"],
          "MobileNo": data["MobileNo"],
          "DealerTypeID": data["DealerTypeID"],
          "IsActive": data["IsActive"],
          "DealerCode": data["DealerCode"],
        };

        await keyService.storeValue("login_data", jsonEncode(userData));
        await keyService.storebool("isLoggedIn", true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful!')),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const PaginationScreen()
              // fetchData()
              ),
        );
      } else {
        setState(() {
          errorMessage =
              'Failed to connect to the server. Status: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = 'An error occurred: $e';
      });
    }
  }

  Future<void> saveUserSession(String userName, String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userEmail', userEmail);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Welcome Back!",
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 20),
                TextField(
                  controller: loginIdController,
                  decoration: InputDecoration(
                    labelText: 'Login ID',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Unique Code',
                    prefixIcon: const Icon(Icons.verified_user),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: login,
                    child: const Text('Login', style: TextStyle(fontSize: 18)),
                  ),
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
