import 'dart:async';

import 'package:protos/protos.dart';

FutureOr<GrpcError?> logMetadataInterceptor(
  ServiceCall call,
  ServiceMethod method,
) {
  print(method.name);
  print(call.clientMetadata);
  // throw GrpcError.unauthenticated('Wrong username and password');
  // return GrpcError.ok('oumourek mrigla');
  return null;
}
