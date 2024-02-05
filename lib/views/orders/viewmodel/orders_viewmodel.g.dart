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
  ObservableList<OrderResponseModel> get orders {
    _$ordersAtom.reportRead();
    return super.orders;
  }

  @override
  set orders(ObservableList<OrderResponseModel> value) {
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

  @override
  String toString() {
    return '''
orders: ${orders}
    ''';
  }
}
