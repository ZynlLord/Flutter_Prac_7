// my_home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_kprac7/first.dart';
import 'package:flutter_kprac7/second.dart';
import 'package:flutter_kprac7/third.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Электронная библиотека',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Электронная библиотека'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [FirstPage(), SecondPage(), ThreePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.info),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () => {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Row(
                      children: [
                        Text('Всего на Земле 129864880 книг.'),
                        Icon(Icons.fact_check, color: Colors.amber)
                      ],
                    ),
                  ))
                },
                value: 1,
                child: const Text('Факт'),
              ),
              PopupMenuItem(
                onTap: () async {
                  final bool? result = await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(true);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Много читать - тоже вредно'),
                                  ),
                                );
                              },
                              child: const Text('Узнать')),
                          TextButton(
                              onPressed: () {
                                Navigator.of(context, rootNavigator: true)
                                    .pop(false);
                              },
                              child: const Text('Отмена'))
                        ],
                        content: const Text('Известный факт'),
                        title: const Text('Факт'),
                      );
                    },
                  );
                  result ?? false ? print(result) : print(result);
                },
                value: 2,
                child: const Text("Факт 2"),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.person),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Книги"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_sharp), label: "Библиотека"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Профиль"),
        ],
      ),
      drawer: Drawer(
        backgroundColor: Colors.yellow,
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text("Книги"),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book_sharp),
              title: const Text("Библиотека"),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Профиль"),
              onTap: () {
                Navigator.pop(context);
                _navigateTo(2);
              },
            ),
          ],
        ),
      ),
      body: _pages[_currentIndex],
    );
  }

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
