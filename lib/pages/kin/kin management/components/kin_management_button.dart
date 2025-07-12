import 'package:flutter/material.dart';

class KinManagementButton extends StatefulWidget {
  final String destination;
  final String label;
  final IconData icon;
  const KinManagementButton(
      {super.key, required this.destination, required this.label, required this.icon});

  @override
  State<StatefulWidget> createState() => _KinManagementButtonState();
}

class _KinManagementButtonState extends State<KinManagementButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 361,
      // height: 56,
      padding: const EdgeInsets.all(16),
      decoration: ShapeDecoration(
        color: Color.fromARGB(28, 27, 31, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        spacing: 140,
        children: [
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              spacing: 8,
              children: [
                Icon(widget.icon),
                Text(
                  widget.label,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Expanded(
                  child: Container(),
                ),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
    );
    // return ElevatedButton(
    //   onPressed: () => globalRouter.pushNamed(widget.destination),
    //   child: Text(widget.label),
    // );
  }
}
