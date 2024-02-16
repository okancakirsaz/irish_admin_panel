import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/core/widgets/custom_statefull_button.dart';
import 'package:irish_admin_panel/views/events/active_events/viewmodel/active_events_viewmodel.dart';
import 'package:irish_admin_panel/views/events/models/event_model.dart';

import '../../../../core/consts/color_consts/color_consts.dart';
import '../../../../core/consts/padding_consts.dart';
import '../../../../core/consts/radius_consts.dart';
import '../../../../core/consts/text_consts.dart';
import '../../../../core/widgets/custom_button.dart';

part 'components/event_element.dart';

class ActiveEventsView extends StatelessWidget {
  const ActiveEventsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<ActiveEventsViewModel>(
        viewModel: ActiveEventsViewModel(),
        onPageBuilder: (context, model) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Padding(
                  padding: PaddingConsts.instance.all20,
                  child: CustomButton(
                      onPressed: () => model.navigateToAddEventPage(),
                      style: TextConsts.instance.regularBlack25Bold,
                      text: "Etkinlik Oluştur",
                      width: double.infinity,
                      height: 70),
                ),
                buildActiveEvents(model)
              ],
            ),
          );
        },
        onModelReady: (model) {
          model.init();
          model.setContext(context);
        },
        onDispose: (model) {});
  }

  Widget buildActiveEvents(ActiveEventsViewModel model) {
    return Observer(builder: (context) {
      if (model.isPageLoaded && model.events.isEmpty) {
        return Center(
            child: Text(
          "Aktif etkinlik bulunmamakta",
          style: TextConsts.instance.regularBlack25Bold,
        ));
      } else if (model.isPageLoaded && model.events.isNotEmpty) {
        return buildEventsList(model);
      } else {
        return Center(
          child: CircularProgressIndicator(
            color: ColorConsts.instance.orange,
          ),
        );
      }
    });
  }

  Widget buildEventsList(ActiveEventsViewModel model) {
    return Expanded(
      child: RefreshIndicator(
        color: ColorConsts.instance.orange,
        onRefresh: () async => model.getActiveEvents(),
        child: ListView.builder(
            itemCount: model.events.length,
            itemBuilder: (context, index) {
              EventModel event = model.events[index];
              return EventsElement(viewModel: model, event: event);
            }),
      ),
    );
  }
}
