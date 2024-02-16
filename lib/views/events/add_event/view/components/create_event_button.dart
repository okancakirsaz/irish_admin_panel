part of '../add_event_view.dart';

class CreateEventButton extends StatelessWidget {
  final AddEventViewModel viewModel;
  const CreateEventButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return CustomStateFullButton(
      onPressed: () async => await viewModel.createEvent(),
      style: TextConsts.instance.regularBlack18Bold,
      text: "Etkinlik Oluştur",
      width: 250,
      height: 60,
    );
  }
}
