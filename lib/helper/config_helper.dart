/*
  @2022-12 LoyE
  Provider function save and get config store in device
 */
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Shop {
  String name;
  String password;
  String url;
  String urlTwo;
  String open;
  String close;
  String messageOne;
  String messageTwo;
  String lat;
  String lng;
  String distance;
  String latCustom;
  String lngCustom;
  String distanceCustom;
  bool statusMessageOne;
  bool statusMessageTwo;
  bool allowStatus;
  bool statusMessOne;
  bool statusMessTwo;
  bool pushNotification;
  String day;

  Shop(
      {required this.name,
      required this.password,
      required this.url,
      required this.urlTwo,
      required this.open,
      required this.close,
      required this.messageOne,
      required this.messageTwo,
      required this.lat,
      required this.lng,
      required this.distance,
      required this.latCustom,
      required this.lngCustom,
      required this.distanceCustom,
      required this.statusMessageOne,
      required this.statusMessageTwo,
      this.statusMessOne = true,
      this.statusMessTwo = true,
      this.allowStatus = false,
      this.pushNotification = false,
      required this.day});

  static Map<String, dynamic> toMap(Shop shop) {
    return {
      "name": shop.name,
      "password": shop.password,
      "url": shop.url,
      "urlTwo": shop.urlTwo,
      "open": shop.open,
      "close": shop.close,
      "messageOne": shop.messageOne,
      "messageTwo": shop.messageTwo,
      "lat": shop.lat,
      "lng": shop.lng,
      "distance": shop.distance,
      "latCustom": shop.lat,
      "lngCustom": shop.lng,
      "distanceCustom": shop.distanceCustom,
      "statusMessageOne": shop.statusMessageOne,
      "statusMessageTwo": shop.statusMessageTwo,
      "allowStatus": shop.allowStatus,
      "statusMessOne": shop.statusMessOne,
      "statusMessTwo": shop.statusMessTwo,
      "pushNotification": shop.pushNotification,
      "day": shop.day,
    };
  }

  factory Shop.fromJson(Map<String, dynamic> jsonData) {
    return Shop(
      name: jsonData["name"],
      password: jsonData["password"],
      url: jsonData["url"],
      urlTwo: jsonData["urlTwo"],
      open: jsonData["open"],
      close: jsonData["close"],
      messageOne: jsonData["messageOne"],
      messageTwo: jsonData["messageTwo"],
      lat: jsonData['lat'],
      lng: jsonData['lng'],
      distance: jsonData['distance'],
      latCustom: jsonData['latCustom'],
      lngCustom: jsonData['lngCustom'],
      distanceCustom: jsonData['distanceCustom'],
      statusMessageOne: jsonData['statusMessageOne'],
      statusMessageTwo: jsonData['statusMessageTwo'],
      allowStatus: jsonData['allowStatus'],
      statusMessOne: jsonData['statusMessOne'],
      statusMessTwo: jsonData['statusMessTwo'],
      pushNotification: jsonData["pushNotification"],
      day: jsonData['day'],
    );
  }

  static String encode(List<Shop> shops) => json.encode(
        shops.map<Map<String, dynamic>>((shop) => Shop.toMap(shop)).toList(),
      );

  static List<Shop> decode(String shops) =>
      (json.decode(shops) as List<dynamic>)
          .map<Shop>((item) => Shop.fromJson(item))
          .toList();
}

class Config {
  late SharedPreferences prefs;
  late List<Shop> listShop;

  Future<List<Shop>> init() async {
    prefs = await SharedPreferences.getInstance();
    listShop = [];
    try {
      return await getConfig();
    } on Exception catch (_) {
      return [];
    }
  }

  Future<List<Shop>> getConfig() async {
    try {
      String? jsonData = prefs.getString("listShop");
      if (jsonData == null) {
        return [];
      }
      List<Shop> shops = Shop.decode(jsonData);
      if (shops == []) {
        debugPrint("No Data Found!");
      } else {
        listShop = shops.toSet().toList();
      }
      return listShop;
    } on Exception catch (_) {
      return [];
    }
  }

  Future<bool> updateShop(List<Shop> shops) async {
    String json = Shop.encode(shops);
    await prefs.setString("listShop", json);
    Future.delayed(const Duration(seconds: 1), () async {
      for (var shop in shops) {
        if (shop.pushNotification == true) {
          await FirebaseMessaging.instance.subscribeToTopic(shop.password);
        }
      }
      json = Shop.encode(shops);
      await prefs.setString("listShop", json);
    });
    return true;
  }

  Future<void> updatePushNotification(String pass) async {
    String? jsonData = prefs.getString("listShop");
    List<Shop> shops = Shop.decode(jsonData!);
    if (shops == []) {
      debugPrint("No Data Found!");
    } else {
      listShop = shops.toSet().toList();
      for (var shop in shops) {
        if (shop.password == pass) {
          shop.pushNotification = true;
        }
      }
      updateShop(listShop);
    }
  }

  Future<List<Shop>> removeShop(String pass) async {
    listShop.removeWhere((element) => element.password == pass);
    await FirebaseMessaging.instance.unsubscribeFromTopic(pass);
    String json = Shop.encode(listShop);
    prefs.setString("listShop", json);
    return listShop;
  }
}

Future<void> addShopBan(String pass) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? data = prefs.getStringList("listBan");
  if (data == null) {
    data = [];
    data.add(pass);
  } else {
    data.add(pass);
  }
  await prefs.setStringList("listBan", data.toSet().toList());
}

Future<bool> shopInBan(String pass) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? data = prefs.getStringList("listBan")?.toSet().toList();
  if (data == null) {
    return false;
  }
  for (var ban in data) {
    if (ban == pass) {
      return true;
    }
  }
  return false;
}
