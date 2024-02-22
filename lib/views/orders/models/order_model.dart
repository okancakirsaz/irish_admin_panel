class OrderModel {
  List<dynamic> orderList;
  int totalPrice;
  String timestamp;
  bool isOrderReady;
  String userId;
  String? duelWinner;
  int orderId;

  OrderModel({
    required this.orderList,
    required this.userId,
    required this.totalPrice,
    required this.timestamp,
    this.duelWinner,
    required this.isOrderReady,
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderList': orderList,
      'totalPrice': totalPrice,
      'timestamp': timestamp,
      'userId': userId,
      'duelWinner': duelWinner,
      'isOrderReady': isOrderReady,
      'orderId': orderId,
    };
  }

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderList: (json['orderList'] as List<dynamic>)
          .map((e) => e as dynamic)
          .toList(),
      totalPrice: json['totalPrice'] as int,
      timestamp: json['timestamp'] as String,
      isOrderReady: json['isOrderReady'] as bool,
      orderId: json['orderId'] as int,
      duelWinner: json['duelWinner'] as String?,
      userId: json['userId'] as String,
    );
  }

  @override
  String toString() =>
      "OrderModel(orderList: $orderList,totalPrice: $totalPrice,timestamp: $timestamp,isOrderReady: $isOrderReady,orderId: $orderId, winner:$duelWinner)";

  @override
  int get hashCode =>
      Object.hash(orderList, totalPrice, timestamp, isOrderReady, orderId);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderModel &&
          runtimeType == other.runtimeType &&
          orderList == other.orderList &&
          totalPrice == other.totalPrice &&
          timestamp == other.timestamp &&
          isOrderReady == other.isOrderReady &&
          orderId == other.orderId;
}
