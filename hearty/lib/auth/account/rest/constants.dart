/// Defines the path to the
/// [Get a Password Reset](https://test.sparrowbiologic.com/swagger/#/authentication/AuthenticationController_resetPassword)
/// endpoint.
const pathToResetPassword = 'authentication/reset-password';

/// Defines the path to the
/// [Password Recovery](https://test.sparrowbiologic.com/swagger/#/authentication/AuthenticationController_recoverPassword)
/// endpoint.
const pathToRecoverPassword = 'authentication/recover-password';

/// Defines the path to the
/// [Finish Sign-up](https://test.sparrowbiologic.com/swagger/#/authentication/finishRegistration)
/// endpoint.
const pathToRegister = 'authentication/register';

/// Defines the path to the
/// [sign-up by email](https://test.sparrowbiologic.com/swagger/#/sign-up/SignUpController_signUpByEmail)
/// endpoint.
const pathToSignUpByEmail = 'sign-up/by-email';

/// Defines the path to the
/// [Get Current User](https://test.sparrowbiologic.com/swagger/#/authentication/me)
/// endpoint.
const pathToGetUser = 'authentication';

/// The path for the sign-up by email endpoint.
const signUpByEmailPath = '/v2.1/sign-up/by-email';

/// The path for the current user's profile endpoint, relative to the base API
/// URL. This path is used in requests to the API to manipulate the current
/// user's profile, such as getting, updating, or deleting it.
const currentProfilePath = 'me';

/// The path for the authentication refresh endpoint, relative to the base API
/// URL. This path is used in requests to the API to refresh the access and
/// refresh tokens for the current user.
const authenticationRefresh = 'authentication/refresh';
