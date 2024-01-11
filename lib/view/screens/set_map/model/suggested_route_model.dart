class SuggestedRouteModel{
  String? title;
  String? route1;
  String? route2;
  double? distance;
  int? requiredTime;
  String? volume;

  SuggestedRouteModel(
      {this.title, this.route1, this.route2, this.distance, this.requiredTime, required this.volume});
}