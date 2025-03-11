import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book App',
          theme: ThemeData(
            primarySwatch: Colors.lightBlue,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.black),
              bodyMedium: TextStyle(color: Colors.black),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            textTheme: const TextTheme(
              bodyLarge: TextStyle(color: Colors.white),
              bodyMedium: TextStyle(color: Colors.white),
            ),
          ),
          themeMode: currentMode,
          home: const LoginPage(),
        );
      },
    );
  }
}

ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();

  void _login() {
    if (_emailController.text == 'arceeluceno@gmail.com' &&
        _passwordController.text == '123123') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid credentials!')),
      );
    }
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the current theme
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book App'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/kobo.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: isDarkMode
                    ? Colors.black.withOpacity(0.8)
                    : Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    spreadRadius: 2,
                    offset: Offset(2, 5),
                  ),
                ],
              ),
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    onTap: () {
                      _emailFocusNode.requestFocus();
                    },
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Book> _books = [
    Book(
      title: 'Clean Code: A Handbook of Agile Software Craftsmanship',
      price: 30.0,
      coverPath: 'assets/book1.jpg',
      description: 'Clean Code is a book by Robert C. Martin that provides practical advice on writing clean, maintainable code. [Source: Robert C. Martin]',
    ),
    Book(
      title: 'The Pragmatic Programmer: Your Journey to Mastery',
      price: 35.0,
      coverPath: 'assets/book2.jpg',
      description: 'The Pragmatic Programmer by Andrew Hunt and David Thomas offers tips and techniques for becoming a better programmer. [Source: Andrew Hunt, David Thomas]',
    ),
    Book(
      title: 'Design Patterns: Elements of Reusable Object-Oriented Software',
      price: 40.0,
      coverPath: 'assets/book3.jpg',
      description: 'Design Patterns by Erich Gamma, Richard Helm, Ralph Johnson, and John Vlissides introduces 23 classic software design patterns. [Source: Erich Gamma, Richard Helm, Ralph Johnson, John Vlissides]',
    ),
    Book(
      title: 'Refactoring: Improving the Design of Existing Code',
      price: 45.0,
      coverPath: 'assets/book4.jpg',
      description: 'Refactoring by Martin Fowler provides a guide to improving the design of existing code through refactoring techniques. [Source: Martin Fowler]',
    ),
    Book(
      title: 'Introduction to the Theory of Computation',
      price: 50.0,
      coverPath: 'assets/book5.jpg',
      description: 'Introduction to the Theory of Computation by Michael Sipser covers the fundamental concepts of theoretical computer science. [Source: Michael Sipser]',
    ),
    Book(
      title: 'Artificial Intelligence: A Modern Approach',
      price: 60.0,
      coverPath: 'assets/book6.jpg',
      description: 'Artificial Intelligence: A Modern Approach by Stuart Russell and Peter Norvig is a comprehensive textbook on AI. [Source: Stuart Russell, Peter Norvig]',
    ),
    Book(
      title: 'The Art of Computer Programming',
      price: 70.0,
      coverPath: 'assets/book7.jpg',
      description: 'The Art of Computer Programming by Donald Knuth is a multi-volume work on algorithms and programming techniques. [Source: Donald Knuth]',
    ),
    Book(
      title: 'Structure and Interpretation of Computer Programs',
      price: 55.0,
      coverPath: 'assets/book8.jpg',
      description: 'Structure and Interpretation of Computer Programs by Harold Abelson and Gerald Jay Sussman is a foundational text in computer science. [Source: Harold Abelson, Gerald Jay Sussman]',
    ),
  ];

  final List<Book> _favorites = [];
  final List<Book> _cart = [];
  final TextEditingController _searchController = TextEditingController();
  List<Book> _filteredBooks = [];

  @override
  void initState() {
    super.initState();
    _filteredBooks = _books;
  }

  void _addToFavorites(Book book) {
    setState(() {
      if (_favorites.contains(book)) {
        _favorites.remove(book);
      } else {
        _favorites.add(book);
      }
    });
  }

  void _addToCart(Book book) {
    setState(() {
      _cart.add(book);
    });
  }

  void _checkout() {
    double total = _cart.fold(0, (sum, book) => sum + book.price);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Checkout'),
        content: Text('Total: \$${total.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _cart.clear();
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartPage(cart: _cart, checkout: _checkout),
                ),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _searchBooks(String query) {
    setState(() {
      _filteredBooks = _books
          .where(
              (book) => book.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        leading: ValueListenableBuilder<ThemeMode>(
          valueListenable: themeNotifier,
          builder: (_, ThemeMode currentMode, __) {
            return IconButton(
              icon: Icon(currentMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode),
              onPressed: () {
                themeNotifier.value = currentMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritesPage(favorites: _favorites),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartPage(cart: _cart, checkout: _checkout),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search Books',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _searchBooks,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBooks.length,
              itemBuilder: (context, index) {
                final book = _filteredBooks[index];
                return ListTile(
                  leading: Image.asset(book.coverPath,
                      width: 50, height: 50, fit: BoxFit.cover),
                  title: Text(book.title),
                  subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                            _favorites.contains(book)
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                _favorites.contains(book) ? Colors.red : null),
                        onPressed: () => _addToFavorites(book),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () => _addToCart(book),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetailPage(book: book),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
        actions: [
          IconButton(
            icon: Icon(themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(book.coverPath,
                width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(height: 16),
            Text(
              book.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '\$${book.price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            Text(
              book.description,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Book> favorites;

  const FavoritesPage({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [
          IconButton(
            icon: Icon(themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (context, index) {
          final book = favorites[index];
          return ListTile(
            title: Text(book.title),
            subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}

class CartPage extends StatefulWidget {
  final List<Book> cart;
  final VoidCallback checkout;

  const CartPage({super.key, required this.cart, required this.checkout});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
        actions: [
          IconButton(
            icon: Icon(themeNotifier.value == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            onPressed: () {
              themeNotifier.value = themeNotifier.value == ThemeMode.light
                  ? ThemeMode.dark
                  : ThemeMode.light;
            },
          ),
        ],
      ),
      body: widget.cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.cart.length,
                    itemBuilder: (context, index) {
                      final book = widget.cart[index];
                      return ListTile(
                        leading: Image.asset(book.coverPath,
                            width: 50, height: 50, fit: BoxFit.cover),
                        title: Text(book.title),
                        subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              widget.cart.removeAt(index);
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: widget.checkout,
                    child: const Text('Checkout'),
                  ),
                ),
              ],
            ),
    );
  }
}

class Book {
  final String title;
  final double price;
  final String coverPath;
  final String description;

  Book(
      {required this.title,
      required this.price,
      required this.coverPath,
      required this.description});
}
