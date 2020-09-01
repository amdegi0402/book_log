import 'package:flutter/material.dart';



class BottomNavigationBarProvider with ChangeNotifier {
  int currentIndex = 0;
  //get currentIndex => _currentIndex;
  void setCurrentIndex(int index) {
    currentIndex = index;

    // View側に変更を通知
    
    notifyListeners();
  }
}



class BottomNaviAuthorBarProvider with ChangeNotifier {
  int currentIndex = 1;
  //get currentIndex => _currentIndex;
  void setCurrentIndex(int index) {
    currentIndex = index;

    // View側に変更を通知
    
    notifyListeners();
  }
}