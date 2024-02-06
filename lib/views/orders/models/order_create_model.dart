class OrderCreateModel {
  List<dynamic> orderList;
  int totalPrice;
  String timestamp;
  String userId;

  OrderCreateModel(
      {required this.orderList,
      required this.totalPrice,
      required this.timestamp,
      required this.userId});

  Map<String, dynamic> toJson() {
    return {
      'orderList': orderList,
      'totalPrice': totalPrice,
      'timestamp': timestamp,
      'userId': userId
    };
  }

  factory OrderCreateModel.fromJson(Map<String, dynamic> json) {
    return OrderCreateModel(
        orderList: (json['orderList'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        totalPrice: json['totalPrice'] as int,
        timestamp: json['timestamp'] as String,
        userId: json['userId'] as String);
  }

  @override
  String toString() =>
      "OrderCreateModel(orderList: $orderList,totalPrice: $totalPrice,timestamp: $timestamp)";

  @override
  int get hashCode => Object.hash(orderList, totalPrice, timestamp);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderCreateModel &&
          runtimeType == other.runtimeType &&
          orderList == other.orderList &&
          totalPrice == other.totalPrice &&
          timestamp == other.timestamp;
}
