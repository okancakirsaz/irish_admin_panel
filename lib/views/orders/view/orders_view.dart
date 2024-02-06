import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/consts/color_consts/color_consts.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/radius_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/widgets/custom_button.dart';
import 'package:irish_admin_panel/views/orders/models/order_model.dart';
import 'package:irish_admin_panel/views/orders/viewmodel/orders_viewmodel.dart';

part 'components/create_order_view.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrdersViewModel>(
        viewModel: OrdersViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Padding(
                  padding: PaddingConsts.instance.all20,
                  child: CustomButton(
                      onPressed: () => model.navigateToCreateOrderPage(),
                      style: TextConsts.instance.regularBlack25Bold,
                      text: "Sipariş Oluştur",
                      width: double.infinity,
                      height: 70),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: model.getOrders(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return buildOrders(model);
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: ColorConsts.instance.orange,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: () {});
  }

  Widget buildOrders(OrdersViewModel viewModel) {
    return RefreshIndicator(
      onRefresh: () async => await viewModel.getOrders(),
      color: ColorConsts.instance.orange,
      child: Observer(builder: (context) {
        return ListView.builder(
            itemCount: viewModel.orders.length,
            itemBuilder: (context, index) {
              OrderModel order = viewModel.orders[index];

              return Padding(
                padding: PaddingConsts.instance.all5,
                child: Card(
                  child: ListTile(
                    title: Text(
                      "Sipariş Numarası: ${order.orderId}, Toplam Ücret: ${order.totalPrice}₺, ${order.isOrderReady ? "Hazır." : "Hazır değil."}",
                      style: TextConsts.instance.regularBlack18Bold,
                    ),
                    subtitle: Text(
                      "Sipariş Detayı: ${viewModel.orderListRefactor(order.orderList)}",
                      style: TextConsts.instance.regularBlack14,
                    ),
                    trailing: SizedBox(
                      width: 122,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            onPressed: () async {},
                            icon: Icon(
                              Icons.done,
                              color: ColorConsts.instance.green,
                              size: 45,
                            ),
                          ),
                          IconButton(
                            onPressed: () async =>
                                await viewModel.deleteOrder(order),
                            icon: Icon(
                              Icons.delete,
                              color: ColorConsts.instance.red,
                              size: 45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      }),
    );
  }
}
