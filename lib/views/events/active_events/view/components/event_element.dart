part of '../active_events_view.dart';

class EventsElement extends StatelessWidget {
  final ActiveEventsViewModel viewModel;
  final String name;
  final String time;
  final String id;
  const EventsElement(
      {super.key,
      required this.name,
      required this.time,
      required this.id,
      required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: PaddingConsts.instance.all10,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
          borderRadius: RadiusConsts.instance.circularAll10,
          color: ColorConsts.instance.orange,
          boxShadow: ColorConsts.instance.shadow),
      child: ListTile(
        title: Text(
          name,
          style: TextConsts.instance.regularWhite20Bold,
        ),
        subtitle: Text(
          time,
          style: TextConsts.instance.regularWhite20,
        ),
        trailing: IconButton(
          icon: Icon(
            Icons.delete,
            color: ColorConsts.instance.red,
            size: 40,
          ),
          onPressed: () async => await viewModel.cancelEvent(id),
        ),
      ),
    );
  }
}
