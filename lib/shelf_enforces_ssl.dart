/// Middleware that will enforce Users to use HTTPS.
library shelf_enforces_ssl;

import 'package:shelf/shelf.dart';

/// This Middleware will ensure that your users are using HTTPS.
///
/// [errorResponse] is the error response that will be returned if the user is not using HTTPS.
/// by default it is a 403 Forbidden response with the message "Please use HTTPS when submitting data to this server."
Middleware enforceSSL({Response? errorResponse}) {
  return (innerHandler) {
    return (request) {
      // Checking if the request is secure.
      if (!request.requestedUri.isScheme('HTTPS')) {
        // If not, redirect to the same URL but with HTTPS.
        if (request.method == 'GET') {
          return Response.movedPermanently(
            request.requestedUri.replace(scheme: 'https'),
          );
        }
        // If the request is not a GET request, return a 403 Forbidden.
        else {
          return errorResponse ??
              Response(
                403,
                body: 'Please use HTTPS when submitting data to this server.',
              );
        }
      }
      return innerHandler(request);
    };
  };
}
