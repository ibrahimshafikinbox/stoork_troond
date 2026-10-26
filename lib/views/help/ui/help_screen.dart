import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:troond/config/date/app_date.dart';
import 'package:troond/views/help/services/help_services.dart';
import 'package:troond/widget/images/svg_widget.dart';
import 'package:troond/widget/input/build_input.dart';
import 'package:troond/widget/loading/loading_widget.dart';
import '../../../config/app_local/app_local.dart';
import '../../../config/theme/app_color.dart';
import '../../../data/shared_pref/shared_pref.dart';
import '../model/chat_model.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  int chatId = 0;

  Future createChat() async {
    await HelpServices().createChat().then((value) {
      setState(() {
        chatId = value["id"];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    createChat();
  }

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.c000000,
        leading: const BackButton(color: AppColor.white),
        title: Text(
          local.supportTeam,
          style: const TextStyle(color: AppColor.white),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<ChatModel>>(
              future: HelpServices().getChat(chatId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const LoadingWidget();
                } else {
                  var result = snapshot.data!.reversed.toList();
                  return ListView.builder(
                    itemCount: result.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      var item = result[index];
                      bool isSend = SharedPref.getUserId() == item.user.id;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            !isSend
                                ? const SizedBox()
                                : CircleAvatar(
                                    backgroundImage: CachedNetworkImageProvider(
                                      item.user.image ?? "",
                                    ),
                                  ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: !isSend
                                    ? CrossAxisAlignment.end
                                    : CrossAxisAlignment.start,
                                children: [
                                  Card(
                                    color: !isSend
                                        ? const Color(0xffFFF0D5)
                                        : AppColor.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 270,
                                        child: item.file != null
                                            ? Card(
                                                color: !isSend
                                                    ? const Color(0xffFFF0D5)
                                                    : AppColor.white,
                                                child: Column(
                                                  crossAxisAlignment: !isSend
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    ListTile(
                                                      title: Text(
                                                        item.file!.name,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                      trailing: IconButton(
                                                        onPressed: () {},
                                                        icon: const Icon(
                                                          BootstrapIcons
                                                              .download,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                item.content,
                                                style: const TextStyle(
                                                  color: AppColor.c000000,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 16,
                                                  height: 1.5,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    AppDate.format(item.dateTime),
                                    style: const TextStyle(
                                      color: AppColor.c717171,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          //* actions
          Material(
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: BuildInput(
                        controller: message,
                        hintText: local.askMeAnything,
                        suffixIcon: IconButton(
                          onPressed: () async {
                            // callUsController.sendFile(chatId: chatId);
                          },
                          icon: const Icon(
                            Icons.attach_file,
                            color: AppColor.c717171,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: FloatingActionButton(
                        backgroundColor: AppColor.main,
                        elevation: 0,
                        child: const SvgWidget(svgName: "send.svg"),
                        onPressed: () async {
                          await HelpServices().sendText(
                            content: message.text,
                            chatId: chatId,
                          );
                          message.clear();
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
