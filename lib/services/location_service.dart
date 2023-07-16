/*
  @2022-12 LoyE
  Provider function get location user
 */
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import '../helper/config_helper.dart';
import './notification_service.dart';

class Location {
  Location();

  late LocalNotificationService service;
  final GeolocatorPlatform geolocatorAndroid = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;

  initialize() {
    _toggleServiceStatusStream();
  }

  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await geolocatorAndroid.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await geolocatorAndroid.requestPermission();
      return false;
    }

    permission = await geolocatorAndroid.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await geolocatorAndroid.requestPermission();
      if (permission == LocationPermission.denied) {
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = geolocatorAndroid.getServiceStatusStream();
      _serviceStatusStreamSubscription =
          serviceStatusStream.handleError((error) {
        _serviceStatusStreamSubscription?.cancel();
        _serviceStatusStreamSubscription = null;
      }).listen((serviceStatus) {
        debugPrint("Location ?? $_positionStreamSubscription");
        if (serviceStatus == ServiceStatus.enabled) {
          try {
            toggleListening();
          } catch (e) {
            debugPrint("err toggle listening");
          }
        }
      });
    }
  }

  Future<void> toggleListening() async {
    final hasPermission = await _handlePermission();
    if (!hasPermission) {
      return;
    }

    if (_positionStreamSubscription == null) {
      final androidSettings = AndroidSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1,
        intervalDuration: const Duration(seconds: 1),
        forceLocationManager: false,
        useMSLAltitude: true,
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText: "Live notification(No data usage)",
          notificationTitle: "Sale Locator",
          notificationIcon:
              AndroidResource(name: "@mipmap/launcher_icon", defType: "mipmap"),
          enableWakeLock: true,
        ),
      );

      final positionStream = geolocatorAndroid.getPositionStream(
          locationSettings: androidSettings);
      _positionStreamSubscription = positionStream.handleError((error) {
        // _positionStreamSubscription?.cancel();
        // _positionStreamSubscription = null;
      }).listen((position) async {
        await locationCheck(position);
      });
      // _positionStreamSubscription?.pause();
      // toggleListening();
    }

    if (_positionStreamSubscription == null) {
      toggleListening();
      return;
    }
    if (_positionStreamSubscription!.isPaused) {
      _positionStreamSubscription!.resume();
      toggleListening();
    } else {
      _positionStreamSubscription!.pause();
      toggleListening();
    }
  }

  Future<void> locationCheck(Position position) async {
    debugPrint("update location");
    final now = DateTime.now();
    List<Shop> shops = [];
    Config config = Config();
    shops = await config.init();

    for (var shop in shops) {
      if (now.hour >= int.parse(shop.open) &&
          now.hour <= int.parse(shop.close)) {
        if (int.parse(shop.day) < now.day) {
          shop.statusMessOne = true;
          shop.statusMessTwo = true;
          shop.day = now.day.toString();
        }
        shop.allowStatus = true;
      } else {
        shop.allowStatus = false;
      }
    }

    for (var shop in shops) {
      debugPrint(
          "<location> shop name: ${shop.name} status: ${shop.statusMessageOne}");
      debugPrint(
          "<location> shop name: ${shop.name} status: ${shop.statusMessageTwo}");
      if (shop.allowStatus == true && shop.statusMessOne == true ||
          shop.allowStatus == true && shop.statusMessTwo == true) {
        double distanceInMeters = Geolocator.distanceBetween(
            double.parse(shop.lat),
            double.parse(shop.lng),
            position.latitude,
            position.longitude);
        if ((distanceInMeters < int.parse(shop.distance)) &&
            (shop.statusMessageOne == true) &&
            shop.statusMessOne == true) {
          await service.showNotification(
              id: shops.indexOf(shop),
              title: shop.name,
              body: shop.messageOne,
              url: shop.url);
          shop.statusMessOne = false;
        }
        debugPrint(
            "${int.parse(shop.distanceCustom)} trigger or not: $distanceInMeters");
        if ((distanceInMeters < int.parse(shop.distanceCustom)) &&
            (shop.statusMessageTwo == true) &&
            shop.statusMessTwo == true) {
          await service.showNotification(
              id: shops.indexOf(shop) * 10000 + 1,
              title: shop.name,
              body: shop.messageTwo,
              url: shop.url);
          shop.statusMessTwo = false;
        }
      }
    }
    await config.updateShop(shops);
  }

  void deInit() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }
  }
}
