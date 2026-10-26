import 'package:flutter/material.dart';

class StatusCellWidget extends StatelessWidget {
  const StatusCellWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        margin: EdgeInsets.zero,
        height: 30,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xff1A9946).withOpacity(0.10),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check,
              color: Color(0xff1A9946),
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
