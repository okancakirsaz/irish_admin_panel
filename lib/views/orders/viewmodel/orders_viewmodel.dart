import 'package:flutter/material.dart';
import 'package:irish_admin_panel/views/orders/models/order_response_model.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../services/orders_services.dart';

part 'orders_viewmodel.g.dart';

class OrdersViewModel = _OrdersViewModelBase with _$OrdersViewModel;

abstract class _OrdersViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() {}

  final OrdersServices services = OrdersServices();

  @observable
  ObservableList<OrderResponseModel> orders =
      ObservableList<OrderResponseModel>.of([]);

  //Returning random data because this function using in a FutureBuilder
  @action
  Future<int> getOrders() async {
    final List<OrderResponseModel>? response = await services.getAllOrders();
    if (response == null) {
      showErrorDialog();
    } else {
      orders = ObservableList<OrderResponseModel>.of(response);
    }
    return 1;
  }

  String orderListRefactor(List orderList) {
    String refactoredString = "";
    for (int i = 0; i <= orderList.length - 1; i++) {
      refactoredString += "${orderList[i]["name"]} x${orderList[i]["count"]}";
    }
    return refactoredString;
  }
}
