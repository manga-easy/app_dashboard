import 'package:flutter/material.dart';

class SwitchDefault extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool)? onChanged;

  const SwitchDefault({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      value: value,
      onChanged: onChanged,
    );
  }
}
