# Shelf Enforces SSL

Ensures that only API Requests with a HTTPS connection are accepted.
Inspired by <https://github.com/hengkiardo/express-enforces-ssl>

## Installing

```sh
dart pub add shelf_enforces_ssl
```

## Usage

### As shelf middleware

```dart
import 'package:shelf_enforces_ssl/shelf_enforces_ssl.dart';

  var handler =
      const Pipeline().addMiddleware(enforceSSL()).addMiddleware(logRequests()).addHandler(_echoRequest);
```

### As dart_frog middleware

```dart
import 'package:shelf_enforces_ssl/shelf_enforces_ssl.dart';

Handler enforceSSL(Handler handler) {
    return handler.use(fromShelfMiddleware(enforceSSL()));
}
```

### Defining custom error response

```dart
.addMiddleware(
    enforceSSL(
      errorResponse: Response(
        403,
        body: 'Please use HTTPS when you try to send data to this API',
      ),
    ),
  ),
```
