import 'package:flutter/material.dart';

class UpdateStatusPopup extends StatefulWidget {
  void Function() onDismiss;
  Future Function() onReportOkClicked;

  UpdateStatusPopup({super.key, required this.onDismiss, required this.onReportOkClicked});
  @override
  State<StatefulWidget> createState() => _UpdateStatusPopupState();
}

class _UpdateStatusPopupState extends State<UpdateStatusPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 822,
      decoration: ShapeDecoration(
        color: const Color(0xFF006A71),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        shadows: [
          BoxShadow(
            color: Color(0xFFE7E7E7),
            blurRadius: 12,
            offset: Offset(0, -10),
            spreadRadius: 0,
          )
        ],
      ),
      child: Stack(
        children: [
          dismissButton(),
          topCaption(),
          imOkayButton(),
          noAlarmCaption(),
          contactEmergencyServices(),
        ],
      ),
    );
  }

  Align contactEmergencyServices() {
    return Align(
      alignment: Alignment(0, 0.7),
      child: SizedBox(
          width: 270,
          child: Container(
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                  borderRadius: BorderRadius.circular(119),
                ),
              ),
              child: Text('יצירת קשר עם מוקד חירום',
                  textAlign: TextAlign.center, style: getTextStyle(20)))),
    );
  }

  Positioned noAlarmCaption() {
    return Positioned(
      left: 116,
      top: 574,
      child: SizedBox(
        width: 161,
        height: 32,
        child: Text(
          'אין אצלי אזעקה',
          textAlign: TextAlign.center,
          style: getTextStyle(14),
        ),
      ),
    );
  }

  Align dismissButton() {
    return Align(
      alignment: Alignment(0.99, -0.95),
      child: ElevatedButton(
        style: ButtonStyle(
            iconColor: WidgetStatePropertyAll(Colors.black),
            iconSize: WidgetStatePropertyAll(40),
            shadowColor: WidgetStatePropertyAll(Colors.transparent),
            backgroundColor: WidgetStatePropertyAll(Colors.transparent)),
        onPressed: widget.onDismiss,
        child: Icon(Icons.close),
      ),
    );
  }

  Align topCaption() {
    return Align(
      alignment: Alignment(0, -0.75),
      child: Text(
        'אם הייתה אזעקה באזורך,\nרוצה לעדכן שהכל בסדר?',
        textAlign: TextAlign.center,
        style: getTextStyle(20),
      ),
    );
  }

  Widget imOkayButton() {
    return Positioned(
      left: 30,
      top: 178,
      child: SizedBox(
        width: 336,
        height: 336,
        child: Stack(
          children: [
            outerRing(),
            innerRing(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await widget.onReportOkClicked();
                  widget.onDismiss();
                },
                style: ButtonStyle(
                    elevation: WidgetStatePropertyAll(20),
                    fixedSize: WidgetStatePropertyAll(Size(200, 200)),
                    shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(255),
                    ))),
                child: Text(
                  "אני בסדר",
                  style: getTextStyle(30, color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container outerRing() {
    return Container(
      decoration: ShapeDecoration(
        shape: OvalBorder(
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.25),
          ),
        ),
      ),
    );
  }

  Center innerRing() {
    return Center(
        child: Container(
      width: 279.33,
      height: 279.33,
      decoration: ShapeDecoration(
        color: const Color(0x00D9D9D9),
        shape: OvalBorder(
          side: BorderSide(
            width: 1.02,
            color: Colors.white.withValues(alpha: 0.50),
          ),
        ),
      ),
    ));
  }

  TextStyle getTextStyle(double fontSize, {Color? color = Colors.white}) =>
      TextStyle(color: color, fontSize: fontSize, fontFamily: 'Inter', fontWeight: FontWeight.w700);
}
