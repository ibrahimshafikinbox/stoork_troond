import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/views/main_screen/controller/main_controller.dart';
import 'package:troond/widget/btn/text_btn.dart';
import '../../config/app_local/app_local.dart';

class Language {
  final String name;
  final String nativeName;
  final String code;
  final String flag;

  Language({
    required this.name,
    required this.nativeName,
    required this.code,
    required this.flag,
  });
}

List<Language> languages = [
  Language(
    name: 'Arabic',
    nativeName: 'العربية',
    code: 'ar',
    flag: '🇸🇦',
  ),
  Language(
    name: 'English',
    nativeName: 'English',
    code: 'en',
    flag: '🇬🇧',
  ),
];

class ChooseLangagueDailgo extends StatefulWidget {
  const ChooseLangagueDailgo({super.key});

  @override
  State<ChooseLangagueDailgo> createState() => _ChooseLangagueDailgoState();
}

class _ChooseLangagueDailgoState extends State<ChooseLangagueDailgo> {
  @override
  Widget build(BuildContext context) {
    var local = MyLocalizations.getLocal(context);
    var mainController = Provider.of<MainController>(context);
    String selectedCode = mainController.language.code;

    return Container(
      padding: const EdgeInsets.only(top: 12, bottom: 24, left: 20, right: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Drag handle
          Container(
            width: 38,
            height: 4,
            decoration: BoxDecoration(
              color: AppColor.cDADCE3,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            local.selectLanguage,
            style: const TextStyle(
              color: AppColor.c1E1E1E,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          ...languages.map((lang) {
            final isSelected = selectedCode == lang.code;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InkWell(
                onTap: () {
                  mainController.chnageLangage(lang);
                  setState(() {});
                },
                borderRadius: BorderRadius.circular(14),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColor.main.withOpacity(0.06) : AppColor.cF6F6F6,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: isSelected ? AppColor.main : Colors.transparent,
                      width: 1.5,
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        lang.flag,
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lang.nativeName,
                              style: TextStyle(
                                color: isSelected ? AppColor.main : AppColor.c1E1E1E,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              lang.name,
                              style: const TextStyle(
                                color: AppColor.c717171,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected ? AppColor.main : Colors.transparent,
                          border: Border.all(
                            color: isSelected ? AppColor.main : AppColor.cB8B8B8,
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? const Icon(
                                Icons.check,
                                size: 14,
                                color: Colors.white,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          const SizedBox(height: 16),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: BuildTextBtn(
                color: AppColor.main,
                onTap: () {
                  Navigator.pop(context);
                },
                text: local.confirm,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

