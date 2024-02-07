// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orders_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$OrdersViewModel on _OrdersViewModelBase, Store {
  late final _$ordersAtom =
      Atom(name: '_OrdersViewModelBase.orders', context: context);

  @override
  ObservableList<OrderModel> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<OrderModel> value) {
    _$ordersAtom.reportWrite(value, super.orders, () {
      super.orders = value;
    });
  }

  late final _$getOrdersAsyncAction =
      AsyncAction('_OrdersViewModelBase.getOrders', context: context);

  @override
  Future<int> getOrders() {
    return _$getOrdersAsyncAction.run(() => super.getOrders());
  }

  late final _$deleteOrderAsyncAction =
      AsyncAction('_OrdersViewModelBase.deleteOrder', context: context);

  @override
  Future<void> deleteOrder(OrderModel data) {
    return _$deleteOrderAsyncAction.run(() => super.deleteOrder(data));
  }

  late final _$changeOrderStateAsyncAction =
      AsyncAction('_OrdersViewModelBase.changeOrderState', context: context);

  @override
  Future<void> changeOrderState(OrderModel data, int index) {
    return _$changeOrderStateAsyncAction
        .run(() => super.changeOrderState(data, index));
  }

  late final _$_OrdersViewModelBaseActionController =
      ActionController(name: '_OrdersViewModelBase', context: context);

  @override
  dynamic handleNewOrder() {
    final _$actionInfo = _$_OrdersViewModelBaseActionController.startAction(
        name: '_OrdersViewModelBase.handleNewOrder');
    try {
      return super.handleNewOrder();
    } finally {
      _$_OrdersViewModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
orders: ${orders}
    ''';
  }
}
