import 'package:flutter/material.dart';
import 'package:book_meter/presentation/book_list/book_list_page.dart';

class Drawers extends ChangeNotifier{
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;

     notifyListeners();
  }
 
}