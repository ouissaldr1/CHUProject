import 'package:flutter/cupertino.dart';

import '../constants.dart';

class FavoriteModel extends ChangeNotifier{
  int _count=0;
  List<Information> items=[];
  void addCount(){
    _count++;
    notifyListeners();
  }
   void addItems(Information data){
    items.add(data);
    notifyListeners();
  }
  int get count {
    return _count;
  }
  List<Information> get itemsList{
    return items;
  }
}