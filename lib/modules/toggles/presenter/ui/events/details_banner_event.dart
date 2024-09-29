sealed class DetailsTogglesEvent {}

class DetailsTogglesEventSuccess implements DetailsTogglesEvent {
  final String operation;

  DetailsTogglesEventSuccess(this.operation);
}
