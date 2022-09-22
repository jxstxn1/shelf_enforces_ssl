import 'package:shelf/shelf.dart';

/// Copied from the Shelf package.
/// https://github.com/dart-lang/shelf/blob/master/pkgs/shelf/test/test_util.dart
/// A simple, synchronous handler for [Request].
///
/// By default, replies with a status code 200, empty headers, and
/// `Hello from ${request.url.path}`.
Response syncHandler(
  Request request, {
  int? statusCode,
  Map<String, String>? headers,
}) {
  return Response(
    statusCode ?? 200,
    headers: headers,
    body: 'Hello from ${request.requestedUri.path}',
  );
}

Future<Response> makeRequest(
  Handler handler, {
  required Uri uri,
  required String method,
  Map<String, Object>? headers,
  Object? body,
}) =>
    Future.sync(
      () => handler(
        Request(
          method,
          uri,
          headers: headers,
          body: body,
        ),
      ),
    );

final localhostUri = Uri.parse('http://localhost/');
final localhostUriWithSSL = Uri.parse('https://localhost/');

List<String> methods = [
  'GET',
  'POST',
  'PUT',
  'PATCH',
  'DELETE',
  'COPY',
  'HEAD',
  'OPTIONS',
  'LINK',
  'UNLINK',
  'PURGE',
  'LOCK',
  'UNLOCK',
  'PROPFIND',
  'VIEW',
];

int itererateWithoutGET = 1;
int itererateWithGET = 0;
