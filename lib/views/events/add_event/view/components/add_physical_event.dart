part of '../add_event_view.dart';

class AddPhysicalEvent extends StatelessWidget {
  final AddEventViewModel viewModel;
  const AddPhysicalEvent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      height: 750,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularLeft100,
        color: ColorConsts.instance.orange,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.all20,
            child: buildTextInput(),
          ),
          Padding(
            padding: PaddingConsts.instance.all20,
            child: DateSelector(viewModel: viewModel),
          ),
          CreateEventButton(viewModel: viewModel)
        ],
      ),
    );
  }

  Widget buildTextInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: PaddingConsts.instance.top40Left10,
          child: Text(
            "Etkinlik Adı",
            style: TextConsts.instance.regularBlack20Bold,
          ),
        ),
        Container(
          width: 300,
          margin: PaddingConsts.instance.all5,
          child: CustomTextField(
            controller: viewModel.eventName,
            height: 50,
            style: TextConsts.instance.regularBlack18,
          ),
        ),
      ],
    );
  }
}
