import 'package:flutter/material.dart';

class PdfCellWidgetWidget extends StatelessWidget {
  const PdfCellWidgetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.zero,
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Image(
            image: AssetImage("assets/img/pdf.png"),
          ),
        ),
      ),
    );
  }
}
