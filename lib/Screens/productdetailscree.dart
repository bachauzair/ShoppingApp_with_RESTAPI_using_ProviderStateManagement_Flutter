import 'package:flutter/material.dart';
import 'package:practice_two/Provider/Cart%20Provider.dart';
import 'package:provider/provider.dart';

import '../Models/Cart Item.dart';
import '../Models/products.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;

  const ProductDetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String btnText = 'Add to Cart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Detail'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 300,
                  width: 600,
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.cover,

                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.product.title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Price: \$${widget.product.price}',
                style: TextStyle(fontSize: 18, color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                widget.product.description,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 60),
              Center(
                  child: InkWell(
                    onTap: (){
                      CartProvider cartProvider = Provider.of<CartProvider>(context, listen: false);
                      cartProvider.addToCart(CartItem(
                        title: widget.product.title,
                        price: widget.product.price,
                        image: widget.product.image,

                        description: widget.product.description,
                        category: widget.product.category,));
                      setState(() {
                        btnText = 'Added to cart';

                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: Colors.black, // Border color
                              width: 1, // Border width
                            ),

                          ),
                          child: Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const Icon(Icons.add_shopping_cart_outlined),
                              Text(btnText, style: const TextStyle(color: Colors.black,),),
                            ],
                          )),
                        ),
                        Container(
                          height: 60,
                          width: 140,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(18),


                          ),
                          child: const Center(child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(Icons.shop_outlined, color: Colors.white,),
                              Text('Buy Now', style: TextStyle(color: Colors.white,),),
                            ],
                          )),
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),

        ),
      ),
    );
  }
}
