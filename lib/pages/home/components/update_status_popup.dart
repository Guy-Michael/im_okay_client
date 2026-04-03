import 'package:flutter/material.dart';

class UpdateStatusPopup extends StatefulWidget {
  const UpdateStatusPopup({super.key});

  @override
  State<StatefulWidget> createState() => UpdateStatusPopupState();
}

class UpdateStatusPopupState extends State<UpdateStatusPopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 393,
      height: 772,
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
          Positioned(
            left: 344,
            top: 32,
            child: Container(width: 17, height: 17, child: Stack()),
          ),
          Positioned(
            left: 17,
            top: 87,
            child: SizedBox(
              width: 360,
              child: Text(
                'אם הייתה אזעקה באזורך,\nרוצה לעדכן שהכל בסדר?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            left: 30,
            top: 178,
            child: Container(
              width: 336,
              height: 336,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 336,
                      height: 336,
                      decoration: ShapeDecoration(
                        color: const Color(0xFF006A71),
                        shape: OvalBorder(
                          side: BorderSide(
                            width: 1.02,
                            color: Colors.white.withValues(alpha: 0.25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60.72,
                    top: 60.72,
                    child: Container(
                      width: 214.55,
                      height: 214.55,
                      padding: const EdgeInsets.symmetric(horizontal: 55.93, vertical: 59.99),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(107.28),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 19.53,
                            offset: Offset(0, 12.14),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10.17,
                        children: [
                          SizedBox(
                            width: 86.43,
                            child: Text(
                              'אני בסדר',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 60.72,
                    top: 60.72,
                    child: Container(
                      width: 214.55,
                      height: 214.55,
                      padding: const EdgeInsets.symmetric(horizontal: 55.93, vertical: 59.99),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(107.28),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 19.53,
                            offset: Offset(0, 12.14),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 10.17,
                        children: [
                          SizedBox(
                            width: 86.43,
                            child: Text(
                              'אני בסדר',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 28.34,
                    top: 28.34,
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
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 116,
            top: 574,
            child: SizedBox(
              width: 161,
              height: 32,
              child: Text(
                'אין אצלי אזעקה',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
                  height: 1.09,
                ),
              ),
            ),
          ),
          Positioned(
            left: 78,
            top: 666,
            child: SizedBox(
              width: 237,
              child: Text(
                'יצירת קשר עם מוקד חירום',
                textAlign: TextAlign.right,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  height: 1.40,
                ),
              ),
            ),
          ),
          Positioned(
            left: 62,
            top: 664,
            child: Container(
              width: 269,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                  borderRadius: BorderRadius.circular(119),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: 16,
                children: [],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
