import 'package:freezed_annotation/freezed_annotation.dart';

import 'credentials.dart';

part 'credentials_set.freezed.dart';
part 'credentials_set.g.dart';

@freezed
class CredentialsSet with _$CredentialsSet {
  const factory CredentialsSet({
    @Default(<Credentials>{}) Set<Credentials> credentials,
  }) = _CredentialsSet;

  const CredentialsSet._();

  factory CredentialsSet.fromJson(Map<String, dynamic> json) =>
      _$CredentialsSetFromJson(json);

  bool get isEmpty => credentials.isEmpty;

  bool get isNotEmpty => credentials.isNotEmpty;

  int get length => credentials.length;

  Credentials get first => credentials.first;

  Set<Credentials> get data => credentials;

  CredentialsSet add(Credentials credentials) {
    final newCredentials = Set<Credentials>.from(this.credentials)
      ..remove(credentials)
      ..add(credentials);
    return CredentialsSet(credentials: newCredentials);
  }

  CredentialsSet remove(String login) {
    final newCredentials = Set<Credentials>.from(credentials)
      ..removeWhere((credential) => credential.login == login);
    return CredentialsSet(credentials: newCredentials);
  }
}
