import 'package:flutter/material.dart';


import '../Models/Cart Item.dart';


class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();

 
  }

  void updateQuantity(int index, int newQuantity) {
    // Ensure index is within the bounds of the items list
    if (index >= 0 && index < _items.length) {
      // Update the quantity of the item at the specified index
      _items[index].quantity = newQuantity;
      // Notify listeners that the data has changed
      notifyListeners();


  }

}}
