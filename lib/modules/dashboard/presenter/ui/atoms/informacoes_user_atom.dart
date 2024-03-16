import 'package:dashboard_manga_easy/modules/dashboard/presenter/ui/atoms/loading_atom.dart';
import 'package:dashboard_manga_easy/modules/users/domain/entities/user.dart';
import 'package:flutter/material.dart';

class InformacoesUserAtom extends StatelessWidget {
  final Future<User>? future;
  const InformacoesUserAtom({super.key, required this.future});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError) return const Text('Erro');
        if (snapshot.hasData) return Text(snapshot.data!.email);
        return const LoadingAtom();
      },
    );
  }
}
