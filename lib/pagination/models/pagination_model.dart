import 'package:assignment/pagination/models/product_model.dart';

class Pagination {
  final List<Product> products;
  final PaginationInfo pagination;

  Pagination({
    required this.products,
    required this.pagination,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      products:
          (json['data'] as List).map((item) => Product.fromJson(item)).toList(),
      pagination: PaginationInfo.fromJson(json['pagination']),
    );
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     'data': products.map((item) => item.toJson()).toList(),
  //     'pagination': pagination.toJson(),
  //   };
  // }
}

class PaginationInfo {
  final int currentPage;
  final int totalPages;
  final int totalItems;
  final int remainingPages;

  PaginationInfo({
    required this.currentPage,
    required this.totalPages,
    required this.totalItems,
    required this.remainingPages,
  });

  factory PaginationInfo.fromJson(Map<String, dynamic> json) {
    return PaginationInfo(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
      totalItems: json['totalItems'],
      remainingPages: json['remainingPages'],
    );
  }
}
