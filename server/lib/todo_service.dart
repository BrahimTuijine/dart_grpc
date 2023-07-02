import 'package:protos/protos.dart';

class TodoService extends TodoServiceBase {
  @override
  Future<Todo> getTodo(ServiceCall call, GetTodoByIdRequest request) async {
    final id = request.id;

    final todo = Todo()
      ..completed = false
      ..id = id
      ..title = 'title $id';

    return todo;
  }
}
