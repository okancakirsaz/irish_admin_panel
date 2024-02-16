part of '../active_events_view.dart';

class EventsElement extends StatelessWidget {
  final ActiveEventsViewModel viewModel;
  final EventModel event;
  const EventsElement(
      {super.key, required this.viewModel, required this.event});

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
          event.eventName!,
          style: TextConsts.instance.regularWhite20Bold,
        ),
        subtitle: Text(
          event.eventTime!,
          style: TextConsts.instance.regularWhite20,
        ),
        trailing: SizedBox(
          width: 230,
          child: Row(
            children: <Widget>[
              CustomStateFullButton(
                onPressed: () async => await viewModel.startEvent(event),
                style: TextConsts.instance.regularBlack18Bold,
                text: "Etkinliği Başlat",
                width: 170,
                height: 40,
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: ColorConsts.instance.red,
                  size: 40,
                ),
                onPressed: () async =>
                    await viewModel.cancelEvent(event.eventId!),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
