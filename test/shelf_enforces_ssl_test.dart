import 'package:shelf/shelf.dart';
import 'package:shelf_enforces_ssl/shelf_enforces_ssl.dart';
import 'package:test/test.dart';

import 'test_utils.dart';

void main() {
  group('Not Using SSL', () {
    test('GET request results in a Staus Code of 301', () async {
      final handler = enforceSSL()(syncHandler);
      final response = await makeRequest(handler, method: 'GET', uri: localhostUri);
      expect(response.statusCode, 301);
      expect(response.headers['location'], localhostUriWithSSL.toString());
    });

    for (int i = itererateWithoutGET; i < methods.length; i++) {
      test('${methods.elementAt(i)} request results in a Status Code of 403', () async {
        final handler = enforceSSL()(syncHandler);
        final response = await makeRequest(
          handler,
          method: methods.elementAt(i),
          uri: localhostUri,
        );
        expect(response.statusCode, 403);
        expect(
          response.readAsString(),
          completion(
            'Please use HTTPS when submitting data to this server.',
          ),
        );
      });
    }
  });

  group('Using SSL', () {
    for (int i = itererateWithGET; i < methods.length; i++) {
      test('${methods.elementAt(i)} request results in a Status Code of 200', () async {
        final handler = enforceSSL()(syncHandler);
        final response = await makeRequest(
          handler,
          method: methods.elementAt(i),
          uri: localhostUriWithSSL,
        );
        expect(response.statusCode, 200);
        expect(response.readAsString(), completion('Hello from /'));
      });
    }
  });

  group('Return a custom Error Response', () {
    for (int i = itererateWithoutGET; i < methods.length; i++) {
      test('${methods.elementAt(i)} request results in a custom errorResponse', () async {
        final handler = enforceSSL(
          errorResponse: Response(418, body: 'Im a Teapot'),
        )(syncHandler);
        final response = await makeRequest(
          handler,
          method: methods.elementAt(i),
          uri: localhostUri,
        );
        expect(response.statusCode, 418);
        expect(response.readAsString(), completion('Im a Teapot'));
      });
    }
  });
}
