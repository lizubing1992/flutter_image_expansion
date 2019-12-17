import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_image_expansion/image_expansion_bean.dart';

class FlutterImageExpansion {
  static const MethodChannel _channel =
      const MethodChannel('flutter_image_expansion');

  /// 图片质量
  /// quality 范围: [0,1]
  static Future<ImageExpansionBean> imageQuality(
      String imagePath, double quality) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "quality": quality,
      "imagePath": imagePath
    };
    final res = await _channel.invokeMethod('imageQuality', params);
    return ImageExpansionBean.fromMap(res);
  }

  /// 图片质量
  /// quality 范围: [0,1]
  static Future<ImageExpansionBean> imageZoom(
      {Uint8List imageData, double quality, double maxLength,String imagePath}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "quality": quality,
      "imageData": imageData,
      "maxLength": maxLength,
      "imagePath": imagePath
    };
    final res = await _channel.invokeMethod('imageZoom', params);
    return ImageExpansionBean.fromMap(res);
  }

  ///获取图片经度，
  ///如果图片没有经度信息，返回的是“”空字符串
  ///imagePath：图片的绝对路径
  static Future<String> getImageLongitude(String imagePath) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "imagePath": imagePath
    };
    final String longitude =
        await _channel.invokeMethod('getImageLongitude', params);
    return longitude;
  }

  ///获取图片纬度
  ///如果图片没有纬度信息，返回的是“”空字符串
  ///imagePath：图片的绝对路径
  static Future<String> getImageLatitude(String imagePath) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "imagePath": imagePath
    };
    final String latitude =
        await _channel.invokeMethod('getImageLatitude', params);
    return latitude;
  }

  ///获取图片拍照时间
  ///如果没有返回的是“”空字符串
  ///imagePath：图片的绝对路径
  static Future<String> getImagePhotoTime(String imagePath) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "imagePath": imagePath
    };

    final String latitude =
        await _channel.invokeMethod('getImagePhotoTime', params);
    return latitude;
  }

  ///获取图片所有的信息
  ///如果没有返回的是{}空表
  ///imagePath：图片的绝对路径
  static Future<Map<String, dynamic>> getImageAllInfo(String imagePath) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "imagePath": imagePath
    };
    var fromRes = await _channel.invokeMethod('getImageAllInfo', params);
    return transferOCRData(fromRes);
  }

  ///保存信息到图片
  static Future<bool> saveImageInfo(
      {String imagePath, Map<String, dynamic> map}) async {
    final Map<String, dynamic> params = <String, dynamic>{
      "imagePath": imagePath
    };
    if (map != null) {
      params["map"] = map;
    }
    bool res = await _channel.invokeMethod('saveImageInfo', params);
    return res;
  }

  ///数据转化
  static Future<Map<String, dynamic>> transferOCRData(
      Map<Object, Object> fromRes) async {
    if (fromRes != null) {
      final Map<String, Object> toMap = <String, Object>{};
      for (String key in fromRes.keys) {
        toMap[key] = fromRes[key];
      }
      return toMap;
    } else {
      return fromRes;
    }
  }
}
