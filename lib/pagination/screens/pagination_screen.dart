import 'dart:convert';
import 'package:assignment/pagination/models/pagination_model.dart';
import 'package:assignment/pagination/models/product_model.dart';
import 'package:assignment/pagination/screens/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PaginationScreen extends StatefulWidget {
  const PaginationScreen({super.key});

  @override
  State<PaginationScreen> createState() => _PaginationScreenState();
}

class _PaginationScreenState extends State<PaginationScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  bool _isLoading = false;
  bool _hasMoreData = true;
  int _currentPage = 1;
  final int _pageSize = 20;

  final String _bearerToken =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoxLCJyb2xlIjowLCJpYXQiOjE3Mzk4NzA2ODUsImV4cCI6MTczOTk1NzA4NX0.Zqaiph8ejf3CJv7l_aAA8hKaEPOGeUJxWtpuNPBMSLw';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    if (_isLoading || !_hasMoreData) return;

    setState(() {
      _isLoading = true;
    });

    var url = Uri.parse(
        'https://api.sahakaragencies.com/api/product/getAll?pageNo=$_currentPage&pageSize=$_pageSize&search=&sortColumn=product_id&status=1&sortDirection=desc');

    try {
      var response = await http.get(
        url,
        headers: {
          'Authorization': _bearerToken,
        },
      );

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final pagination = Pagination.fromJson(json);

        setState(() {
          if (pagination.pagination.remainingPages == 0) {
            _hasMoreData = false;
          }

          products.addAll(pagination.products);
          _isLoading = false;
          _currentPage++;
        });
      } else {
        print('Response failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _loadMoreData(ScrollController controller) {
    if (controller.position.pixels == controller.position.maxScrollExtent) {
      fetchProducts();
    }
  }

  void _filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((product) =>
              product.productName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    _scrollController.addListener(() => _loadMoreData(_scrollController));

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Pagination',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterProducts,
              decoration: InputDecoration(
                labelText: 'Search Products...',
                hintText: 'Search by name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: products.length + 1,
              itemBuilder: (context, index) {
                if (index == products.length) {
                  return _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink();
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                          color: Colors.grey.withOpacity(0.2), width: 1),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(
                        products[index].productId.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        children: [
                          Text(products[index].productTitle),
                          Text(products[index].productName),
                        ],
                      ),
                      trailing: IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: () {}),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
