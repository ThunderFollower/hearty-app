class SharingState {
  final bool isSendingConfirmed;
  final String? sharingUrl;
  final bool isBusy;

  const SharingState({
    this.isSendingConfirmed = false,
    this.sharingUrl,
    this.isBusy = false,
  });

  SharingState copyWith({
    bool? isSendingConfirmed,
    String? sharingUrl,
    bool? isBusy,
  }) {
    return SharingState(
      isSendingConfirmed: isSendingConfirmed ?? this.isSendingConfirmed,
      sharingUrl: sharingUrl ?? this.sharingUrl,
      isBusy: isBusy ?? this.isBusy,
    );
  }
}
