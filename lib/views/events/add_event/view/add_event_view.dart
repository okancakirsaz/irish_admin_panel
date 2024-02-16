import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/consts/color_consts/color_consts.dart';
import 'package:irish_admin_panel/core/consts/padding_consts.dart';
import 'package:irish_admin_panel/core/consts/radius_consts.dart';
import 'package:irish_admin_panel/core/consts/text_consts.dart';
import 'package:irish_admin_panel/core/widgets/custom_button.dart';
import 'package:irish_admin_panel/core/widgets/custom_statefull_button.dart';
import 'package:irish_admin_panel/core/widgets/custom_text_field.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';

import '../viewmodel/add_event_viewmodel.dart';
part 'components/add_physical_event.dart';
part 'components/add_virtual_event.dart';
part 'components/date_selector.dart';
part 'components/create_event_button.dart';

class AddEventView extends StatelessWidget {
  final EventModel? event;
  const AddEventView({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    return BaseView<AddEventViewModel>(
        viewModel: AddEventViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            appBar: AppBar(),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: buildEventTypeSwitch(model)),
                  Padding(
                    padding: PaddingConsts.instance.top50,
                    child: buildEventTypeBasedInputs(model),
                  )
                ]),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget buildEventTypeSwitch(AddEventViewModel model) {
    return SizedBox(
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Sanal Etkinlik",
            style: TextConsts.instance.regularBlack18Bold,
          ),
          Observer(builder: (context) {
            return Transform.scale(
              scale: 1.4,
              child: Switch(
                  activeColor: ColorConsts.instance.orange,
                  value: model.isPhysicalEvent,
                  onChanged: (value) =>
                      model.changeIsPhysicalEventState(value)),
            );
          }),
          Text(
            "Fiziksel Etkinlik",
            style: TextConsts.instance.regularBlack18Bold,
          ),
        ],
      ),
    );
  }

  Widget buildEventTypeBasedInputs(AddEventViewModel model) {
    return Observer(builder: (context) {
      if (model.isPhysicalEvent) {
        return Align(
            alignment: Alignment.topRight,
            child: AddPhysicalEvent(viewModel: model));
      } else {
        return AddVirtualEvent(viewModel: model);
      }
    });
  }
}
