import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(ShoppingApp());
   SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          systemNavigationBarColor:Colors.deepPurpleAccent)
   );
}

class ShoppingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material You Shopping App',
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,

      home: ShoppingScreen(),

    );
  }
}

class ShoppingScreen extends StatefulWidget {
  @override
  _ShoppingScreenState createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  int currentPageIndex = 0; // Track the current page index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
      ),
      body: IndexedStack(
        index: currentPageIndex,
        children: [
          ProductList(),
          Container(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchAnchor(
                  builder: (BuildContext context, SearchController controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                      trailing: <Widget>[
                        const Icon (Icons.mic_none)

                      ],
                    );
                  }, suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                return List<ListTile>.generate(5, (int index) {
                  final String item = 'item $index';
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              }),
            ),

          ),
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text('Page 2'),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text('Page 3'),
          ),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.shopping_cart),
            icon: Icon(Icons.shopping_cart_outlined),

            label: 'Shop',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.saved_search),
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.local_shipping),
            icon: Icon(Icons.local_shipping_outlined),
            label: 'Tracking',

          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        child: const Icon(Icons.add_shopping_cart_outlined),
      ),
      );

  }
}

// Define NavigationBar and NavigationDestination classes here

class ProductList extends StatelessWidget {
  final List<Product> products = [
    Product('Product 1', 'Description 1', 19.99),
    Product('Product 2', 'Description 2', 29.99),
    Product('Product 3', 'Description 3', 9.99),
    Product( 'shoe ','black',20),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;

  Product(this.name, this.description, this.price);
}

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical:8 ),
      elevation: 4,
      child: ListTile(

        title: Text(product.name),
        subtitle: Text(product.description),
        trailing: Text('\$${product.price.toStringAsFixed(2)}'),
      ),
    );
  }
}

// Define NavigationBar and NavigationDestination classes here