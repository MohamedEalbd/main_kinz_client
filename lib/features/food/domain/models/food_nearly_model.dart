class FoodsNearlyModel {
  FoodsNearlyModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.categoryId,
    required this.categoryIds,
    required this.variations,
    required this.addOns,
    required this.attributes,
    required this.choiceOptions,
    required this.price,
    required this.tax,
    required this.taxType,
    required this.discount,
    required this.discountType,
    required this.availableTimeStarts,
    required this.availableTimeEnds,
    required this.veg,
    required this.status,
    required this.restaurantId,
    required this.createdAt,
    required this.updatedAt,
    required this.orderCount,
    required this.avgRating,
    required this.ratingCount,
    required this.recommended,
    required this.slug,
    required this.maximumCartQuantity,
    required this.isHalal,
    required this.itemStock,
    required this.sellCount,
    required this.stockType,
    required this.availableIn,
    required this.tags,
    required this.restaurantName,
    required this.restaurantAddress,
    required this.restaurantImage,
    required this.restaurantStatus,
    required this.restaurantDiscount,
    required this.restaurantOpeningTime,
    required this.restaurantClosingTime,
    required this.scheduleOrder,
    required this.minDeliveryTime,
    required this.maxDeliveryTime,
    required this.freeDelivery,
    required this.halalTagStatus,
    required this.nutritionsName,
    required this.allergiesName,
    required this.cuisines,
    required this.imageFullUrl,
    required this.translations,
    required this.newVariations,
    required this.nutritions,
    required this.allergies,
    required this.storage,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? image;
  final int? categoryId;
  final List<CategoryId> categoryIds;
  final List<dynamic> variations;
  final List<AddOn> addOns;
  final String? attributes;
  final String? choiceOptions;
  final int? price;
  final int? tax;
  final String? taxType;
  final int? discount;
  final String? discountType;
  final String? availableTimeStarts;
  final String? availableTimeEnds;
  final int? veg;
  final int? status;
  final int? restaurantId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? orderCount;
  final int? avgRating;
  final int? ratingCount;
  final int? recommended;
  final String? slug;
  final int? maximumCartQuantity;
  final int? isHalal;
  final int? itemStock;
  final int? sellCount;
  final String? stockType;
  final int? availableIn;
  final List<Tag> tags;
  final String? restaurantName;
  final String? restaurantAddress;
  final String? restaurantImage;
  final int? restaurantStatus;
  final int? restaurantDiscount;
  final String? restaurantOpeningTime;
  final String? restaurantClosingTime;
  final bool? scheduleOrder;
  final int? minDeliveryTime;
  final int? maxDeliveryTime;
  final int? freeDelivery;
  final int? halalTagStatus;
  final List<String> nutritionsName;
  final List<dynamic> allergiesName;
  final List<Cuisine> cuisines;
  final String? imageFullUrl;
  final List<Translation> translations;
  final List<dynamic> newVariations;
  final List<Nutrition> nutritions;
  final List<dynamic> allergies;
  final List<Storage> storage;

  factory FoodsNearlyModel.fromJson(Map<String, dynamic> json){
    return FoodsNearlyModel(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      image: json["image"],
      categoryId: json["category_id"],
      categoryIds: json["category_ids"] == null ? [] : List<CategoryId>.from(json["category_ids"]!.map((x) => CategoryId.fromJson(x))),
      variations: json["variations"] == null ? [] : List<dynamic>.from(json["variations"]!.map((x) => x)),
      addOns: json["add_ons"] == null ? [] : List<AddOn>.from(json["add_ons"]!.map((x) => AddOn.fromJson(x))),
      attributes: json["attributes"],
      choiceOptions: json["choice_options"],
      price: json["price"],
      tax: json["tax"],
      taxType: json["tax_type"],
      discount: json["discount"],
      discountType: json["discount_type"],
      availableTimeStarts: json["available_time_starts"],
      availableTimeEnds: json["available_time_ends"],
      veg: json["veg"],
      status: json["status"],
      restaurantId: json["restaurant_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      orderCount: json["order_count"],
      avgRating: json["avg_rating"],
      ratingCount: json["rating_count"],
      recommended: json["recommended"],
      slug: json["slug"],
      maximumCartQuantity: json["maximum_cart_quantity"],
      isHalal: json["is_halal"],
      itemStock: json["item_stock"],
      sellCount: json["sell_count"],
      stockType: json["stock_type"],
      availableIn: json["available_in"],
      tags: json["tags"] == null ? [] : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      restaurantName: json["restaurant_name"],
      restaurantAddress: json["restaurant_address"],
      restaurantImage: json["restaurant_image"],
      restaurantStatus: json["restaurant_status"],
      restaurantDiscount: json["restaurant_discount"],
      restaurantOpeningTime: json["restaurant_opening_time"],
      restaurantClosingTime: json["restaurant_closing_time"],
      scheduleOrder: json["schedule_order"],
      minDeliveryTime: json["min_delivery_time"],
      maxDeliveryTime: json["max_delivery_time"],
      freeDelivery: json["free_delivery"],
      halalTagStatus: json["halal_tag_status"],
      nutritionsName: json["nutritions_name"] == null ? [] : List<String>.from(json["nutritions_name"]!.map((x) => x)),
      allergiesName: json["allergies_name"] == null ? [] : List<dynamic>.from(json["allergies_name"]!.map((x) => x)),
      cuisines: json["cuisines"] == null ? [] : List<Cuisine>.from(json["cuisines"]!.map((x) => Cuisine.fromJson(x))),
      imageFullUrl: json["image_full_url"],
      translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
      newVariations: json["new_variations"] == null ? [] : List<dynamic>.from(json["new_variations"]!.map((x) => x)),
      nutritions: json["nutritions"] == null ? [] : List<Nutrition>.from(json["nutritions"]!.map((x) => Nutrition.fromJson(x))),
      allergies: json["allergies"] == null ? [] : List<dynamic>.from(json["allergies"]!.map((x) => x)),
      storage: json["storage"] == null ? [] : List<Storage>.from(json["storage"]!.map((x) => Storage.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "image": image,
    "category_id": categoryId,
    "category_ids": categoryIds.map((x) => x?.toJson()).toList(),
    "variations": variations.map((x) => x).toList(),
    "add_ons": addOns.map((x) => x?.toJson()).toList(),
    "attributes": attributes,
    "choice_options": choiceOptions,
    "price": price,
    "tax": tax,
    "tax_type": taxType,
    "discount": discount,
    "discount_type": discountType,
    "available_time_starts": availableTimeStarts,
    "available_time_ends": availableTimeEnds,
    "veg": veg,
    "status": status,
    "restaurant_id": restaurantId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "order_count": orderCount,
    "avg_rating": avgRating,
    "rating_count": ratingCount,
    "recommended": recommended,
    "slug": slug,
    "maximum_cart_quantity": maximumCartQuantity,
    "is_halal": isHalal,
    "item_stock": itemStock,
    "sell_count": sellCount,
    "stock_type": stockType,
    "available_in": availableIn,
    "tags": tags.map((x) => x?.toJson()).toList(),
    "restaurant_name": restaurantName,
    "restaurant_address": restaurantAddress,
    "restaurant_image": restaurantImage,
    "restaurant_status": restaurantStatus,
    "restaurant_discount": restaurantDiscount,
    "restaurant_opening_time": restaurantOpeningTime,
    "restaurant_closing_time": restaurantClosingTime,
    "schedule_order": scheduleOrder,
    "min_delivery_time": minDeliveryTime,
    "max_delivery_time": maxDeliveryTime,
    "free_delivery": freeDelivery,
    "halal_tag_status": halalTagStatus,
    "nutritions_name": nutritionsName.map((x) => x).toList(),
    "allergies_name": allergiesName.map((x) => x).toList(),
    "cuisines": cuisines.map((x) => x?.toJson()).toList(),
    "image_full_url": imageFullUrl,
    "translations": translations.map((x) => x?.toJson()).toList(),
    "new_variations": newVariations.map((x) => x).toList(),
    "nutritions": nutritions.map((x) => x?.toJson()).toList(),
    "allergies": allergies.map((x) => x).toList(),
    "storage": storage.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $description, $image, $categoryId, $categoryIds, $variations, $addOns, $attributes, $choiceOptions, $price, $tax, $taxType, $discount, $discountType, $availableTimeStarts, $availableTimeEnds, $veg, $status, $restaurantId, $createdAt, $updatedAt, $orderCount, $avgRating, $ratingCount, $recommended, $slug, $maximumCartQuantity, $isHalal, $itemStock, $sellCount, $stockType, $availableIn, $tags, $restaurantName, $restaurantAddress, $restaurantImage, $restaurantStatus, $restaurantDiscount, $restaurantOpeningTime, $restaurantClosingTime, $scheduleOrder, $minDeliveryTime, $maxDeliveryTime, $freeDelivery, $halalTagStatus, $nutritionsName, $allergiesName, $cuisines, $imageFullUrl, $translations, $newVariations, $nutritions, $allergies, $storage, ";
  }
}

class AddOn {
  AddOn({
    required this.id,
    required this.name,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.restaurantId,
    required this.status,
    required this.stockType,
    required this.addonStock,
    required this.sellCount,
    required this.translations,
  });

  final int? id;
  final String? name;
  final int? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? restaurantId;
  final int? status;
  final String? stockType;
  final int? addonStock;
  final int? sellCount;
  final List<Translation> translations;

  factory AddOn.fromJson(Map<String, dynamic> json){
    return AddOn(
      id: json["id"],
      name: json["name"],
      price: json["price"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      restaurantId: json["restaurant_id"],
      status: json["status"],
      stockType: json["stock_type"],
      addonStock: json["addon_stock"],
      sellCount: json["sell_count"],
      translations: json["translations"] == null ? [] : List<Translation>.from(json["translations"]!.map((x) => Translation.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "restaurant_id": restaurantId,
    "status": status,
    "stock_type": stockType,
    "addon_stock": addonStock,
    "sell_count": sellCount,
    "translations": translations.map((x) => x?.toJson()).toList(),
  };

  @override
  String toString(){
    return "$id, $name, $price, $createdAt, $updatedAt, $restaurantId, $status, $stockType, $addonStock, $sellCount, $translations, ";
  }
}

class Translation {
  Translation({
    required this.id,
    required this.translationableType,
    required this.translationableId,
    required this.locale,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? translationableType;
  final int? translationableId;
  final String? locale;
  final String? key;
  final String? value;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Translation.fromJson(Map<String, dynamic> json){
    return Translation(
      id: json["id"],
      translationableType: json["translationable_type"],
      translationableId: json["translationable_id"],
      locale: json["locale"],
      key: json["key"],
      value: json["value"],
      createdAt: json["created_at"],
      updatedAt: json["updated_at"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "translationable_type": translationableType,
    "translationable_id": translationableId,
    "locale": locale,
    "key": key,
    "value": value,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };

  @override
  String toString(){
    return "$id, $translationableType, $translationableId, $locale, $key, $value, $createdAt, $updatedAt, ";
  }
}

class CategoryId {
  CategoryId({
    required this.id,
    required this.position,
  });

  final String? id;
  final int? position;

  factory CategoryId.fromJson(Map<String, dynamic> json){
    return CategoryId(
      id: json["id"],
      position: json["position"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "position": position,
  };

  @override
  String toString(){
    return "$id, $position, ";
  }
}

class Cuisine {
  Cuisine({
    required this.id,
    required this.name,
    required this.image,
  });

  final int? id;
  final String? name;
  final String? image;

  factory Cuisine.fromJson(Map<String, dynamic> json){
    return Cuisine(
      id: json["id"],
      name: json["name"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };

  @override
  String toString(){
    return "$id, $name, $image, ";
  }
}

class Nutrition {
  Nutrition({
    required this.id,
    required this.nutrition,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? nutrition;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final NutritionPivot? pivot;

  factory Nutrition.fromJson(Map<String, dynamic> json){
    return Nutrition(
      id: json["id"],
      nutrition: json["nutrition"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : NutritionPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "nutrition": nutrition,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };

  @override
  String toString(){
    return "$id, $nutrition, $createdAt, $updatedAt, $pivot, ";
  }
}

class NutritionPivot {
  NutritionPivot({
    required this.foodId,
    required this.nutritionId,
  });

  final int? foodId;
  final int? nutritionId;

  factory NutritionPivot.fromJson(Map<String, dynamic> json){
    return NutritionPivot(
      foodId: json["food_id"],
      nutritionId: json["nutrition_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "food_id": foodId,
    "nutrition_id": nutritionId,
  };

  @override
  String toString(){
    return "$foodId, $nutritionId, ";
  }
}

class Storage {
  Storage({
    required this.id,
    required this.dataType,
    required this.dataId,
    required this.key,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  final int? id;
  final String? dataType;
  final String? dataId;
  final String? key;
  final String? value;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Storage.fromJson(Map<String, dynamic> json){
    return Storage(
      id: json["id"],
      dataType: json["data_type"],
      dataId: json["data_id"],
      key: json["key"],
      value: json["value"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "data_type": dataType,
    "data_id": dataId,
    "key": key,
    "value": value,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };

  @override
  String toString(){
    return "$id, $dataType, $dataId, $key, $value, $createdAt, $updatedAt, ";
  }
}

class Tag {
  Tag({
    required this.id,
    required this.tag,
    required this.createdAt,
    required this.updatedAt,
    required this.pivot,
  });

  final int? id;
  final String? tag;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final TagPivot? pivot;

  factory Tag.fromJson(Map<String, dynamic> json){
    return Tag(
      id: json["id"],
      tag: json["tag"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      updatedAt: DateTime.tryParse(json["updated_at"] ?? ""),
      pivot: json["pivot"] == null ? null : TagPivot.fromJson(json["pivot"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "tag": tag,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };

  @override
  String toString(){
    return "$id, $tag, $createdAt, $updatedAt, $pivot, ";
  }
}

class TagPivot {
  TagPivot({
    required this.foodId,
    required this.tagId,
  });

  final int? foodId;
  final int? tagId;

  factory TagPivot.fromJson(Map<String, dynamic> json){
    return TagPivot(
      foodId: json["food_id"],
      tagId: json["tag_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "food_id": foodId,
    "tag_id": tagId,
  };

  @override
  String toString(){
    return "$foodId, $tagId, ";
  }
}
