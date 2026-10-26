// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:troond/config/app_const/shared_const.dart';
// import 'package:troond/config/app_local/app_local.dart';
// import 'package:troond/config/theme/app_color.dart';
// import 'package:troond/config/valid/app_validation.dart';
// import 'package:troond/data/shared_pref/shared_pref.dart';
// import 'package:troond/views/brands/model/brand_model.dart';
// import 'package:troond/views/categories/services/categories_services.dart';
// import 'package:troond/views/home/model/category_model.dart';
// import 'package:troond/views/supplier_product/product/add/suggestion_dailgo.dart';
// import 'package:troond/widget/btn/text_btn.dart';
// import 'package:troond/widget/input/build_input.dart';
// import 'package:troond/widget/loading/loading_widget.dart';
// import '../../../product/model/product_preview.dart';
// import '../../controller/supplier_product_controller.dart';
// import '../../services/supplier_product_services.dart';
// import '../widget/build_input_title.dart';
// import '../widget/product_text.dart';

// class ProductGeneralInfo2 extends StatefulWidget {
//   const ProductGeneralInfo2({
//     Key? key,
//     required this.controller,
//     required this.product,
//   }) : super(key: key);
//   final SupplierProductController controller;
//   final ProductPreview product;

//   @override
//   State<ProductGeneralInfo2> createState() => _ProductGeneralInfo2State();
// }

// class _ProductGeneralInfo2State extends State<ProductGeneralInfo2> {
//   @override
//   void initState() {
//     super.initState();
//     widget.controller.name = TextEditingController(text: widget.product.name);
//     widget.controller.description =
//         TextEditingController(text: widget.product.description);
//     widget.controller.material =
//         TextEditingController(text: widget.product.material);
//     widget.controller.basePrice =
//         TextEditingController(text: widget.product.basePrice);
//     widget.controller.price =
//         TextEditingController(text: widget.product.price.toString());
//     widget.controller.unit = TextEditingController(text: widget.product.unit);
//     widget.controller.discount =
//         TextEditingController(text: widget.product.discount);
//     widget.controller.brandModel = widget.product.brand;
//     widget.controller.categoryModel = widget.product.category!.parent;
//     widget.controller.categorychild = widget.product.category;
//     // widget.controller.description =
//     //     TextEditingController(text: widget.product.description);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var local = MyLocalizations.getLocal(context);
//     return Form(
//       key: widget.controller.editKey,
//       child: Column(
//         children: [
//           //* General Info
//           BorderText(
//             text: local.generalInfo,
//             height: 520,
//             child: ListView(
//               children: [
//                 const SizedBox(height: 10),

//                 //* Name
//                 ListTile(
//                   title: Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Text(
//                       local.productName,
//                       style: const TextStyle(
//                         color: AppColor.c3D3D3D,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   subtitle: BuildInput(
//                     controller: widget.controller.name,
//                     hintText: local.enterProductName,
//                     validator: AppValidation.required(),
//                   ),
//                 ),

//                 const SizedBox(height: 5),

//                 //* Category
//                 FutureBuilder<List<CategoryModel>>(
//                   future: CategoriesServices().getParentCategories(),
//                   builder: (context, snapshot) {
//                     var cache = SharedPref.getKey(
//                       key: SharedConsts.parentCategories,
//                     );
//                     if (cache == null) {
//                       return const LoadingWidget();
//                     } else {
//                       var json = jsonDecode(cache);
//                       List<CategoryModel> categoriesList = [];
//                       for (var element in json["data"]) {
//                         categoriesList.add(CategoryModel.fromJson(element));
//                       }
//                       var result =
//                           snapshot.hasData ? snapshot.data! : categoriesList;
//                       List<CategoryModel> data = result
//                           .where((element) => element.children.isNotEmpty)
//                           .toList();

//                       String parent = widget.controller.categoryModel == null
//                           ? widget.product.category!.parent!.name
//                           : widget.controller.categoryModel!.name;

//                       String subCategory =
//                           widget.controller.categorychild == null
//                               ? widget.product.category!.name
//                               : widget.controller.categorychild!.name;
//                       return Row(
//                         children: [
//                           Expanded(
//                             child: ListTile(
//                               title: Padding(
//                                 padding: const EdgeInsets.only(bottom: 5),
//                                 child: Text(
//                                   local.category,
//                                   style: const TextStyle(
//                                     color: AppColor.c3D3D3D,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               subtitle: PopupMenuButton(
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ListTile(
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                         color: AppColor.cDBDBDB,
//                                       ),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     title: Text(
//                                       parent,
//                                       textAlign: TextAlign.right,
//                                     ),
//                                     trailing: const Icon(
//                                       FontAwesomeIcons.chevronDown,
//                                       color: AppColor.c121212,
//                                       size: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 itemBuilder: (context) {
//                                   return [
//                                     for (int i = 0; i < data.length; i++)
//                                       PopupMenuItem(
//                                         onTap: () {
//                                           widget.controller.chooseCategory(
//                                             data[i],
//                                           );
//                                         },
//                                         child: Text(data[i].name),
//                                       ),
//                                     PopupMenuItem(
//                                       child: InkWell(
//                                         onTap: () {
//                                           BuildSuggestion().addNewCategory(
//                                             context: context,
//                                             controller: widget.controller,
//                                           );
//                                         },
//                                         child: Text(local.other),
//                                       ),
//                                     ),
//                                   ];
//                                 },
//                               ),
//                             ),
//                           ),
//                           Expanded(
//                             child: ListTile(
//                               title: Padding(
//                                 padding: const EdgeInsets.only(bottom: 5),
//                                 child: Text(
//                                   local.subCategory,
//                                   style: const TextStyle(
//                                     color: AppColor.c3D3D3D,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               subtitle: PopupMenuButton(
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ListTile(
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                         color: AppColor.cDBDBDB,
//                                       ),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     title: Text(
//                                       subCategory,
//                                       textAlign: TextAlign.right,
//                                     ),
//                                     trailing: const Icon(
//                                       FontAwesomeIcons.chevronDown,
//                                       color: AppColor.c121212,
//                                       size: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 itemBuilder: (context) {
//                                   return widget.controller.categoryModel == null
//                                       ? []
//                                       : [
//                                           for (int i = 0;
//                                               i <
//                                                   widget
//                                                       .controller
//                                                       .categoryModel!
//                                                       .children
//                                                       .length;
//                                               i++)
//                                             PopupMenuItem(
//                                               onTap: () {
//                                                 widget.controller
//                                                     .chooseCategoryChild(
//                                                   widget
//                                                       .controller
//                                                       .categoryModel!
//                                                       .children[i],
//                                                 );
//                                               },
//                                               child: Text(widget
//                                                   .controller
//                                                   .categoryModel!
//                                                   .children[i]
//                                                   .name),
//                                             ),
//                                           PopupMenuItem(
//                                             child: InkWell(
//                                               onTap: () {
//                                                 BuildSuggestion()
//                                                     .addNewSubcategory(
//                                                   context: context,
//                                                   controller: widget.controller,
//                                                 );
//                                               },
//                                               child: Text(local.other),
//                                             ),
//                                           ),
//                                         ];
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       );
//                     }
//                   },
//                 ),

//                 const SizedBox(height: 5),

//                 Row(
//                   children: [
//                     Expanded(
//                       child: FutureBuilder<List<BrandModel>>(
//                         future: SupplierProductServices().getBrands(),
//                         builder: (context, snapshot) {
//                           var cache = SharedPref.getKey(
//                             key: SharedConsts.brands,
//                           );
//                           if (cache == null) {
//                             return const SizedBox();
//                           } else {
//                             var json = jsonDecode(cache);
//                             List<BrandModel> brands = [];
//                             for (var element in json["data"]) {
//                               brands.add(BrandModel.fromJson(element));
//                             }
//                             var data =
//                                 snapshot.hasData ? snapshot.data! : brands;
//                             String brand = widget.controller.brandModel == null
//                                 ? widget.product.brand!.name
//                                 : widget.controller.brandModel!.name;
//                             return ListTile(
//                               title: Padding(
//                                 padding: const EdgeInsets.only(bottom: 5),
//                                 child: Text(
//                                   local.brand,
//                                   style: const TextStyle(
//                                     color: AppColor.c3D3D3D,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ),
//                               subtitle: PopupMenuButton(
//                                 child: SizedBox(
//                                   height: 50,
//                                   child: ListTile(
//                                     shape: RoundedRectangleBorder(
//                                       side: const BorderSide(
//                                           color: AppColor.cDBDBDB),
//                                       borderRadius: BorderRadius.circular(6),
//                                     ),
//                                     title: Text(brand),
//                                     trailing: const Icon(
//                                       FontAwesomeIcons.chevronDown,
//                                       color: AppColor.c121212,
//                                       size: 12,
//                                     ),
//                                   ),
//                                 ),
//                                 itemBuilder: (context) {
//                                   return [
//                                     for (int i = 0; i < data.length; i++)
//                                       PopupMenuItem(
//                                         onTap: () {
//                                           widget.controller.chooseBrand(
//                                             data[i],
//                                           );
//                                         },
//                                         child: Text(data[i].name),
//                                       ),
//                                   ];
//                                 },
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                     ),
//                     Expanded(
//                       child: ListTile(
//                         title: Padding(
//                           padding: const EdgeInsets.only(bottom: 5, top: 10),
//                           child: Text(
//                             local.material,
//                             style: const TextStyle(
//                               color: AppColor.c3D3D3D,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                         subtitle: SizedBox(
//                           height: 60,
//                           child: BuildInput(
//                             controller: widget.controller.material,
//                             validator: AppValidation.required(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 5),
//                 ListTile(
//                   title: Padding(
//                     padding: const EdgeInsets.only(bottom: 5),
//                     child: Text(
//                       local.productDescription,
//                       style: const TextStyle(
//                         color: AppColor.c3D3D3D,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   subtitle: SizedBox(
//                     child: BuildInput(
//                       hintText: local.enterProductDescription,
//                       maxLines: 15,
//                       validator: AppValidation.required(),
//                       controller: widget.controller.description,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),

//           //* Price & Unit
//           BorderText(
//             height: 180,
//             text: local.priceUnit,
//             child: ListView(
//               children: [
//                 const SizedBox(height: 12),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: BuildInputTitle(
//                         controller: widget.controller.basePrice,
//                         title: local.basePrice,
//                       ),
//                     ),
//                     Expanded(
//                       child: BuildInputTitle(
//                         controller: widget.controller.price,
//                         title: local.beforeDiscount,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: BuildInputTitle(
//                         controller: widget.controller.discount,
//                         title: local.afterDiscount,
//                       ),
//                     ),
//                     Expanded(
//                       child: BuildInputTitle(
//                         controller: widget.controller.unit,
//                         title: local.unit,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           //* next
//           widget.controller.loading == 0
//               ? const LoadingWidget()
//               : BuildTextBtn(
//                   color: AppColor.main,
//                   onTap: () {
//                     widget.controller.editProduct(context);
//                   },
//                   text: local.next,
//                 ),
//         ],
//       ),
//     );
//   }
// }
