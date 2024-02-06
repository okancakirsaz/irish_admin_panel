part of '../orders_view.dart';

class CreateOrderView extends StatelessWidget {
  const CreateOrderView({super.key});

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
    return ListView.builder(itemCount: 1, itemBuilder: (context, index) {});
  }
}
