import 'package:dashboard_manga_easy/modules/dashboard/atoms/loading_atom.dart';
import 'package:flutter/material.dart';

class TotalAdquiridoAtom extends StatelessWidget {
  final Future<int>? future;
  const TotalAdquiridoAtom({super.key, required this.future});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Erro');
        if (snapshot.hasData) return Text('Total adquirido: ${snapshot.data}');
        return const LoadingAtom();
      },
    );
  }
}
