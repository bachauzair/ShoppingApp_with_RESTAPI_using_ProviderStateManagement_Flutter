import 'dart:convert';


import 'package:http/http.dart' as http;
import '../Models/Products Model.dart';
import '../Repo/Repository.dart';

class GetProducts {

  List<ProductsModel> productsList = [];
  Future<List<ProductsModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(ProductRepo.baseUrl));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode ==200){
      for(Map <String, dynamic> i  in data){
        productsList.add(ProductsModel.fromJson(i));
      }
      return productsList;
    }else {
      return productsList;
    }



  }


}