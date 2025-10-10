import 'dart:convert';
import 'package:flick_tv_ott/core/error/exeception.dart';
import 'package:flick_tv_ott/data/model/video_model.dart';
import 'package:flutter/services.dart';
import '../../core/constants/app_assets.dart';

abstract class LocalDataSource {
  Future<List<VideoModel>> getVideos();
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<List<VideoModel>> getVideos() async {
    try {
      final jsonString = await rootBundle.loadString(AppAssets.localJson);
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => VideoModel.fromJson(json)).toList();
    } catch (e) {
      throw CacheException();
    }
  }
}