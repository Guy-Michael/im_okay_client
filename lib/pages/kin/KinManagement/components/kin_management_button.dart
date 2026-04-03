import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:im_okay/Styles/text_styles.dart';

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
    return ElevatedButton(
      onPressed: () => context.pushNamed(widget.destination),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: const Color(0xFFE9E9E9),
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
                Icon(
                  widget.icon,
                  color: Colors.teal,
                  size: 24,
                ),
                Text(
                  widget.label,
                  textAlign: TextAlign.start,
                  style: TextStyles.subHeader,
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
  }
}
