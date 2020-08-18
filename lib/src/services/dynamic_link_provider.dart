import 'package:flutter/material.dart';

class DynamicLinkProvider extends ChangeNotifier {
  String _dynamicLink = '';

  get dynamicLink => this._dynamicLink;

  set dynamicLink (String link){
    this._dynamicLink = link;
    notifyListeners();
  }
}