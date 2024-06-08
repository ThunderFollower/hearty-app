# Stethophone Flutter App

The Stethophone Flutter App seeks to transform the traditional stethoscope experience, introducing a digitized, user-friendly approach that incorporates contemporary technology with standard health monitoring techniques. As a part of the [Stethophone Monorepo](../../README.md), this Flutter-driven mobile application is tailored to ensure a seamless experience on iOS devices.

## Table of Contents

- [Stethophone Flutter App](#stethophone-flutter-app)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Task Execution](#task-execution)
    - [Linting](#linting)
    - [Code Generators](#code-generators)
    - [Asset Updates](#asset-updates)
    - [Building \& Serving](#building--serving)
    - [Testing](#testing)
    - [Miscellaneous Commands](#miscellaneous-commands)
  - [iOS Sub-project](#ios-sub-project)
    - [Development](#development)
    - [Testing iOS](#testing-ios)
  - [Backend API](#backend-api)
  - [Software Architecture](#software-architecture)

## Features

- **Authentication**: Safeguard access ensuring only authorized individuals can access data.
- **Secure Connection**: Robust encryption and protocols to protect personal and health-related information.
- **Stethoscope Functionality**: Real-time listening of heart and lung sounds.
- **Examinations**: Archiving examinations recorded by the stethoscope for future reference.
- **Sharing**: Enables users to share examinations with specialists for remote consultation.

## Task Execution

### Linting

Run `npx nx run stethophone:analyze` which is equivalent to `flutter analyze`.

### Code Generators

Several commands are available to generate necessary codes and assets:

- `npx nx run stethophone:gen`: Equivalent to `flutter pub run build_runner build`.
- `npx nx run stethophone:gen-i18n`: Executes `flutter pub run easy_localization:generate`.

### Asset Updates

Whenever main app assets are modified, the following commands help you regenerate them:

- **Splash Screen:**
  - `npx nx run stethophone:gen-splash`: For splash screen generation. Uses the [flutter native splash package][3].
- **App Icons:**
  - Main Icon: `npx nx run stethophone:gen-icon:main`
  - Test Icon: `npx nx run stethophone:gen-icon:test`
  - Demo Icon: `npx nx run stethophone:gen-icon:demo`
  - UA Icon: `npx nx run stethophone:gen-icon:ua`

(Note: Avoid updating the `project.pbxproj` file after any icon updates)

### Building & Serving

To manually build or serve the app for various flavors/environments, the following commands are handy:

- `npx nx run stethophone:build-ios`: Equivalent to `flutter build ios`.
- `npx nx run stethophone:build-ipa`: Similar to `flutter build ipa`.

For specific environments, append relevant options, e.g.,

```shell
npx nx run stethophone:build-ipa \
  --flavor=test \
  --obfuscate \
  --release \
  --split-debug-info=debug \
  --dart-define-from-file=env/common.json \
  --dart-define-from-file=env/test.json
```

### Testing

Run unit tests using

```shell
npx nx test stethophone
```

or for coverage, use

```shell
npx nx test stethophone:coverage
```

### Miscellaneous Commands

- Get dependencies: `npx nx run stethophone:get`
- Clean build: `npx nx run stethophone:clean`
- Health check: `npx nx run stethophone:doctor`
- Formatting: `npx nx run stethophone:format`

## iOS Sub-project

### Development

Please refer to the [Development Guide for iOS][9] for further information.

### Testing iOS

The iOS project should be separately tested. Refer to the [iOS Tools][6] documentation for generating iOS coverage reports.

## Backend API

To connect with the backend, follow this [guide][5]

## Software Architecture

Inspired by the Screaming Architecture principle, delve into the [Software Architecture Document][7] for intricate details.

[3]: https://pub.dev/packages/flutter_native_splash 'flutter_native_splash package'
[5]: https://bitbucket.org/sparrowacoustics/stethophone_backend/src/master/README.md 'Backend API'
[6]: ios/Tools/README.md 'iOS Tools'
[7]: docs/architecture.md 'Software Architecture Document'
[9]: docs/development_for_ios.md 'Development Guide for iOS'
