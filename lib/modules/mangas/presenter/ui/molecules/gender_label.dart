import 'package:flutter/material.dart';

class GenderLabel extends StatelessWidget {
  final String gender;
  final void Function(String gender)? onRemove;
  final void Function(String gender)? onTap;

  const GenderLabel({
    super.key,
    this.onRemove,
    required this.gender,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap != null ? () => onTap!(gender) : null,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 3,
          horizontal: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              gender,
            ),
            const SizedBox(width: 5),
            onRemove != null
                ? IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => onRemove!(gender),
                    icon: const Icon(Icons.clear),
                    color: Theme.of(context).colorScheme.primary,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
