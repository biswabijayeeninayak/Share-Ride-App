class UserModel{
  String? userName;
  int? totalRide;
  int? totalPoint;
  UserLevelModel? userLevelModel;


  UserModel({this.userName, this.totalRide, this.totalPoint,this.userLevelModel});

}


class UserLevelModel{
  String? currentLevel;
  String? nextLevel;
  int? targetPoint;
  int? earnedPoint;

  UserLevelModel({this.currentLevel, this.nextLevel, this.targetPoint, this.earnedPoint});

}