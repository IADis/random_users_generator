import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:random_users_generator/repositories/user_model/users_model.dart';

class UsersRepository {
  UsersRepository({required this.dio});
  final Dio dio;

  Future<UsersModel> getRandomUsers({String? mode}) async {
    final response = await dio.get('api/', queryParameters: {
      'gender': mode,
    });
    debugPrint(response.toString());
    return UsersModel.fromJson(response.data);
  }
}
