import 'package:flutter/material.dart';

class StatusNotification extends StatelessWidget {
  final String status;
  const StatusNotification({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).hoverColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        child: Text(
          status,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: getColor()),
        ),
      ),
    );
  }

  Color getColor() {
    if (status == 'ERROR') {
      return Colors.red;
    }
    if (status == 'SUCCESS') {
      return Colors.green;
    }
    return Colors.blue;
  }
}
