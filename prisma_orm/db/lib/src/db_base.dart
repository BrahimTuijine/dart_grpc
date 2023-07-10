import 'package:db/db.dart';
import 'package:orm/logger.dart';

class Database {
  Database()
      : dataBase = PrismaClient(
          stdout: Event.values,
          datasources: Datasources(
            db: "postgresql://postgres:root@localhost:5432/grpcDb",
          ),
        );

  PrismaClient dataBase;

  PrismaClient get db => dataBase;

  Future<User?> createUser(
      {required String email, required String name}) async {
    db.user.create(
      data: UserCreateInput(name: name, email: email),
    );
  }

  //TODO create a separate class User contains all user function
  //and inject class Database using injectable
}
