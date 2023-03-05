import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DrawerListTileAtom extends StatelessWidget {
  const DrawerListTileAtom({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        theme: const SvgTheme(
          currentColor: Colors.white54,
        ),
        height: 16,
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
