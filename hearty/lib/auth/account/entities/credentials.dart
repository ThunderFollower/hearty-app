import 'package:freezed_annotation/freezed_annotation.dart';

part 'credentials.freezed.dart';
part 'credentials.g.dart';

@freezed
class Credentials with _$Credentials {
  const factory Credentials({required String login, required String password}) =
      _Credentials;

  factory Credentials.fromJson(Map<String, dynamic> json) =>
      _$CredentialsFromJson(json);

  const Credentials._();

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Credentials &&
            const DeepCollectionEquality().equals(other.login, login));
  }

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(login),
      );
}
