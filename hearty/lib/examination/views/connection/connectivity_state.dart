class ConnectivityState {
  final bool isAuthenticated;
  final bool isConnected;
  final bool isOpen;

  ConnectivityState({
    this.isAuthenticated = false,
    this.isConnected = true,
    this.isOpen = false,
  });

  ConnectivityState copyWith({
    bool? isAuthenticated,
    bool? isConnected,
    bool? isOpen,
  }) {
    return ConnectivityState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isConnected: isConnected ?? this.isConnected,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}
