
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/enums/data_source_enum.dart';
import '../../../common/models/product_model.dart';
import '../../search/domain/services/search_service_interface.dart';
import 'package:http/http.dart' as http;

class SuggestProductsController extends GetxController implements GetxService{
  final SearchServiceInterface searchServiceInterface;
  SuggestProductsController({required this.searchServiceInterface});

  List<Product>? _suggestedFoodList;
  List<Product>? get suggestedFoodList => _suggestedFoodList;

  bool autoPlay = true;



  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  Duration autoPlayDuration = const Duration(seconds: 7);
  
  Future<List<Product>?>nearFood(zoneId)async{
    try{
      final response = await http.get(Uri.parse("https://kanz.nixtzone.com/api/v1/foods/get-nearby-foods"));
      if(response.statusCode==200){
        final List<dynamic> results = jsonDecode(response.body);
        _suggestedFoodList = results.map((e)=>Product.fromJson(e)).toList();
      }
      update();
      return _suggestedFoodList;
    }catch(e){
      throw Exception(e.toString());
    }
  }

  void getSuggestedFoods() async {
    _suggestedFoodList = null;
    _suggestedFoodList = await searchServiceInterface.getSuggestedFoods();
    update();
  }
  Future<void> getAdvertisementList({DataSourceEnum dataSource = DataSourceEnum.local, bool fromRecall = false}) async {
    if(!fromRecall) {
      _suggestedFoodList = null;
    }
    List<Product>? advertisementList;
    if(dataSource == DataSourceEnum.local) {
      advertisementList = await searchServiceInterface.getSuggestedFoods();//await advertisementServiceInterface.getAdvertisementList(source: DataSourceEnum.local);
      _prepareAdvertisement(advertisementList);
      getAdvertisementList(dataSource: DataSourceEnum.client, fromRecall: true);
    } else {
      advertisementList = await searchServiceInterface.getSuggestedFoods();//await advertisementServiceInterface.getAdvertisementList(source: DataSourceEnum.client);
      _prepareAdvertisement(advertisementList);
    }
  }

  _prepareAdvertisement(List<Product>? advertisementList) {
    if (advertisementList != null) {
      _suggestedFoodList = [];
      _suggestedFoodList = advertisementList;
    }
    update();
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  void updateAutoPlayStatus({bool shouldUpdate = false, bool status = false}){
    autoPlay = status;
    if(shouldUpdate){
      update();
    }
  }


}