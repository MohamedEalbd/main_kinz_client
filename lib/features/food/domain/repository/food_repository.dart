import 'package:stackfood_multivendor/features/food/domain/models/food_model.dart';
import 'package:stackfood_multivendor/features/food/domain/models/food_nearly_model.dart';

abstract class FoodRepository{
  Future<List<FoodsModel>>fetchAllFood();
  Future<List<FoodsNearlyModel>>fetchAllFoodNearMe();
}