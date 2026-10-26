import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/chat/controller/chat_controller.dart';
import 'package:troond/views/chat/helper/chat_arguments_parser.dart';
import 'package:troond/views/chat/model/chat_product_context.dart';
import 'package:troond/views/chat/model/chat_seller_info.dart';
import 'package:troond/views/chat/ui/widgets/chat_app_bar.dart';
import 'package:troond/views/chat/ui/widgets/chat_date_divider.dart';
import 'package:troond/views/chat/ui/widgets/chat_empty_state.dart';
import 'package:troond/views/chat/ui/widgets/chat_input_bar.dart';
import 'package:troond/views/chat/ui/widgets/chat_message_bubble.dart';
import 'package:troond/views/chat/ui/widgets/chat_product_card.dart';

class ChatScreen extends StatelessWidget {
  final ChatSellerInfo? seller;
  final ChatProductContext? product;

  const ChatScreen({
    super.key,
    this.seller,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatController>(
      create: (_) => ChatController(),
      child: _ChatScreenView(
        initialSeller: seller,
        initialProduct: product,
      ),
    );
  }
}

class _ChatScreenView extends StatefulWidget {
  final ChatSellerInfo? initialSeller;
  final ChatProductContext? initialProduct;

  const _ChatScreenView({
    this.initialSeller,
    this.initialProduct,
  });

  @override
  State<_ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<_ChatScreenView> {
  final ScrollController _scrollController = ScrollController();
  bool _showTopProductBanner = true;
  bool _isInit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInit) {
      _isInit = true;
      final routeData = ChatArgumentsParser.parse(
        context,
        defaultSeller: widget.initialSeller,
        defaultProduct: widget.initialProduct,
      );
      final controller = Provider.of<ChatController>(context, listen: false);
      controller.init(
        sellerInfo: routeData.seller,
        productContext: routeData.product,
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatController>(
      builder: (context, controller, child) {
        _scrollToBottom();

        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFB),
          appBar: ChatAppBar(seller: controller.seller),
          body: Column(
            children: [
              if (controller.product != null && _showTopProductBanner)
                ChatProductCard(
                  product: controller.product!,
                  onClose: () => setState(() => _showTopProductBanner = false),
                ),
              Expanded(
                child: controller.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: AppColor.main),
                      )
                    : controller.messages.isEmpty
                        ? const ChatEmptyState()
                        : _buildMessagesList(controller),
              ),
              ChatInputBar(controller: controller),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessagesList(ChatController controller) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        final message = controller.messages[index];
        final showDivider = index == 0 ||
            ChatDateDivider.shouldShow(
              message.createdAt,
              controller.messages[index - 1].createdAt,
            );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (showDivider) ChatDateDivider(date: message.createdAt),
            ChatMessageBubble(
              message: message,
              isPlayingVoice: controller.playingMessageId == message.id && controller.isPlaying,
              playbackProgress: controller.playingMessageId == message.id ? controller.playbackProgress : 0.0,
              onToggleVoice: () => controller.togglePlayVoice(message),
            ),
          ],
        );
      },
    );
  }
}
