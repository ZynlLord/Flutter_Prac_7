// three_page.dart
import 'package:flutter/material.dart';

class ThreePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Третья страница'),
      ),
      body: const Center(
        child: Text('Тут тоже что-то будет'),
      ),
    );
  }
}
