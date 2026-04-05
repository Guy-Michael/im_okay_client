import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Providers/providers.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_alarm_triggered.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_im_ok.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_no_status.dart';

class MyStatus extends ConsumerStatefulWidget {
  void Function() onUpdateStatusClicked;

  MyStatus({super.key, required this.onUpdateStatusClicked});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyStatusState();
}

class MyStatusState extends ConsumerState<MyStatus> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    return Container(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
        child: user.when(
            loading: () => MyStatusNoStatus(
                  onUpdateStatusClicked: widget.onUpdateStatusClicked,
                ),
            error: (object, stackTrace) => null,
            data: (user) {
              if (user!.isOk) {
                return MyStatusImOk();
              } else {
                return MyStatusAlarmTriggered(
                  onUpdateStatusClicked: widget.onUpdateStatusClicked,
                );
              }
            }));
  }
}

class _MyStatusConsts {
  static const String topComponentTitleAlertTriggered = "הופעלה אזעקה?";
  static const String topComponentTitleNoStatus = "ללא סטאטוס";
  static const String topComponentTitleImOkay = "אני בסדר";
  static const String topComponentButtonCaption = "עדכון סטאטוס";
}
