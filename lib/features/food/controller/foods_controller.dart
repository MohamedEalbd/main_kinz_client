
import 'package:get/get.dart';
import 'package:stackfood_multivendor/util/app_constants.dart';
import '../../../api/api_client.dart';
import '../domain/repository/food_repository.dart';
import '../domain/models/food_model.dart';
class FoodsController extends GetxController implements GetxService{
  final FoodRepository foodRepository;
  final ApiClient apiClient;
  late  List<FoodsModel> foods=[];

  FoodsController( {required this.foodRepository,required this.apiClient});
  Future<List<FoodsModel>> fetchAllFood()async{
    Response response = await apiClient.getData(AppConstants.getAllFood);
    if(response.statusCode ==200 ){
      // Logger().d("response ==============>${response.statusCode}");
      response.body.forEach((e){
        foods.add(FoodsModel.fromJson(e));
      });
      // Logger().d("result ==============>$foods");
      // Logger().d("Foods ==============>success");
    }
    update();
    return foods;
  }

  num getDiscount(FoodsModel food) =>
      food.discount ?? 0.0;

  String? getDiscountType(FoodsModel food) => food.discount != null
      ? food.discountType
      : 'percent';

  init()async{
    await fetchAllFood();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    init();
  }
}