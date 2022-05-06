import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CampoPadraoAtom extends StatelessWidget {
  final Function(String)? onChange;
  final String? hintText;
  final Widget? icone;
  final void Function()? onEditComplet;
  final TextEditingController? controller;
  final bool? obscureText;
  final int? numberLines;
  final String? initialValue;
  final void Function(String)? onSubmitted;

  const CampoPadraoAtom({
    Key? key,
    this.obscureText,
    this.numberLines = 1,
    this.hintText,
    this.icone,
    this.onChange,
    this.onEditComplet,
    this.controller,
    this.initialValue,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      obscureText: obscureText != null,
      maxLines: numberLines,
      onFieldSubmitted: onSubmitted,
      style: Theme.of(context).textTheme.subtitle1!.copyWith(color: AppTheme.bgColor),
      onChanged: onChange,
      controller: controller,
      cursorColor: Colors.white,
      onEditingComplete: onEditComplet,
      decoration: InputDecoration(
        hintText: hintText,
        fillColor: AppTheme.primaryColor,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: icone != null
            ? InkWell(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(AppTheme.defaultPadding * 0.75),
                  margin: const EdgeInsets.symmetric(horizontal: AppTheme.defaultPadding / 2),
                  decoration: const BoxDecoration(
                    color: AppTheme.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: SvgPicture.asset("assets/icons/Search.svg"),
                ),
              )
            : null,
      ),
    );
  }
}
