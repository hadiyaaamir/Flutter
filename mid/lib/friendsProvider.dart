import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FriendsProvider extends ChangeNotifier {
  List<String> _friends = [
    'HA',
    'HB',
    'CW',
    'WA',
    'FN',
  ];
  List<String> get friends => _friends;

  void addFriend(String initials) {
    friends.add(initials);
    notifyListeners();
  }
}
