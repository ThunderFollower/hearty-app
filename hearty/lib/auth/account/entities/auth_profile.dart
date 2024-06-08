import '../user_role.dart';

/// Represents a user's authentication profile.
class AuthProfile {
  /// The user's ID.
  final String id;

  /// The user's email address.
  final String email;

  /// The user's password.
  final String? password;

  /// The date/time when the access token will expire.
  final DateTime? expiresAt;

  /// The user's access token.
  final String? accessToken;

  /// The user's refresh token.
  final String? refreshToken;

  /// A flag indicating whether the user is authenticated using 2-factor
  /// authentication (2FA).
  final bool is2FAAuthenticated;

  /// The user's current role for defining app mode.
  final UserRole role;

  /// Creates a new instance of [AuthProfile].
  const AuthProfile({
    required this.id,
    required this.email,
    this.password,
    this.expiresAt,
    this.accessToken,
    this.refreshToken,
    this.is2FAAuthenticated = false,
    this.role = UserRole.patient,
  });

  /// Creates a new [AuthProfile] object with the same fields as the original
  /// object, but with any non-null fields in [other] replacing the
  /// corresponding fields in the original object.
  AuthProfile merge(AuthProfile other) {
    return AuthProfile(
      id: other.id,
      email: other.email,
      password: other.password ?? password,
      expiresAt: other.expiresAt ?? expiresAt,
      accessToken: other.accessToken ?? accessToken,
      refreshToken: other.refreshToken ?? refreshToken,
      is2FAAuthenticated: other.is2FAAuthenticated,
      role: other.role,
    );
  }

  /// Creates a copy of this [AuthProfile] with the specified fields updated.
  AuthProfile copyWith({
    String? id,
    String? email,
    String? password,
    DateTime? expiresAt,
    String? accessToken,
    String? refreshToken,
    bool? is2FAAuthenticated,
    UserRole? role,
  }) {
    return AuthProfile(
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
      expiresAt: expiresAt ?? this.expiresAt,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      is2FAAuthenticated: is2FAAuthenticated ?? this.is2FAAuthenticated,
      role: role ?? this.role,
    );
  }
}
