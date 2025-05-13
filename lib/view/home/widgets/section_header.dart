import 'package:enduro/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing});

  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 8),
      child:
          trailing != null
              ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(fontSize: 20, color: AppColors.white),
                  ),
                  trailing!,
                ],
              )
              : Text(
                title,
                style: TextStyle(fontSize: 20, color: AppColors.white),
              ),
    );
  }
}
