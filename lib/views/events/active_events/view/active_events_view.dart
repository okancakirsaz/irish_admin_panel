import 'package:flutter/material.dart';
import 'package:irish_admin_panel/core/base/view/base_view.dart';
import 'package:irish_admin_panel/views/events/active_events/viewmodel/active_events_viewmodel.dart';

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
                Expanded(
                  child: ListView.builder(
                      itemCount: 0, itemBuilder: (context, index) {}),
                ),
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
}
