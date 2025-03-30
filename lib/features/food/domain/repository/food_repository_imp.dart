import 'dart:convert';

import 'package:http/http.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import 'package:stackfood_multivendor/api/api_client.dart';
import '../models/food_model.dart';
import '../models/food_nearly_model.dart';
import 'food_repository.dart';

class FoodRepositoryImp implements FoodRepository{
  final ApiClient apiClient;

  FoodRepositoryImp({required this.apiClient});


  @override
  Future<List<FoodsModel>> fetchAllFood() async{
   List<FoodsModel>foods = [];
     Response response =(await apiClient.getData(AppConstants.getAllFood)) as Response;
     if(response.statusCode ==200){
       foods = [];
       final List<dynamic>result = jsonDecode(response.body);
       foods = result.map((e)=>FoodsModel.fromJson(e)).toList();
     }
   return foods;
  }

  @override
  Future<List<FoodsNearlyModel>> fetchAllFoodNearMe()async {
    List<FoodsNearlyModel>foods = [];
    Response response =(await apiClient.getData(AppConstants.getAllFood)) as Response;
    if(response.statusCode ==200){
    foods = [];
    final List<dynamic>result = jsonDecode(response.body);
    foods = result.map((e)=>FoodsNearlyModel.fromJson(e)).toList();
    }
    return foods;
  }
}