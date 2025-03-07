import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelper {
  static const String baseUrl =
      "https://jsonplaceholder.typicode.com"; // Base URL

  // Function for GET Request
  static Future<Map<String, dynamic>?> getRequest(String endpoint,
      {Map<String, String>? params, Map<String, String>? headers}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      final response = await _sendRequest(uri, 'GET', headers: headers);

      return _handleResponse(response);
    } catch (e) {
      print("Exception in GET request: $e");
      return {'error': 'GET request failed'};
    }
  }

  // Function for POST Request
  static Future<Map<String, dynamic>?> postRequest(String endpoint,
      {Map<String, String>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint');
      final response =
          await _sendRequest(uri, 'POST', body: {}, headers: headers);

      return _handleResponse(response);
    } catch (e) {
      print("Exception in POST request: $e");
      return {'error': 'POST request failed'};
    }
  }

  // Function for PUT Request
  static Future<Map<String, dynamic>?> putRequest(String endpoint,
      {Map<String, String>? params,
      Map<String, dynamic>? body,
      Map<String, String>? headers}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      final response =
          await _sendRequest(uri, 'PUT', body: {}, headers: headers);

      return _handleResponse(response);
    } catch (e) {
      print("Exception in PUT request: $e");
      return {'error': 'PUT request failed'};
    }
  }

  // Function for DELETE Request
  static Future<Map<String, dynamic>?> deleteRequest(String endpoint,
      {Map<String, String>? params, Map<String, String>? headers}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);
      final response = await _sendRequest(uri, 'DELETE', headers: headers);

      return _handleResponse(response);
    } catch (e) {
      print("Exception in DELETE request: $e");
      return {'error': 'DELETE request failed'};
    }
  }

  // Internal function for sending HTTP requests
  static Future<http.Response> _sendRequest(Uri uri, String method,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    Map<String, String> defaultHeaders = {
      'Content-Type': 'application/json',
      'Authorization': '', // auth token
    };

    // Merge provided headers with default headers
    headers?.addAll(defaultHeaders);

    // Send the appropriate HTTP request
    switch (method.toUpperCase()) {
      case 'POST':
        return await http.post(uri, headers: headers, body: jsonEncode(body));
      case 'PUT':
        return await http.put(uri, headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return await http.delete(uri, headers: headers);
      case 'GET':
      default:
        return await http.get(uri, headers: headers);
    }
  }

  // Function for Reusable Response Handler
  static Map<String, dynamic>? _handleResponse(http.Response response) {
    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Decode the JSON response
      } else {
        print("API Error: ${response.statusCode} - ${response.body}");
        return {'error': 'API error ${response.statusCode} - ${response.body}'};
      }
    } catch (e) {
      print("Error processing response: $e");
      return {'error': 'Error processing response'};
    }
  }

  // Function to handle multipart (file upload) requests
  static Future<Map<String, dynamic>?> multipartRequest(String endpoint,
      {Map<String, String>? params,
      Map<String, String>? headers,
      Map<String, String>? fields,
      List<http.MultipartFile>? files}) async {
    try {
      Uri uri = Uri.parse('$baseUrl$endpoint').replace(queryParameters: params);

      var request = http.MultipartRequest('POST', uri)
        ..headers.addAll(headers ?? {})
        ..fields.addAll(fields ?? {});

      if (files != null) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      return _handleResponse(response);
    } catch (e) {
      print("Exception in Multipart request: $e");
      return {'error': 'Multipart request failed'};
    }
  }

  // Function to handle request timeout (optional)
  static Future<http.Response> sendRequestWithTimeout(Uri uri, String method,
      {Map<String, String>? body, Map<String, String>? headers}) async {
    final response =
        await _sendRequest(uri, method, body: body, headers: headers)
            .timeout(Duration(seconds: 30));
    return response;
  }
}
