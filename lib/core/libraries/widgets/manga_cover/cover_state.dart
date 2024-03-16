import 'package:flutter/material.dart';

abstract class CoverState {
  abstract final ImageProvider image;

  CoverState();
}

class CoverSuccess implements CoverState {
  @override
  ImageProvider<Object> image;

  CoverSuccess(this.image);
}

class CoverError extends CoverState {
  @override
  // ignore: avoid_class_asset_image
  final ImageProvider<Object> image = AssetImage('');
}

class CoverLoading extends CoverState {
  @override
  // ignore: avoid_class_asset_image
  final ImageProvider<Object> image = AssetImage('AssetsState.loading.path');
}
