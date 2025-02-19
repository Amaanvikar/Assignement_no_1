import 'package:assignment/pagination/models/product_model.dart';
import 'package:assignment/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Product> filteredProducts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      drawer: const DrawerWidget(),
      body: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("productId: ${widget.product.productId}",
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const Divider(),
              Text("Description: ${widget.product.productDescription}"),
              const Divider(),
              Text("categories: ${widget.product.categories}"),
            ],
          ),
        ),
      ),
    );
  }
}
