import 'package:dashboard_manga_easy/modules/dashboard/atoms/button_padrao_atom.dart';
import 'package:flutter/material.dart';
import 'package:sdk_manga_easy/sdk_manga_easy.dart';

class StatusBarEnquete extends StatelessWidget {
  final EnqueteStatus enqueteStatus;
  final void Function()? onFinished;
  final void Function()? onStart;

  const StatusBarEnquete({
    super.key,
    required this.enqueteStatus,
    this.onFinished,
    this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Status: ',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white54),
        ),
        Text(
          enqueteStatus.name,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: retornaCorStatus()),
        ),
        const Spacer(),
        ButtonPadraoAtom(
          title: retornaDescricao(),
          icone: Icons.star_outline_sharp,
          onPress: retornaFunction(),
        )
      ],
    );
  }

  Color retornaCorStatus() {
    switch (enqueteStatus) {
      case EnqueteStatus.finished:
        return Colors.red;
      case EnqueteStatus.started:
        return Colors.yellow;
      case EnqueteStatus.progress:
        return Colors.green;
      default:
        return Colors.white;
    }
  }

  String retornaDescricao() {
    switch (enqueteStatus) {
      case EnqueteStatus.finished:
        return '';
      case EnqueteStatus.started:
        return "Começar";
      case EnqueteStatus.progress:
        return 'Finalizar';
      default:
        return '';
    }
  }

  void Function()? retornaFunction() {
    switch (enqueteStatus) {
      case EnqueteStatus.started:
        return onStart;
      case EnqueteStatus.progress:
        return onFinished;
      default:
        return null;
    }
  }
}
