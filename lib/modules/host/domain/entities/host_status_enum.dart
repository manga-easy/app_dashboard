enum HostStatus {
  disable,
  enable;

  static HostStatus getStatus(String? name) {
    switch (name) {
      case 'disable':
        return HostStatus.disable;
      case 'enable':
        return HostStatus.enable;
      default:
        return HostStatus.disable;
    }
  }
}
