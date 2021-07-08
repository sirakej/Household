import 'category-class.dart';

class PopularCategory {

  PopularCategory({
    this.category,
    this.count,
  });

  CategoryClass category;
  int count;

  factory PopularCategory.fromJson(Map<String, dynamic> json) => PopularCategory(
    category: CategoryClass.fromJson(json["category"]),
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "category": category.toJson(),
    "count": count,
  };
}

