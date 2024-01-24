import 'package:flutter/material.dart';

// Widget used to create the calculator keyboard buttons
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.label,
    required this.onTap,
    required this.width,
    required this.height,
    this.backgroundColor = Colors.white,
    this.labelColor = Colors.black,
  }) : super(key: key);

  final String label;
  final VoidCallback onTap;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: Ink(
        width: width,
        height: height,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1, 1),
              blurRadius: 2,
            ),
          ],
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: backgroundColor,
        ),
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 24,
                color: labelColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
