import 'package:equatable/equatable.dart';

class OrderData extends Equatable {
  final String orderId;
  final double profit;
  final String city;
  final String customerName;
  final String productName;
  final String rowId;
  final String country;
  final double discount;
  final String customerId;
  final String region;
  final int quantity;
  final String segment;
  final String state;
  final String shipMode;
  final String subCategory;
  final String postalCode;
  final String shipDate;
  final String category;
  final String productId;
  final double sales;
  final String orderDate;

  OrderData({
    required this.orderId,
    required this.profit,
    required this.city,
    required this.customerName,
    required this.productName,
    required this.rowId,
    required this.country,
    required this.discount,
    required this.customerId,
    required this.region,
    required this.quantity,
    required this.segment,
    required this.state,
    required this.shipMode,
    required this.subCategory,
    required this.postalCode,
    required this.shipDate,
    required this.category,
    required this.productId,
    required this.sales,
    required this.orderDate,
  });

  @override
  String toString() {
    return 
 '''
    \nOrder ID: $orderId
    Profit: $profit
    City: $city
    Customer Name: $customerName
    Product Name: $productName
    Row ID: $rowId
    Country: $country
    Discount: $discount
    Customer ID: $customerId
    Region: $region
    Quantity: $quantity
    Segment: $segment
    State: $state
    Ship Mode: $shipMode
    Sub-Category: $subCategory
    Postal Code: $postalCode
    Ship Date: $shipDate
    Category: $category
    Product ID: $productId
    Sales: $sales
    Order Date: $orderDate
    ''';
  }
  
  @override
  List<Object?> get props => [orderId, rowId];
}
