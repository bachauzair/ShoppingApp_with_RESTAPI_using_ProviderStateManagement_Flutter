import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Cart Item.dart';
import 'Provider/Cart Provider.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final List<CartItem> cartItems = cartProvider.items;

          // Calculate the total price
          double totalPrice = cartItems.fold(0, (previousValue, cartItem) {
            return previousValue + (cartItem.price * cartItem.quantity);
          });

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final CartItem cartItem = cartItems[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.network(cartItem.image, height: 80, width: 80),
                              const SizedBox(width: 10),
                              // Wrap the Text widget in Flexible with overflow handling
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItem.title,
                                      overflow: TextOverflow.ellipsis, // Handle overflow
                                      maxLines: 2, // Maximum lines to display
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      cartItem.category,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '\$${cartItem.price}',
                                          style: const TextStyle(
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              cartProvider.removeFromCart(cartItem);
                                            },
                                            child: const Icon(Icons.delete_forever)),
                                        Container(
                                          height: 40,
                                          width: 120,
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.circular(8)
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              IconButton(
                                                icon: const Icon(Icons.remove, color: Colors.white),
                                                onPressed: () {
                                                  if (cartItem.quantity > 1) {
                                                    // Decrease quantity by 1
                                                    cartProvider.updateQuantity(index, cartItem.quantity - 1);
                                                  }
                                                },
                                              ),
                                              Text('${cartItem.quantity}', style: const TextStyle(color: Colors.white)),
                                              IconButton(
                                                icon: const Icon(Icons.add, color: Colors.white),
                                                onPressed: () {
                                                  // Increase quantity by 1
                                                  cartProvider.updateQuantity(index, cartItem.quantity + 1);
                                                },
                                              ),
                                            ],
                                          ),

                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Display total price
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total: \$${totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const Row(
                      children: [
                        Text('Checkout', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        SizedBox(width: 7,),

                        Icon(Icons.shop, color: Colors.red,size: 30,)
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
