import 'package:flutter/material.dart';
import 'package:troond/widget/images/svg_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class DoneStep extends StatelessWidget {
  const DoneStep({super.key});

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);

    return Scaffold(
      appBar: AppBar(title: Text(local.beSupplier)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SvgWidget(svgName: "done.svg"),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: Text(
                  local.thankYouVeryMuch,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColor.c3D3D3D,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
