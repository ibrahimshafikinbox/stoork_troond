import 'package:flutter/material.dart';
import 'package:troond/config/theme/app_color.dart';
import 'package:troond/data/shared_pref/shared_pref.dart';

class GuaranteeWidget extends StatelessWidget {
  const GuaranteeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    bool isEnglish = SharedPref.getLanguage() == 'en';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        children: [
          // 1. Free Returns
          _buildItem(
            iconBg: const Color(0xFFFFF7ED),
            iconColor: const Color(0xFFF97316),
            icon: Icons.replay_rounded,
            title: isEnglish ? "Free Returns" : "إرجاع مجاني",
            subtitle: isEnglish
                ? "Get Free Returns On Eligible Items"
                : "احصل على إرجاع مجاني للمنتجات المؤهلة",
          ),
          const Divider(height: 24, color: Color(0xFFF3F4F6)),

          // 2. Secure Shopping
          _buildItem(
            iconBg: const Color(0xFFECFDF5),
            iconColor: const Color(0xFF10B981),
            icon: Icons.shield_outlined,
            title: isEnglish ? "Secure Shopping" : "تسوق آمن",
            subtitle: isEnglish
                ? "End-to-end protection for international contracts, payments, and trade shipments"
                : "حماية شاملة للعقود الدولية والمدفوعات والشحنات التجارية",
          ),
          const Divider(height: 24, color: Color(0xFFF3F4F6)),

          // 3. Quality & Compliance Guarantee
          _buildItem(
            iconBg: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF3B82F6),
            icon: Icons.verified_outlined,
            title: isEnglish
                ? "Quality & Compliance Guarantee"
                : "ضمان الجودة والامتثال",
            subtitle: isEnglish
                ? "Verified suppliers and international standard compliance"
                : "موردون معتمدون وامتثال للمعايير الدولية",
          ),
        ],
      ),
    );
  }

  Widget _buildItem({
    required Color iconBg,
    required Color iconColor,
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: iconBg,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: AppColor.c121212,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.5,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12.5,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
