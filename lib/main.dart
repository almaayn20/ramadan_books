import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramadan Books',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        fontFamily: 'Cairo',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    loadTitlesFromFiles();
  }

  void loadTitlesFromFiles() async {
    // Directory path where your text files are stored
    Directory directory = Directory('/assets/books');

    // List all files in the directory
    List<FileSystemEntity> files = directory.listSync();

    // Extract titles from file names
    titles = files.map((file) => file.uri.pathSegments.last).toList();

    setState(() {});
  }

  Future<void> openTextFile(String fileName) async {
    try {
      File file = File('/assets/books/$fileName');
      String fileContents = await file.readAsString();

      // Use the file contents as needed (e.g., display in a new screen)
      print(fileContents);
    } catch (e) {
      print('Error opening file: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('كتب رمضانية'),
        leading: Icon(Icons.light_mode),
      ),
      body: ListView.builder(
        itemCount: titles.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(titles[index]),
            onTap: () {
              openTextFile(titles[index]);
            },
          );
        },
      ),
    );
  }
}
