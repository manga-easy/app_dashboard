import 'package:flutter/material.dart';

class ErrorDefaultPage extends StatelessWidget {
  const ErrorDefaultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            'Error entre em contato com os Dev',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
