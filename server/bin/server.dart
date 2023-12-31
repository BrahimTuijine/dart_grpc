import 'package:protos/protos.dart';
import 'package:server/my_middleware.dart';
import 'package:server/todo_service.dart';

void main(List<String> arguments) async {
  final server = Server.create(
    interceptors: [logMetadataInterceptor],
    services: [
      TodoService(),
    ],
  );

  await server.serve(port: 8080);
  print('Server listening on port ${server.port}...');
}
