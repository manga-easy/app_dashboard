import 'package:flutter/material.dart';

class NameUserBuild extends StatelessWidget {
  final Future<String>? future;
  const NameUserBuild({super.key, this.future});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: future,
      builder: (context, snap) {
        if (snap.hasData) {
          return Text(snap.data ?? '');
        }
        if (snap.hasError) {
          return Text(snap.error?.toString() ?? '');
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
