part of '../add_event_view.dart';

class AddVirtualEvent extends StatelessWidget {
  final AddEventViewModel viewModel;
  const AddVirtualEvent({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 900,
      height: 700,
      decoration: BoxDecoration(
        borderRadius: RadiusConsts.instance.circularRight100,
        color: ColorConsts.instance.darkGrey,
      ),
      child: Column(
        children: <Widget>[
          Padding(
            padding: PaddingConsts.instance.all20,
            child: buildEventPicker(),
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

  Widget buildEventPicker() {
    return Container(
      color: ColorConsts.instance.lightGray,
      child: DropdownMenu(
          hintText: "Etkinlik Seçiniz",
          controller: viewModel.eventName,
          dropdownMenuEntries: const <DropdownMenuEntry>[
            DropdownMenuEntry(value: "quiz", label: "Bilgi Yarışması")
          ]),
    );
  }
}
