import 'package:flutter/material.dart';

abstract class IController extends ChangeNotifier {
  void init(BuildContext context);
}
