// one_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_kprac7/book.dart';
import 'package:flutter_kprac7/BookSearchDelegate.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  List<Book> cinemas = [
    Book(title: 'Стивен Кинг - Мистер Мерседес', category: 'Триллер', mark: 4.5),
    Book(title: 'Джоан Роулинг - Гарри Поттер и Филосовский камень', category: 'Фэнтези', mark: 3.8),
    Book(title: 'Совершенный код', category: 'Программирование', mark: 4.2),
    Book(title: 'Harry Potter', category: 'Фэнтези', mark: 4.2),
  ];

  List<String> categories = ['Все', 'Триллер', 'Фэнтези', 'Программирование'];
  String selectedCategory = 'Все';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Книги'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                  context: context, delegate: BookSearchDelegate(cinemas));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildCategoryChips(),
          _buildMoviesList(),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        return FilterChip(
          label: Text(category),
          selected: selectedCategory == category,
          onSelected: (bool selected) {
            setState(() {
              selectedCategory = selected ? category : 'Все';
            });
          },
        );
      }).toList(),
    );
  }

  Widget _buildMoviesList() {
    List<Book> filteredMovies = selectedCategory == 'Все'
        ? cinemas
        : cinemas.where((movie) => movie.category == selectedCategory).toList();

    return Expanded(
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState: filteredMovies.isEmpty
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        firstChild: ListView.builder(
          itemCount: filteredMovies.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredMovies[index].title),
              subtitle: Text(
                  'Жанр: ${filteredMovies[index].category}\nРейтинг: ${filteredMovies[index].mark}'),
            );
          },
        ),
        secondChild: const Center(
          child: Text('Нет книг выбранного жанра'),
        ),
      ),
    );
  }
}
