import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:movie_ticket_booking/dependency_injection.dart';
import 'package:movie_ticket_booking/helpers/network_info.dart';
import 'package:movie_ticket_booking/viewmodels/base_model.dart';

class MovieCardViewModel extends BaseModel {
  Future<void> storeImage(String url) async {
    var file = await DefaultCacheManager().downloadFile(url);
    var imageFile = await file.file.readAsBytes();
    await DefaultCacheManager().putFile(url, imageFile);
  }
  ImageProvider<dynamic> image;
  ImageProvider<dynamic> get imageData=>image;
  Future getImage(url) async {
    var networkInfo = AppInversionOfControl.getInstance<NetworkInfo>();
    var data = await DefaultCacheManager().getFileFromCache(url);
    if (await networkInfo.isConnected) {
      image= NetworkImage(url);
      storeImage(url);
    } else {
      var file = data.file;
      var bytes = await file.readAsBytes();
      image= Image.memory(bytes).image;
    }
    onChange();
  }
}
