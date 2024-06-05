import 'package:get/get.dart';

/*Created By: Tushar Jethva
  Purpose: Below controller is to manage bottom navigation
*/
class BottomNavigationController extends GetxController {
  RxInt _bottomIndex = 0.obs;

  int get bottomIndex => _bottomIndex.value;

  set setBottomIndex(int index) {
    _bottomIndex.value = index;
  }
}
