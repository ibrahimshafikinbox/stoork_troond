import 'package:flutter/material.dart';
import 'package:troond/views/home/model/category_model.dart';
import 'package:troond/views/home/model/home_group_model.dart';
import 'package:troond/views/home/model/home_model.dart';
import 'package:troond/views/home/services/home_services.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/widget/category/category_group_widget.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';

class RandomCaregoryWidget extends StatefulWidget {
  const RandomCaregoryWidget({
    super.key,
    required this.homeModel,
    required this.mainController,
    this.scrollController,
  });

  final HomeModel homeModel;
  final MainController mainController;
  final ScrollController? scrollController;

  @override
  State<RandomCaregoryWidget> createState() => _RandomCaregoryWidgetState();
}

class _RandomCaregoryWidgetState extends State<RandomCaregoryWidget> {
  final List<HomeGroupModel> _homeGroups = [];
  ScrollController? _activeScrollController;

  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasMore = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _fetchInitialHomeGroups();
    if (widget.scrollController != null) {
      _activeScrollController = widget.scrollController;
      _activeScrollController!.addListener(_onScroll);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.scrollController == null) {
      try {
        final controller = PrimaryScrollController.of(context);
        if (_activeScrollController != controller) {
          _activeScrollController?.removeListener(_onScroll);
          _activeScrollController = controller;
          _activeScrollController?.addListener(_onScroll);
        }
      } catch (_) {}
    }
  }

  @override
  void didUpdateWidget(covariant RandomCaregoryWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.scrollController != oldWidget.scrollController) {
      oldWidget.scrollController?.removeListener(_onScroll);
      _activeScrollController = widget.scrollController;
      _activeScrollController?.addListener(_onScroll);
    }
  }

  @override
  void dispose() {
    _activeScrollController?.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (_activeScrollController == null || !_activeScrollController!.hasClients) return;
    final position = _activeScrollController!.position;
    if (position.maxScrollExtent > 0 && position.pixels >= position.maxScrollExtent - 350) {
      if (!_isLoading && !_isLoadingMore && _hasMore) {
        _fetchMoreHomeGroups();
      }
    }
  }

  Future<void> _fetchInitialHomeGroups() async {
    setState(() {
      _isLoading = true;
    });

    try {
      PaginatedHomeGroupResult res = await HomeServices().getHomeGroups(
        page: 1,
        perPage: 10,
      );
      if (mounted) {
        setState(() {
          _homeGroups.clear();
          _homeGroups.addAll(res.items);
          _currentPage = res.currentPage;
          _hasMore = res.hasMore;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchMoreHomeGroups() async {
    if (_isLoadingMore || !_hasMore) return;
    setState(() {
      _isLoadingMore = true;
    });

    int nextPage = _currentPage + 1;
    try {
      PaginatedHomeGroupResult res = await HomeServices().getHomeGroups(
        page: nextPage,
        perPage: 10,
      );
      if (mounted) {
        setState(() {
          if (res.items.isNotEmpty) {
            final existingIds = _homeGroups.map((e) => e.id).toSet();
            for (var item in res.items) {
              if (!existingIds.contains(item.id)) {
                _homeGroups.add(item);
              }
            }
            _currentPage = res.currentPage;
          }
          _hasMore = res.hasMore && res.items.isNotEmpty;
          _isLoadingMore = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingMore = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    List<CategoryModel> fallbackCategories = widget.homeModel.randomCategory;

    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!_isLoading && !_isLoadingMore && _hasMore) {
          if (scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent - 350) {
            _fetchMoreHomeGroups();
          }
        }
        return false;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              local.showOtherCategory,
              style: const TextStyle(
                color: AppColor.c121212,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 16),

            if (_isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.main,
                    strokeWidth: 2.5,
                  ),
                ),
              )
            else if (_homeGroups.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _homeGroups.length,
                itemBuilder: (context, index) {
                  var groupItem = _homeGroups[index];
                  return HomeGroupCardWidget(groupModel: groupItem);
                },
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: fallbackCategories.length,
                itemBuilder: (context, index) {
                  var item = fallbackCategories[index];
                  return CategoryGroupWidget(categoryModel: item);
                },
              ),

            if (_isLoadingMore)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.main,
                    strokeWidth: 2.5,
                  ),
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
    );
  }
}
