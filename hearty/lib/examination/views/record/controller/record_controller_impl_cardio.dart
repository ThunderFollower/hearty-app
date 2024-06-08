part of 'record_controller_impl.dart';

mixin _Cardio on _Base {
  void _loadCardioFindings() {
    cardioFindingService
        .listBy(recordId: recordId, cancellation: cancellation)
        .ignoreError(NotFoundException)
        .flatMap((value) => Stream.fromIterable(value))
        .listen(_handleFoundCardio, onError: _handleError)
        .addToList(this);
  }

  void _handleFoundCardio(CardioFinding cardio) {
    state = state.copyWith(
      heartRate: cardio.heartRate,
      hasMurmur: cardio.hasMurmur,
      isFine: cardio.isFine,
    );
  }
}
