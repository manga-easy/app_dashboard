sealed class DetailsBannerEvent {}

class DetailsBannerEventSuccess implements DetailsBannerEvent {
  final String operation;

  DetailsBannerEventSuccess(this.operation);
}
