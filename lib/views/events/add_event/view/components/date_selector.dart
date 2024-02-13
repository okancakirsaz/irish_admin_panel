part of '../add_event_view.dart';

class DateSelector extends StatelessWidget {
  final AddEventViewModel viewModel;
  const DateSelector({super.key, required this.viewModel});

  //TODO:Contuniue here
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: PaddingConsts.instance.all20,
          decoration: BoxDecoration(
              color: ColorConsts.instance.lightGray,
              boxShadow: ColorConsts.instance.shadow,
              borderRadius: RadiusConsts.instance.circularAll10),
          width: 500,
          child: CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: viewModel.datePickerLastDate,
              onDateChanged: (date) => viewModel.selectDate(date)),
        ),
        CustomButton(
          onPressed: () => viewModel.showTimeSelector(),
          style: TextConsts.instance.regularBlack18Bold,
          text: "Etkinlik Saati Seç",
          width: 250,
          height: 60,
        )
      ],
    );
  }
}
