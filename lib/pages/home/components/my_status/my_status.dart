import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:im_okay/Services/API%20Services/User%20Authentication%20Service/user_authentication_api_service.dart';
import 'package:im_okay/Utils/stream_utils.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_alarm_triggered.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_im_ok.dart';
import 'package:im_okay/pages/home/components/my_status/my_status_no_status.dart';

final userProvider = StreamProvider((_) {
  return StreamUtils.initStream(
      func: UserAuthenticationApiService.fetchUser, duration: Duration(seconds: 10));
});

class MyStatus extends ConsumerStatefulWidget {
  const MyStatus({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => MyStatusState();
}

class MyStatusState extends ConsumerState<MyStatus> {
  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(userProvider);
    return Container(
        padding: const EdgeInsets.only(top: 50, bottom: 20),
        decoration: BoxDecoration(color: const Color.fromARGB(255, 244, 244, 244)),
        child: provider.when(
            loading: () => MyStatusNoStatus(),
            error: (object, stackTrace) => Text("$object"),
            data: (user) {
              if (user!.isOk) {
                return MyStatusImOk();
              } else {
                return MyStatusAlarmTriggered();
              }
            }));
  }

  Icon buttonIcon = Icon(
    Icons.edit_square,
    size: 25,
    color: Color.fromARGB(255, 128, 0, 0),
  );

  TextStyle headerTextStyle = TextStyle(
    color: Colors.black,
    fontSize: 24,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w700,
  );

  ButtonStyle topComponentButtonStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 236, 212, 212)),
  );

  TextStyle buttonTextStyle = TextStyle(
    color: Color.fromARGB(255, 128, 0, 0),
    fontSize: 19,
    fontFamily: 'Inter',
    fontWeight: FontWeight.w600,
  );
}

class _MyStatusConsts {
  static const String topComponentTitleAlertTriggered = "הופעלה אזעקה?";
  static const String topComponentTitleNoStatus = "ללא סטאטוס";
  static const String topComponentTitleImOkay = "אני בסדר";
  static const String topComponentButtonCaption = "עדכון סטאטוס";
}
