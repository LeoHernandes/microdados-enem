import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Foobar {
  final int count;

  const Foobar({required this.count});

  factory Foobar.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {'count': int count} => Foobar(count: count),
      _ => throw const FormatException('Failed to load Foboar.'),
    };
  }
}

Future<Foobar> fetchFoobar() async {
  final response = await http.get(
    Uri.parse('http://192.168.3.9:5000/participantes'),
  );

  if (response.statusCode == 200) {
    return Foobar.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
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
  late Future<Foobar> foobar;

  @override
  void initState() {
    super.initState();
    foobar = fetchFoobar();
  }

  void call() {
    foobar = fetchFoobar();
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('A quantidade de linhas na tabela:'),
            FutureBuilder<Foobar>(
              future: foobar,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data!.count.toString());
                } else if (snapshot.hasError) {
                  return const Text('Deu merda a');
                }

                return const CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: call,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
