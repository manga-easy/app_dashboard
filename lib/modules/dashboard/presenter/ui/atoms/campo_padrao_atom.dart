import 'package:dashboard_manga_easy/core/config/app_theme.dart';
import 'package:flutter/material.dart';

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
  final TextInputType? keyboardType;

  const CampoPadraoAtom({
    super.key,
    this.obscureText,
    this.numberLines = 1,
    this.hintText,
    this.icone,
    this.onChange,
    this.onEditComplet,
    this.controller,
    this.initialValue,
    this.onSubmitted,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (hintText != null)
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hintText!,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        else
          const SizedBox(),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: initialValue,
          obscureText: obscureText != null,
          maxLines: numberLines,
          onFieldSubmitted: onSubmitted,
          style: Theme.of(context).textTheme.titleMedium,
          onChanged: onChange,
          controller: controller,
          onEditingComplete: onEditComplet,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            border: const OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            suffixIcon: icone != null
                ? InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(
                        AppTheme.defaultPadding * 0.75,
                      ),
                      margin: const EdgeInsets.symmetric(
                        horizontal: AppTheme.defaultPadding / 2,
                      ),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.search),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
