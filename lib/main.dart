import 'package:flutter/material.dart';

                  void main() {
                    runApp(const MyApp());
                  }

                  class MyApp extends StatelessWidget {
                    const MyApp({super.key});

                    @override
                    Widget build(BuildContext context) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        title: 'Book App',
                        theme: ThemeData(
                          primarySwatch: Colors.lightBlue,
                        ),
                        home: const LoginPage(),
                      );
                    }
                  }

                  class Book {
                    final String title;
                    final double price;
                    final String coverPath;
                    final String description;

                    Book({required this.title, required this.price, required this.coverPath, required this.description});
                  }

                  class LoginPage extends StatefulWidget {
                    const LoginPage({super.key});

                    @override
                    State<LoginPage> createState() => LoginPageState();
                  }

                  class LoginPageState extends State<LoginPage> {
                    final TextEditingController _emailController = TextEditingController();
                    final TextEditingController _passwordController = TextEditingController();

                    void _login() {
                      if (_emailController.text == 'arceeluceno@gmail.com' && _passwordController.text == '123123') {
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
                    Widget build(BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(title: const Text('Book App'), centerTitle: true,),
                        body: Center(
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                              decoration: InputDecoration(
                                labelText: 'Email',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            const SizedBox(height: 10),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(),
                              ),
                              obscureText: true,
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _login,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlueAccent,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                              ),
                              child: const Text('Login', style: TextStyle(color: Colors.white)),
                            ),
                              ],
                            ),
                          ),
                        ),
                        backgroundColor: Colors.grey[200],
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
                       title: 'Harry Potter and the Philosopher\'s Stone',
                       price: 20.0,
                       coverPath: 'assets/book1.jpg',
                       description: 'Harry Potter and the Philosopher\'s Stone is an enthralling start to Harry\'s journey toward coming to terms with his past and facing his future. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Chamber of Secrets',
                       price: 25.0,
                       coverPath: 'assets/book2.jpg',
                       description: 'The second instalment of boy wizard Harry Potter\'s adventures at Hogwarts School of Witchcraft and Wizardry, based on the novel by J.K. Rowling. A mysterious elf tells Harry to expect trouble during his second year at Hogwarts, but nothing can prepare him for trees that fight back, flying cars, spiders that talk and deadly warnings written in blood on the walls of the school. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Prisoner of Azkaban',
                       price: 30.0,
                       coverPath: 'assets/book3.jpg',
                       description: 'Harry Potter and the Prisoner of Azkaban follows Harry as he faces the dangerous Sirius Black, who has escaped from Azkaban prison. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Goblet of Fire',
                       price: 15.0,
                       coverPath: 'assets/book4.jpg',
                       description: 'Harry Potter and the Goblet of Fire sees Harry competing in the Triwizard Tournament, facing dragons, mermaids, and other magical challenges. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Order of the Phoenix',
                       price: 40.0,
                       coverPath: 'assets/book5.jpg',
                       description: 'Harry Potter and the Order of the Phoenix follows Harry as he forms "Dumbledore\'s Army" to fight against the dark forces threatening the wizarding world. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Half-Blood Prince',
                       price: 40.0,
                       coverPath: 'assets/book6.jpg',
                       description: 'Harry Potter and the Half-Blood Prince reveals the secrets of Voldemort\'s past and the identity of the mysterious Half-Blood Prince. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Deathly Hallows: Part 1',
                       price: 40.0,
                       coverPath: 'assets/book7.jpg',
                       description: 'Harry Potter and the Deathly Hallows: Part 1 follows Harry, Ron, and Hermione as they search for Voldemort\'s Horcruxes to destroy him. [Source: J.K. Rowling]',
                     ),
                     Book(
                       title: 'Harry Potter and the Deathly Hallows: Part 2',
                       price: 40.0,
                       coverPath: 'assets/book7v2.jpg',
                       description: 'Harry Potter and the Deathly Hallows: Part 2 concludes the epic saga with the final battle between Harry and Voldemort. [Source: J.K. Rowling]',
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
                                    builder: (context) => CartPage(cart: _cart, checkout: _checkout),
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
                            .where((book) => book.title.toLowerCase().contains(query.toLowerCase()))
                            .toList();
                      });
                    }

                    @override
                    Widget build(BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          title: const Text('Home'), centerTitle: true,
                          actions: [
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
                              icon: const Icon(Icons.shopping_cart),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartPage(cart: _cart, checkout: _checkout),
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
                                    leading: Image.asset(book.coverPath, width: 50, height: 50, fit: BoxFit.cover),
                                    title: Text(book.title),
                                    subtitle: Text('\$${book.price.toStringAsFixed(2)}'),
                                    trailing: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            _favorites.contains(book) ? Icons.favorite : Icons.favorite_border,
                                            color: _favorites.contains(book) ? Colors.red : null,
                                          ),
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
                        ),
                        body: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(book.coverPath, width: 100, height: 100, fit: BoxFit.cover),
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
                                    leading: Image.asset(book.coverPath, width: 50, height: 50, fit: BoxFit.cover),
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