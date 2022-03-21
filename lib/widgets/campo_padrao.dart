import 'package:dashboard_manga_easy/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CampoPadrao extends GetView {
  final Function(String)? onChange;
  final String? hintText;
  final Widget? icone;
  final void Function()? onEditComplet;
  final TextEditingController? controller;
  const CampoPadrao({
    Key? key,
    this.hintText,
    this.icone,
    this.onChange,
    this.onEditComplet,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: Get.textTheme.subtitle1!.copyWith(color: AppTheme.bgColor),
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.white,
      onEditingComplete: onEditComplet,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppTheme.primaryColor,
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: icone != null
            ? InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.all(AppTheme.defaultPadding * 0.75),
                  margin: EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding / 2),
                  decoration: BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
              )
            : null,
      ),
    );
  }
}
