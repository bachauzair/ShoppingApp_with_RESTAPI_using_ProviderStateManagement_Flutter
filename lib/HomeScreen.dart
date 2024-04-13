
import 'package:badges/badges.dart' as custom_badge;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practice_two/productdetailscree.dart';
import 'package:practice_two/products.dart';
import 'package:provider/provider.dart';

import 'Cart Item.dart';

import 'Cart Screen.dart';
import 'Get Product APi.dart';
import 'Provider/Cart Provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GetProducts getProducts;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProducts = GetProducts();
    getProducts.fetchProducts(); // Call fetchProducts here
  }

  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(

          title: Text(
            'Shop Now',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            custom_badge.Badge(
              position: custom_badge.BadgePosition.topEnd(top: -10, end: -12),
              showBadge: true,
              badgeContent: Text(
                '${Provider.of<CartProvider>(context).items.length}',
                style: TextStyle(color: Colors.white),
              ),
              badgeStyle: custom_badge.BadgeStyle(
                shape: custom_badge.BadgeShape.circle,
                badgeColor: Colors.red, // Customize badge color as needed
              ),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CartScreen()),
                  );
                },
                icon: Icon(Icons.shopping_cart, color: Colors.black),
              ),
            ),
            SizedBox(width: 20)
          ],
        ),


        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                controller: _searchController,
                onChanged: (_) {
                  setState(() {}); // Trigger rebuild to apply filter
                },
                decoration: InputDecoration(
                  hintText: 'Search Product',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder( // You can also use FilledTextFieldBorder for a filled look
                    borderSide: BorderSide(color: Colors.transparent), // Transparent border color
                    borderRadius: BorderRadius.circular(20.0), // Adjust border radius as needed
                  ),
                  filled: true,
                  fillColor: Colors.grey[200], // Background color
                  contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // Adjust padding as needed
                  focusedBorder: OutlineInputBorder( // Border when focused
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  enabledBorder: OutlineInputBorder( // Border when not focused
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  errorBorder: OutlineInputBorder( // Border on error (optional)
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder( // Border on error when focused (optional)
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  // Customize other properties such as hintTextStyle, prefixStyle, etc., for better appearance
                ),
              ),

            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder(
                future: getProducts.fetchProducts(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    // Data is available, display it
                    return SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: getProducts.productsList.length,
                          itemBuilder: (context, index) {
                            final product = getProducts.productsList[index];
                            // Check if the product matches the search query
                            if (_searchController.text.isNotEmpty &&
                                !product.title!
                                    .toLowerCase()
                                    .contains(_searchController.text.toLowerCase())) {
                              return SizedBox.shrink(); // Hide if not matched
                            }
                            return GestureDetector(
                              onTap: () {
                                // Convert ProductsModel to Product
                                String productId = getProducts.productsList[index].id.toString();
                                Product product = Product(
                                    id: productId,
                                    title: getProducts.productsList[index].title!,
                                    price: getProducts.productsList[index].price!.toDouble(),
                                    image: getProducts.productsList[index].image!,
                                    description: getProducts.productsList[index].description!,
                                    rating: getProducts.productsList[index].rating!.rate!,
                                  category: getProducts.productsList[index].category!,
                                );

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(product: product),
                                  ),
                                );
                              },
                              child: Container(
                                height: 250,
                                width: 150,
                                decoration: BoxDecoration(

                                ),
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Flexible(

                                        child: Image.network(product.image!, height: 120, width: 80,)),

                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        product.title!,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('Price: \$${product.price}',),
                                        SizedBox(width: 20,),
                                        Container(
                                          height: 20,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.deepOrange,
                                              borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: Center(
                                            child: Text(
                                              '${product.rating!.rate}', style: TextStyle(color: Colors.white), ),
                                          ),
                                        )


                                      ],
                                    )

                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

}
