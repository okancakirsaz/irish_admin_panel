part of '../orders_view.dart';

class CreateOrderView extends StatelessWidget {
  final OrdersViewModel viewModel;
  const CreateOrderView({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Row(
        children: <Widget>[
          Expanded(flex: 3, child: buildInputsContainer()),
          Expanded(flex: 2, child: buildInformation())
        ],
      ),
    );
  }

  Widget buildInputsContainer() {
    return Container(
      margin: PaddingConsts.instance.all20,
      decoration: BoxDecoration(
        color: ColorConsts.instance.green,
        borderRadius: RadiusConsts.instance.circularAll10,
        boxShadow: ColorConsts.instance.shadow,
      ),
      child: buildInputs(),
    );
  }

  Widget buildInformation() {
    return Column(
      children: <Widget>[
        buildOrdersContainer(),
        Observer(builder: (context) {
          return Text(
            "${viewModel.totalPrice}₺",
            style: TextConsts.instance.regularBlack36Bold,
          );
        }),
        Padding(
          padding: PaddingConsts.instance.top10,
          child: CustomStateFullButton(
              onPressed: () async => await viewModel.createOrder(),
              style: TextConsts.instance.regularBlack20Bold,
              text: "Sipariş Oluştur",
              width: 250,
              height: 70),
        )
      ],
    );
  }

  Widget buildOrdersContainer() {
    return Container(
      padding: PaddingConsts.instance.all10,
      margin: PaddingConsts.instance.all20,
      decoration: BoxDecoration(
          color: ColorConsts.instance.darkGrey,
          borderRadius: RadiusConsts.instance.circularAll10,
          boxShadow: ColorConsts.instance.shadow),
      height: 600,
      child: Observer(builder: (context) {
        return ListView.builder(
          itemCount: viewModel.orderedFoods.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> orderedFood = viewModel.orderedFoods[index];
            return Card(
              child: Padding(
                padding: PaddingConsts.instance.all10,
                child: Text(
                  "${orderedFood['name']} x${orderedFood['count']}",
                  style: TextConsts.instance.regularBlack20Bold,
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget buildInputs() {
    return ListView.builder(
        itemCount: viewModel.menu.length,
        itemBuilder: (context, index) {
          MenuItemModel item = viewModel.menu[index];
          return Padding(
            padding: PaddingConsts.instance.top10,
            child: Padding(
              padding: PaddingConsts.instance.horizontal10,
              child: Card(
                child: Padding(
                  padding: PaddingConsts.instance.all10,
                  child: ListTile(
                    title: Text(
                      item.name!,
                      style: TextConsts.instance.regularBlack20Bold,
                    ),
                    trailing: SizedBox(width: 220, child: buildCounter(index)),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget buildCounter(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        counterButton(false, index),
        Observer(builder: (context) {
          return Text(
            "${viewModel.menuItemCounts[index]}",
            style: TextConsts.instance.regularBlack20Bold,
          );
        }),
        counterButton(true, index),
        IconButton(
          onPressed: () =>
              viewModel.addToOrderList(viewModel.menu[index], index),
          icon: Icon(
            Icons.add_circle,
            size: 40,
            color: ColorConsts.instance.green,
          ),
        )
      ],
    );
  }

  Widget counterButton(bool isIncrement, int index) {
    return ElevatedButton(
      onPressed: () => isIncrement
          ? viewModel.incrementCount(index)
          : viewModel.decrementCount(index),
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorConsts.instance.orange,
          shape: const CircleBorder(),
          padding: PaddingConsts.instance.all5),
      child: Icon(
        isIncrement ? Icons.add : Icons.remove,
        color: ColorConsts.instance.black,
        size: 30,
      ),
    );
  }
}
