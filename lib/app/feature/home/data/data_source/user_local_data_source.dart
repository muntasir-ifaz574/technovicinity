import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/user_model.dart';

abstract class UserLocalDataSource {
  Future<List<UserModel>> getUsers();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<List<UserModel>> getUsers() async {
    final jsonString = await rootBundle.loadString('assets/data.json');
    final Map<String, dynamic> data = json.decode(jsonString);
    final usersList = data['users'] as List;
    return usersList.map((json) => UserModel.fromJson(json as Map<String, dynamic>)).toList();
  }
}
