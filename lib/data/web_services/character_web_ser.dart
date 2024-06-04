import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rickandmorty/constants/strings.dart';

class CharacterWebSer {
  late Dio dio;

  CharacterWebSer() {
    BaseOptions options = BaseOptions(
      baseUrl: baseurl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(milliseconds: 30 * 1000),
      receiveTimeout: const Duration(milliseconds: 30 * 1000),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('/character');
      return response.data['results'];
    } catch (e) {
      log(e.toString());
      return [];
    }
  }
}
