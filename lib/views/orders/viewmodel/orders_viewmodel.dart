import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/init/cache/local_keys_enums.dart';
import 'package:irish_admin_panel/core/init/web_socket_manager.dart';
import 'package:irish_admin_panel/views/menu/models/menu_item_model.dart';
import 'package:irish_admin_panel/views/menu/viewmodel/menu_viewmodel.dart';
import 'package:irish_admin_panel/views/orders/models/order_create_model.dart';
import 'package:irish_admin_panel/views/orders/models/order_model.dart';
import 'package:irish_admin_panel/views/orders/view/orders_view.dart';
import '../../../../core/base/viewmodel/base_viewmodel.dart';
import 'package:mobx/mobx.dart';

import '../services/orders_services.dart';

part 'orders_viewmodel.g.dart';

class OrdersViewModel = _OrdersViewModelBase with _$OrdersViewModel;

abstract class _OrdersViewModelBase with Store, BaseViewModel {
  @override
  void setContext(BuildContext context) => viewModelContext = context;
  @override
  init() async {
    await getMenuItems();
    handleNewOrder();
  }

  final OrdersServices services = OrdersServices();

  @observable
  ObservableList<OrderModel> orders = ObservableList<OrderModel>.of([]);
  List<MenuItemModel> menu = [];

  @observable
  ObservableList<int> menuItemCounts = ObservableList<int>.of([]);

  @observable
  ObservableList<Map<String, dynamic>> orderedFoods =
      ObservableList<Map<String, dynamic>>.of([]);

  @observable
  int totalPrice = 0;

  //We must return any data because this function using in a FutureBuilder
  @action
  Future<int> getOrders() async {
    final List<OrderModel>? response = await services.getAllOrders();
    if (response == null) {
      showErrorDialog();
    } else {
      orders = ObservableList<OrderModel>.of(response.reversed.toList());
    }
    return 1;
  }

  @action
  handleNewOrder() {
    WebSocketManager.instance.webSocketReceiver("new_order", (data) {
      if (data != null) {
        orders.add(OrderModel.fromJson(data));
      }
    });
  }

  String orderListRefactor(List orderList) {
    String refactoredString = "";
    for (int i = 0; i <= orderList.length - 1; i++) {
      refactoredString += "${orderList[i]["name"]} x${orderList[i]["count"]}";
    }
    return refactoredString;
  }

  @action
  Future<void> deleteOrder(OrderModel data) async {
    if (!data.isOrderReady) {
      showErrorDialog("Tamamlanmayan sipariş silinemez!");
    } else {
      final OrderModel? response = await services.deleteOrder(data);

      if (response != null) {
        orders.remove(data);
      }
    }
  }

  navigateToCreateOrderPage(OrdersViewModel viewModel) {
    Navigator.push(
      viewModelContext,
      MaterialPageRoute(
        builder: (context) => CreateOrderView(
          viewModel: viewModel,
        ),
      ),
    );
  }

  @action
  Future<void> changeOrderState(OrderModel data, int index) async {
    final OrderModel? response = await services.submitOrder(data);
    if (response != null) {
      orders[index] = response;
    } else {
      showErrorDialog();
    }
  }

  getMenuItems() async {
    List? rawList =
        localeManager.getNullableJsonData(LocaleKeysEnums.menu.name);

    if (rawList == null) {
      //Dependency Injection
      final MenuViewModel menuVm = MenuViewModel();
      menuVm.setContext(viewModelContext);
      await menuVm.getMenu();
      rawList = localeManager.getJsonData(LocaleKeysEnums.menu.name);
    }
    for (Map<String, dynamic> element in rawList ?? []) {
      menu.add(MenuItemModel.fromJson(element));
      menuItemCounts.add(1);
    }
  }

  @action
  incrementCount(int index) {
    if (menuItemCounts[index] <= 9) {
      menuItemCounts[index]++;
    }
  }

  @action
  decrementCount(int index) {
    if (menuItemCounts[index] >= 2) {
      menuItemCounts[index]--;
    }
  }

  @action
  addToOrderList(MenuItemModel item, int index) {
    orderedFoods.add({"name": item.name, "count": menuItemCounts[index]});
    fetchTotalPrice(int.parse(item.price!) * menuItemCounts[index]);
    resetMenuItemCount(index);
  }

  resetMenuItemCount(int index) {
    menuItemCounts[index] = 1;
  }

  @action
  fetchTotalPrice(int newCost) {
    totalPrice += newCost;
  }

  Future<void> createOrder() async {
    if (orderedFoods.isNotEmpty) {
      await setNewOrder();
      navigatorPop();
      resetCreateOrderPageValues();
    } else {
      showErrorDialog("Önce bir şeyler eklemelisiniz.");
    }
  }

  resetCreateOrderPageValues() {
    orderedFoods = ObservableList<Map<String, dynamic>>.of([]);
    totalPrice = 0;
  }

  Future<void> setNewOrder() async {
    final OrderModel? response = await services.createOrder(
      OrderCreateModel(
          orderList: orderedFoods,
          totalPrice: totalPrice,
          timestamp: DateTime.now().toIso8601String(),
          userId: "admin-panel"),
    );

    if (response == null) {
      showErrorDialog();
    }
  }
}
