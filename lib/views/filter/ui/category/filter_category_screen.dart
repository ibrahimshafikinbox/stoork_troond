import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/views/filter/controller/filter_controller.dart';
import 'package:troond/views/filter/model/filter_model.dart';
import 'package:troond/widget/input/build_input.dart';
import '../../../../config/app_local/app_local.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../widget/btn/text_btn.dart';
import '../../../home/model/category_model.dart';

class FilterCategoryScreen extends StatelessWidget {
  const FilterCategoryScreen({super.key, required this.filterModel});
  final FilterModel filterModel;

  @override
  Widget build(BuildContext context) {
    var filterController = Provider.of<FilterController>(context);
    var local = MyLocalizations.getLocal(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(local.category),
        actions: [
          TextButton(
            onPressed: () {
              //*
            },
            child: Text(
              local.reset,
              style: const TextStyle(color: AppColor.c223263),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          //* search
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: BuildInput(
              hintText: local.search,
              iconButton: const Icon(
                BootstrapIcons.search,
                color: AppColor.main,
                size: 20,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: filterModel.categories.length,
              itemBuilder: (context, index) {
                var item = filterModel.categories[index];
                return CategoryFilterWidget(item: item);
              },
            ),
          ),
          SafeArea(
            child: BuildTextBtn(
              onTap: () {
                filterController.filter(
                  context: context,
                  filterModel: filterModel,
                );
              },
              color: AppColor.main,
              text: local.apply,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryFilterWidget extends StatefulWidget {
  const CategoryFilterWidget({
    super.key,
    required this.item,
  });
  final CategoryModel item;

  @override
  State<CategoryFilterWidget> createState() => _CategoryFilterWidgetState();
}

class _CategoryFilterWidgetState extends State<CategoryFilterWidget> {
  bool showSub = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //* header
        Row(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  showSub = !showSub;
                });
              },
              child: Card(
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: AppColor.cDBDBDB),
                ),
                child: Icon(
                  showSub ? Icons.remove : Icons.add,
                  color: AppColor.c7E859B,
                ),
              ),
            ),
            Expanded(
              child: Text(
                widget.item.name,
                maxLines: 1,
                style: const TextStyle(color: AppColor.c121212),
              ),
            ),
            Checkbox(
              value: widget.item.isFilter,
              checkColor: AppColor.main,
              activeColor: AppColor.main,
              focusColor: AppColor.main,
              onChanged: (value) {
                setState(() {
                  widget.item.isFilter = value!;
                  for (var element in widget.item.children) {
                    element.isFilter = value;
                  }
                });
              },
            ),
          ],
        ),

        //* children
        showSub
            ? Padding(
                padding: const EdgeInsets.only(left: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.item.children.length,
                  itemBuilder: (context, index) {
                    var child = widget.item.children[index];
                    return ListTile(
                      trailing: Checkbox(
                        value: child.isFilter,
                        checkColor: AppColor.main,
                        activeColor: AppColor.main,
                        focusColor: AppColor.main,
                        onChanged: (value) {
                          setState(() {
                            child.isFilter = value!;
                          });
                        },
                      ),
                      title: Text(
                        child.name,
                        maxLines: 1,
                        style: const TextStyle(color: AppColor.c121212),
                      ),
                    );
                  },
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
