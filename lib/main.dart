import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> titles = [];

  @override
  void initState() {
    super.initState();
    _loadAssetFiles();
  }

  Future<void> _loadAssetFiles() async {
    // Replace 'books' with your actual assets directory
    const String directoryPath = 'assets/books';

    try {
      // Get a list of file names in the specified directory
      List<String> fileNames =
          await rootBundle.assetManifest().then((manifest) {
        return manifest.keys
            .where((key) => key.startsWith(directoryPath))
            .map((key) => key.substring(directoryPath.length + 1))
            .toList();
      });

      // Now, you have the list of file names in the 'fileNames' variable.
      // You can assign it to your 'titles' list or perform any other operations.

      setState(() {
        this.titles = List.from(fileNames);
      });

      // Print the list of titles (optional)
      print('Titles: $titles');
    } catch (e) {
      // Handle any potential errors
      print('Error loading asset files: $e');
    }
  }
  // Future<void> _loadFileTitles() async {
  //   final manifest = await rootBundle.loadString('AssetManifest.json');
  //   // Parse manifest JSON to find files in assets/books
  //   final booksDir = 'assets/books/';
  //   final titles = manifest
  //       .split('\n')
  //       .where((line) => line.startsWith(booksDir) && line.endsWith('.txt'))
  //       .map((line) => line.split('/').last.split('.').first)
  //       .toList();

  //   setState(() {
  //     this.titles = titles;
  //   });
  // }

  Future<void> _openFile(String title) async {
    final content = await rootBundle.loadString('assets/books/$title.txt');

    // Display the content in a new screen or dialog
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TextScreen(content: content),
      ),
    );
  }

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
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Text Files'),
        ),
        body: ListView.builder(
          itemCount: titles.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(titles[index]),
              onTap: () => _openFile(titles[index]),
            );
          },
        ),
      ),
    );
  }
}

class TextScreen extends StatelessWidget {
  final String content;

  const TextScreen({Key? key, required this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Content'),
      ),
      body: SingleChildScrollView(
        child: Text(content),
      ),
    );
  }
}
