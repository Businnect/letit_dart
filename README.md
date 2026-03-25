# LetIt Dart SDK

A professional Dart client for the LetIt API, featuring high-performance support for **Microposts** and **Job** management.

## 📖 API Documentation

For detailed information on the underlying REST API, endpoints, and authentication schemas, please visit the official documentation:

- **API Reference**: [http://api.letit.com](https://api.letit.com/docs/client/)

## Features

- **Job Management**: Full support for creating job postings with company logos, descriptions, and metadata.
- **Micropost System**: Create text posts or file-based updates with attachment support.
- **HTTP Client Support**: Built on `package:http` with centralized authentication and API error handling.

## Installation

```bash
dart pub add letit
```

## Quick Start

### Initialize the Client

The client can be initialized with an explicit API key and base URL.

```dart
import 'package:letit/letit.dart';

void main() {
  // Pass the API key and Base URL
  final client = LetItClient(
    apiKey: 'your-api-token',
    baseURL: 'https://api.letit.com',
  );
}
```

### Create a Job with a Company Logo

The SDK handles multipart form construction and file uploads automatically.

```dart
import 'dart:io';

import 'package:letit/letit.dart';
import 'package:letit/schemas/schemas.dart';

Future<void> main() async {
  final client = LetItClient(
    apiKey: 'your-api-token',
    baseURL: 'https://api.letit.com',
  );

  final logoFile = File('logo.png');
  final logoPayload = FilePayload(
    filename: 'logo.png',
    bytes: await logoFile.readAsBytes(),
    mimeType: 'image/png',
  );

  final response = await client.job.createWithCompany(
    companyName: 'Acme Corp',
    companyDescription: 'Building next-gen developer tools.',
    companyWebsite: 'https://acme.example',
    jobTitle: 'Senior Dart Developer',
    jobDescription: 'Building production SDKs and integrations.',
    jobHowToApply: 'https://acme.example/careers',
    companyLogo: logoPayload,
    jobLocation: JobLocation.remote,
  );

  print('Job created successfully: ${response.slug}');
}
```

### Create a Micropost

Easily create posts with optional titles and bodies.

```dart
import 'package:letit/letit.dart';
import 'package:letit/schemas/schemas.dart';

Future<void> main() async {
  final client = LetItClient(
    apiKey: 'your-api-token',
    baseURL: 'https://api.letit.com',
  );

  final response = await client.micropost.create(
    title: 'New Update',
    body: 'The Dart SDK is now live!',
    postType: PostType.text,
  );

  print('Post created with ID: ${response.publicId}');
}
```

## Environment Variables

The SDK can utilize the following environment variable for testing or default configuration:

- `LETIT_API_TOKEN`: Used by integration tests to authenticate against the live API.

## Testing

Run the test suite using the standard Dart toolchain:

```powershell
# In PowerShell
$env:LETIT_API_TOKEN="your-token"
dart test
```

```bash
# In Bash
LETIT_API_TOKEN="your-token" dart test
```

## Publishing
 
This package is published to [pub.dev](https://pub.dev/packages/letit) via GitHub Actions.

You will have to have an account first equalt to what you use for your git config file.

```bash
[user]
        name = yours
        email = yours
```
 
### How it works
 
Publishing is triggered automatically when a new GitHub Release is created.
 
```
1. Update CHANGELOG.md with the new version and changes
2. Bump the version in pubspec.yaml
3. Commit and push changes
4. Create a new GitHub Release with the version tag for example v0.1.0 at https://github.com/Businnect/letit_dart/releases/new
   → GitHub Actions runs automatically
   → Verifies formatting, runs analysis and tests, validates package
   → Publishes to pub.dev
```
 
### Manual publishing
 
If you need to publish manually from your local machine:
 
```bash
# Dry run first to check for issues
dart pub publish --dry-run
 
# Publish in production 
dart pub publish
```
 
### Versioning
 
This package follows [semantic versioning](https://semver.org/):
 
- `MAJOR` — breaking changes
- `MINOR` — new features, backwards compatible
- `PATCH` — bug fixes, backwards compatible
 
Always update `CHANGELOG.md` and `pubspec.yaml` before creating a release.