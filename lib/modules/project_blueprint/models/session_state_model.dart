import 'package:get/get.dart';

class SessionStateModel {
  final int id;
  final String text;
  final String imagePath;

  SessionStateModel(this.id, this.text, this.imagePath);
}

final List<SessionStateModel> sessionStates = [
  SessionStateModel(0 , "place_the_phone_parallel_to_the_wall".tr, "assets/icons/ic_place_phone.svg"),
  SessionStateModel(1 , "select_the_2_lower_corners_of_the_plane".tr, "assets/icons/ic_select_points.svg"),
  SessionStateModel(2 , "move_the_phone_vertically_to_determine_the_height".tr, "assets/icons/ic_select_height.svg"),
  SessionStateModel(3 , "successfully".tr, "assets/icons/ic_successful.svg"),
];