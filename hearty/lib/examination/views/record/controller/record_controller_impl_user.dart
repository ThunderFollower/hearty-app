part of 'record_controller_impl.dart';

mixin _User on _Base {
  void _loadUser() {
    authProfileService
        .observeProfileChanges()
        .map((event) => event?.role)
        .distinct()
        .listen(_handlerChangedUserRole, onError: _handleError)
        .addToList(this);
  }

  void _handlerChangedUserRole(UserRole? role) {
    state = state.copyWith(isAdvancedMode: role == UserRole.doctor);
  }
}
