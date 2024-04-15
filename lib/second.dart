// two_page.dart
import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Вторая страница'),
      ),
      body: const Center(
        child: Text('Тут что-то будет'),
      ),
    );
  }
}