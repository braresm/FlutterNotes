import 'package:flutter/material.dart';

// Widget used to display the calculation result
class ResultWidget extends StatelessWidget {
  const ResultWidget({
    Key? key,
    required this.result,
  }) : super(key: key);

  final String result;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      color: Colors.black,
      child: Container(
        alignment: Alignment.bottomRight,
        padding: const EdgeInsets.only(
          right: 16,
          bottom: 16,
        ),
        child: Text(
          result,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
          ),
        ),
      ),
    );
  }
}
