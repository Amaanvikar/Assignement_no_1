import 'package:assignment/pagination/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  // Constructor to receive the product
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.productName),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProductImageSection(),
          const SizedBox(height: 16),
          _buildProductDetails(),
          const SizedBox(height: 16),
          _buildPricingSection(),
          const SizedBox(height: 16),
          _buildManufacturerSection(),
          const SizedBox(height: 16),
          _buildAdditionalInfo(),
        ],
      ),
    );
  }

  // Product images section
  Widget _buildProductImageSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Product Images',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        product.productImages.isNotEmpty
            ? SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: product.productImages.length,
                  itemBuilder: (context, index) {
                    // return Padding(
                    //   padding: const EdgeInsets.only(right: 8),
                    //   // child: Image.network(
                    //   //   product.productImages[index].url,
                    //   //   width: 150,
                    //   //   height: 150,
                    //   //   fit: BoxFit.cover,
                    //   // ),
                    // );
                  },
                ),
              )
            : const Text('No images available'),
      ],
    );
  }

  // Product details section
  Widget _buildProductDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow('Product Part Code:', product.productPartCode),
        _buildDetailRow('Data Sheet:', product.productDataSheet),
        _buildDetailRow('Description:', product.productDescription),
        _buildDetailRow('Category ID:', product.categoryId.toString()),
        _buildDetailRow('HSN Code:', product.hsnCode),
        _buildDetailRow('UOM Code:', product.uomCode),
        _buildDetailRow('Country of Origin:', product.countryOfOrigin),
        _buildDetailRow('Factory Lead Time:', product.factoryLeadTime),
      ],
    );
  }

  // Build a row with a label and its value
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text(
            '$label ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  // Pricing section
  Widget _buildPricingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Pricing',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Price:', '₹${product.price.toStringAsFixed(2)}'),
        _buildDetailRow('Discount:', '${product.discount.toStringAsFixed(2)}%'),
        _buildDetailRow(
            'Unit Price:', '₹${product.unitPrice.toStringAsFixed(2)}'),
        _buildDetailRow('Today\'s Deal Price:',
            '₹${product.todayDealPrice.toStringAsFixed(2)}'),
      ],
    );
  }

  // Manufacturer section
  Widget _buildManufacturerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Manufacturer Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Manufacturer:', product.manufacturer),
        _buildDetailRow(
            'Manufacturer Part Number:', product.manufacturerPartNumber),
        _buildDetailRow(
            'Manufacturer Description:', product.manufacturerDescription),
        _buildDetailRow('SVHC:', product.svhc ?? 'Not Available'),
      ],
    );
  }

  // Additional information section
  Widget _buildAdditionalInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Additional Info',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildDetailRow('Weight:', product.weight),
        _buildDetailRow('Stock Count:', product.stockCount.toString()),
        _buildDetailRow('Status:', product.status == 1 ? 'Active' : 'Inactive'),
        _buildDetailRow(
            'Is Grab the Deal:', product.isGrabTheDeal ? 'Yes' : 'No'),
        _buildDetailRow('Is Featured:', product.isFeatured ? 'Yes' : 'No'),
        _buildDetailRow('Created At:', product.createdAt.toLocal().toString()),
        _buildDetailRow('Updated At:', product.updatedAt.toLocal().toString()),
      ],
    );
  }
}
