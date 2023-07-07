import 'dart:math';

import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    final id = request.id;

    final todo = Todo()
      ..completed = false
      ..id = id
      ..title = 'titl $id';

    // if (id != 10) {
    //   throw FormatException('Expected at least 1 section');
    // }

    return todo;
  }

  @override
  Stream<Todo> getTodoStream(
      ServiceCall call, GetTodoByIdRequest request) async* {
    while (true) {
      final todo = Todo()
        ..completed = false
        ..id = Random().nextInt(request.id)
        ..title = 'title ${Random().nextInt(request.id)}';
      yield todo;

      await Future.delayed(Duration(seconds: 1));
    }
  }
}
