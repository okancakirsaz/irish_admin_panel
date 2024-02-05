import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/consts/color_consts/color_consts.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/views/orders/viewmodel/orders_viewmodel.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<OrdersViewModel>(
        viewModel: OrdersViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: FutureBuilder(
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
      child: ListView.builder(
          itemCount: viewModel.orders.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: PaddingConsts.instance.all5,
              child: Card(
                child: ListTile(
                  title: Text(
                    "Sipariş Numarası: ${viewModel.orders[index].orderId}, Toplam Ücret: ${viewModel.orders[index].totalPrice}₺",
                    style: TextConsts.instance.regularBlack18Bold,
                  ),
                  subtitle: Text(
                    "Sipariş Detayı: ${viewModel.orderListRefactor(viewModel.orders[index].orderList)}",
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
                          onPressed: () async {},
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
          }),
    );
  }
}
