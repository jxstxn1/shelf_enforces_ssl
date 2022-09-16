import 'package:shelf/shelf.dart';

/// This Middleware will ensure that your users are using HTTPS.
Middleware enforceSSL() {
  return (innerHandler) {
    return (request) {
      // Checking if the request is secure.
      if (!request.requestedUri.isScheme('HTTPS')) {
        // If not, redirect to the same URL but with HTTPS.
        if (request.method == 'GET') {
          return Response.movedPermanently(
              request.requestedUri.replace(scheme: 'https'));
        }
        // If the request is not a GET request, return a 403 Forbidden.
        else {
          return Response(403,
              body: 'Please use HTTPS when submitting data to this server.');
        }
      }
      return innerHandler(request);
    };
  };
}
