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
    return Column();
  }

  Widget buildInputs() {
    return ListView.builder(
        itemCount: viewModel.menu.length,
        itemBuilder: (context, index) {
          MenuItemModel item = viewModel.menu[index];
          return Padding(
            padding: PaddingConsts.instance.top10,
            child: Card(
              child: Padding(
                padding: PaddingConsts.instance.all10,
                child: ListTile(
                  leading: Text(
                    item.name!,
                    style: TextConsts.instance.regularBlack20Bold,
                  ),
                  trailing: SizedBox(width: 200, child: buildCounter(index)),
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
        Text(
          "5",
          style: TextConsts.instance.regularBlack20Bold,
        ),
        counterButton(true, index),
      ],
    );
  }

  Widget counterButton(bool isIncrement, int index) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
          backgroundColor: ColorConsts.instance.orange,
          shape: const CircleBorder(),
          padding: PaddingConsts.instance.all10),
      child: Icon(
        isIncrement ? Icons.add : Icons.remove,
        color: ColorConsts.instance.black,
        size: 30,
      ),
    );
  }
}
