import 'dart:math';

import 'package:flutter/material.dart';
import 'package:protos/protos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ClientChannel _channel;

  late TodoServiceClient _stub;

  Todo? todo;

  @override
  void initState() {
    super.initState();
    _channel = ClientChannel(
      '192.168.1.103',
      port: 8080,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
    _stub = TodoServiceClient(_channel);
  }

  Future<void> getTodo() async {
    final id = Random().nextInt(100);
    try {
      final todo = await _stub.getTodo(GetTodoByIdRequest()..id = id);
      setState(() {
        this.todo = todo;
      });
    } catch (e) {
      print(e);
    }
  }

  Stream<Todo>? getTodoStream() {
    return _stub.getTodoStream(GetTodoByIdRequest()..id = 10);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            // StreamBuilder<Todo>(
            //   stream: getTodoStream(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       return Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         mainAxisSize: MainAxisSize.max,
            //         children: <Widget>[
            //           Text(
            //               '''${snapshot.data!.id} ${snapshot.data!.title} ${snapshot.data!.completed}'''),
            //         ],
            //       );
            //     } else if (snapshot.hasError) {
            //       return Text(snapshot.error.toString());
            //     } else {
            //       return const CircularProgressIndicator();
            //     }
            //   },
            // ),
            if (todo != null) ...[
              Text(todo!.id.toString()),
              Text(todo!.title),
              Text(todo!.completed.toString()),
            ] else
              const Text('get your todo'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getTodo,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
