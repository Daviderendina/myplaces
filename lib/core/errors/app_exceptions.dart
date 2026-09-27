class AppException implements Exception {
  final String message;

  const AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'Unable to reach the remote service']);
}

class DataNotFoundException extends AppException {
  const DataNotFoundException([super.message = 'Requested data was not found']);
}

class PhotoFetchException extends AppException {
  const PhotoFetchException([super.message = 'Unable to fetch POI photos']);
}
