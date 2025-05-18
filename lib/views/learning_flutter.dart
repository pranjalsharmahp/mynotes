import 'package:flutter/material.dart';

// Main function to run the Flutter application

// Root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Title of the application
      title: 'Flutter Shopping UI',
      // Theme data for the application
      theme: ThemeData(
        // Primary color swatch
        primarySwatch: Colors.indigo,
        // Scaffold background color
        scaffoldBackgroundColor: Colors.grey[100],
        // AppBar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 1,
          iconTheme: IconThemeData(color: Colors.indigo),
          titleTextStyle: TextStyle(
            color: Colors.indigo,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        // Card theme
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: const EdgeInsets.all(8),
        ),
        // ElevatedButton theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            textStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      // Disable the debug banner
      debugShowCheckedModeBanner: false,
      // Home screen of the application
      home: const ShoppingScreen(),
    );
  }
}

// Data class for a Product
class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final String
  imageUrl; // Using a placeholder, in a real app this would be a URL
  final double rating;
  final int reviews;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl, // For simplicity, we'll use icons or colored containers
    this.rating = 0.0,
    this.reviews = 0,
  });
}

// Main shopping screen widget
class ShoppingScreen extends StatefulWidget {
  const ShoppingScreen({super.key});

  @override
  State<ShoppingScreen> createState() => _ShoppingScreenState();
}

class _ShoppingScreenState extends State<ShoppingScreen> {
  // Sample list of products
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Classic White T-Shirt',
      category: 'Apparel',
      price: 25.99,
      imageUrl: 'tshirt',
      rating: 4.5,
      reviews: 120,
    ),
    Product(
      id: '2',
      name: 'Bluetooth Headphones',
      category: 'Electronics',
      price: 89.50,
      imageUrl: 'headphones',
      rating: 4.8,
      reviews: 250,
    ),
    Product(
      id: '3',
      name: 'Modern Coffee Maker',
      category: 'Home Goods',
      price: 120.00,
      imageUrl: 'coffeemaker',
      rating: 4.2,
      reviews: 85,
    ),
    Product(
      id: '4',
      name: 'Running Shoes',
      category: 'Footwear',
      price: 75.00,
      imageUrl: 'shoes',
      rating: 4.6,
      reviews: 180,
    ),
    Product(
      id: '5',
      name: 'Organic Green Tea',
      category: 'Groceries',
      price: 12.99,
      imageUrl: 'tea',
      rating: 4.9,
      reviews: 300,
    ),
    Product(
      id: '6',
      name: 'Leather Wallet',
      category: 'Accessories',
      price: 45.00,
      imageUrl: 'wallet',
      rating: 4.3,
      reviews: 95,
    ),
    Product(
      id: '7',
      name: 'Yoga Mat',
      category: 'Sports',
      price: 30.00,
      imageUrl: 'yogamat',
      rating: 4.7,
      reviews: 150,
    ),
    Product(
      id: '8',
      name: 'Smart Watch',
      category: 'Electronics',
      price: 199.99,
      imageUrl: 'smartwatch',
      rating: 4.4,
      reviews: 220,
    ),
  ];

  // Controller for the search text field
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';
  int _cartItemCount = 0; // Example cart item count

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchTerm = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Filter products based on search term
  List<Product> get _filteredProducts {
    if (_searchTerm.isEmpty) {
      return _products;
    }
    return _products
        .where(
          (product) =>
              product.name.toLowerCase().contains(_searchTerm.toLowerCase()) ||
              product.category.toLowerCase().contains(
                _searchTerm.toLowerCase(),
              ),
        )
        .toList();
  }

  // Function to handle adding a product to cart
  void _addToCart(Product product) {
    setState(() {
      _cartItemCount++;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} added to cart!'),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.green,
      ),
    );
    // In a real app, you would add the product to a cart state management system
    print('Added ${product.name} to cart.');
  }

  // Placeholder for image based on imageUrl string
  Widget _getProductImage(String imageName) {
    IconData iconData;
    Color iconColor = Colors.indigo.shade300;
    switch (imageName) {
      case 'tshirt':
        iconData = Icons.checkroom;
        break;
      case 'headphones':
        iconData = Icons.headphones;
        break;
      case 'coffeemaker':
        iconData = Icons.coffee_maker_outlined;
        break;
      case 'shoes':
        iconData = Icons.directions_run; // Using a generic icon for shoes
        break;
      case 'tea':
        iconData = Icons.emoji_food_beverage_outlined;
        break;
      case 'wallet':
        iconData = Icons.account_balance_wallet_outlined;
        break;
      case 'yogamat':
        iconData = Icons.spa_outlined; // Representing yoga/sports
        break;
      case 'smartwatch':
        iconData = Icons.watch_outlined;
        break;
      default:
        iconData = Icons.inventory_2_outlined; // Default placeholder
        iconColor = Colors.grey.shade400;
    }
    return Container(
      height: 120, // Fixed height for the image container
      width: double.infinity,
      decoration: BoxDecoration(
        color: iconColor.withOpacity(0.1), // Light background for the icon
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Icon(iconData, size: 60, color: iconColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for the screen
      appBar: AppBar(
        title: const Text('ShopSphere'),
        centerTitle: true,
        actions: [
          // Cart icon with badge
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart_outlined, size: 28),
                  onPressed: () {
                    // Navigate to cart screen or show cart details
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Cart tapped! Implement navigation.'),
                      ),
                    );
                  },
                ),
                if (_cartItemCount > 0)
                  Positioned(
                    top: 8,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      child: Text(
                        '$_cartItemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      // Body of the screen
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none, // No border for a cleaner look
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1.5,
                  ),
                ),
                suffixIcon:
                    _searchTerm.isNotEmpty
                        ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                        : null,
              ),
            ),
          ),
          // Product Grid
          Expanded(
            child:
                _filteredProducts.isEmpty
                    ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 60,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No products found for "$_searchTerm"',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                    : GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      // Grid delegate for two columns with aspect ratio
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Number of columns
                            childAspectRatio:
                                0.65, // Aspect ratio of items (width / height)
                            crossAxisSpacing: 8, // Horizontal spacing
                            mainAxisSpacing: 8, // Vertical spacing
                          ),
                      itemCount: _filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = _filteredProducts[index];
                        return ProductCard(
                          product: product,
                          onAddToCart: () => _addToCart(product),
                          imageWidget: _getProductImage(product.imageUrl),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}

// Widget for displaying a single product card
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;
  final Widget imageWidget; // Pass the image widget directly

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
    required this.imageWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior:
          Clip.antiAlias, // Ensures content respects card's rounded corners
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.stretch, // Make children stretch horizontally
        children: [
          // Product Image Placeholder
          imageWidget, // Use the passed image widget
          // Product Details
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Category (Small text)
                Text(
                  product.category.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // Product Name
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  maxLines: 2, // Allow up to two lines for product name
                  overflow:
                      TextOverflow
                          .ellipsis, // Show ellipsis if name is too long
                ),
                const SizedBox(height: 6),
                // Product Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber[600], size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${product.rating} (${product.reviews})',
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Spacer to push price and button to the bottom if content is less
          const Spacer(),
          // Product Price and Add to Cart Button
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}', // Format price to 2 decimal places
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
                // Add to Cart Button
                SizedBox(
                  width:
                      double
                          .infinity, // Make button take full width of its parent
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    icon: const Icon(Icons.add_shopping_cart, size: 18),
                    label: const Text('Add to Cart'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
