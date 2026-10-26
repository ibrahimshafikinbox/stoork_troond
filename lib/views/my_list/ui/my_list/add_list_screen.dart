import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/config/valid/app_validation.dart';
import 'package:troond/views/my_list/controller/my_list_controller.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import 'package:troond/widget/text/build_header.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../../../config/app_local/app_local.dart';

class AddListScreen extends StatelessWidget {
  const AddListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyListController myListController = Provider.of<MyListController>(context);
    bool isTyping = myListController.listName.text.isNotEmpty;
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: myListController.listKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 30),
              BuildHeader(
                text: local.createNewList,
                fontSize: 24,
              ),

              const SizedBox(height: 20),

              //* input
              ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    local.listName,
                    style: const TextStyle(
                      color: AppColor.c3D3D3D,
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ),
                subtitle: BuildInput(
                  controller: myListController.listName,
                  validator: AppValidation.required(),
                  hintText: local.enterYourListName,
                  onChange: (value) {
                    myListController.onChange();
                  },
                ),
              ),

              const SizedBox(height: 50),

              myListController.listLoading == 0
                  ? const LoadingWidget()
                  : BuildTextBtn(
                      color: isTyping ? AppColor.main : AppColor.cDADCE3,
                      onTap: () {
                        isTyping
                            ? myListController.addList(context: context)
                            : null;
                      },
                      text: local.create,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
