/*
  @2022-12 LoyE
  Provider function get data config from server
 */
import 'dart:convert' as convert;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import './config_helper.dart';

Future<Map> getData(String pass) async {
  print("update List");
  Config config = Config();
  config.init();
  var url = Uri.https('admin.on-sale.co.za', '/on_sale_locator/get_shop',
      {'list_shop_id': pass});
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<Shop> listShop = [];
    List<Shop> oldList = await config.getConfig();
    var jsonResponse = convert.jsonDecode(response.body);
    print(jsonResponse);

    for (var shop in jsonResponse) {

      bool status = await shopInBan(shop["fields"]["password"].toString());
      if (status == false) {
        Shop newShop = Shop(
            name: shop["fields"]["name"],
            url: shop["fields"]["url"],
            urlTwo: shop["fields"]["url_two"],
            password: shop["fields"]["password"].toString(),
            open: shop["fields"]["open_hour"].toString(),
            close: shop["fields"]["close_hour"].toString(),
            messageOne: shop["fields"]["message"],
            messageTwo: shop["fields"]["message_two"],
            lat: shop["fields"]["lat"].toString(),
            lng: shop["fields"]["lng"].toString(),
            distance: shop["fields"]["distance"].toString(),
            latCustom: shop["fields"]["lat_custom"].toString(),
            lngCustom: shop["fields"]["lng_custom"].toString(),
            distanceCustom: shop["fields"]["distance_custom"].toString(),
            statusMessageOne: shop["fields"]["enable"],
            statusMessageTwo: shop["fields"]["enable_custom"],
            day: DateTime.now().day.toString());
        if (oldList.isEmpty) {
          newShop = Shop(
              name: shop["fields"]["name"],
              url: shop["fields"]["url"],
              urlTwo: shop["fields"]["url_two"],
              password: shop["fields"]["password"].toString(),
              open: shop["fields"]["open_hour"].toString(),
              close: shop["fields"]["close_hour"].toString(),
              messageOne: shop["fields"]["message"],
              messageTwo: shop["fields"]["message_two"],
              lat: shop["fields"]["lat"].toString(),
              lng: shop["fields"]["lng"].toString(),
              distance: shop["fields"]["distance"].toString(),
              latCustom: shop["fields"]["lat_custom"].toString(),
              lngCustom: shop["fields"]["lng_custom"].toString(),
              distanceCustom: shop["fields"]["distance_custom"].toString(),
              statusMessageOne: shop["fields"]["enable"],
              statusMessageTwo: shop["fields"]["enable_custom"],
              day: DateTime.now().day.toString());
        } else {
          for (var item in oldList) {
            if (item.password == shop["fields"]["password"].toString()) {
              newShop = Shop(
                  name: shop["fields"]["name"],
                  url: shop["fields"]["url"],
                  urlTwo: shop["fields"]["url_two"],
                  password: shop["fields"]["password"].toString(),
                  open: shop["fields"]["open_hour"].toString(),
                  close: shop["fields"]["close_hour"].toString(),
                  messageOne: shop["fields"]["message"],
                  messageTwo: shop["fields"]["message_two"],
                  lat: shop["fields"]["lat"].toString(),
                  lng: shop["fields"]["lng"].toString(),
                  distance: shop["fields"]["distance"].toString(),
                  latCustom: shop["fields"]["lat_custom"].toString(),
                  lngCustom: shop["fields"]["lng_custom"].toString(),
                  distanceCustom: shop["fields"]["distance_custom"].toString(),
                  statusMessageOne: shop["fields"]["enable"],
                  statusMessageTwo: shop["fields"]["enable_custom"],
                  allowStatus: item.allowStatus,
                  statusMessOne: item.statusMessOne,
                  statusMessTwo: item.statusMessTwo,
                  pushNotification: item.pushNotification,
                  day: DateTime.now().day.toString());
            }
          }
        }
        listShop.add(newShop);
      } else {
        // await FirebaseMessaging.instance.unsubscribeFromTopic(shop.password);
      }
    }
    config.updateShop(listShop);
    return {};
  } else {
    return {};
  }
}

Future<bool> checkShop(String pass) async {
  Config config = Config();
  await config.init();
  var url = Uri.https('admin.on-sale.co.za', '/on_sale_locator/validate_shop',
      {'shop_id': pass});
  var response = await http.get(url);
  if (response.statusCode == 200) {
    config.updatePushNotification(pass);
    return true;
  } else {
    return false;
  }
}
