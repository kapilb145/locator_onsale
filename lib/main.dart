import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locator_sample/cubit/articles/articlescubit.dart';
import 'package:locator_sample/pages/articles.dart';
import 'package:locator_sample/pages/settings.dart';
import 'package:locator_sample/services/repository.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:sizer/sizer.dart';
import 'dart:io';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

//Screen
import './pages/home_page.dart';
import './widgets/list_shops_widget.dart';

//service
import './services/location_service.dart';
import './services/notification_service.dart';

//fcm
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'firebase_options.dart';
import 'helper/config_helper.dart';

//helper
import '../helper/http_helper.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('openNotification', true);
  await prefs.setString('url', message.data["url"]);
}

void _handleMessage(RemoteMessage message) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('openNotification', false);

  Uri notiUrl = Uri.parse(message.data["url"]);
  if (await canLaunchUrl(notiUrl)) {
    await launchUrl(notiUrl, mode: LaunchMode.externalApplication);
    return;
  } else {
    throw 'Could not launch $notiUrl';
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.white,
    statusBarBrightness: Brightness.light, // status bar color
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const LocationApp());
}

class LocationApp extends StatelessWidget {
  const LocationApp({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = MarketPlaceRepository();
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ArticlesCubit(repository),
          ),
        ],
        child: Sizer(builder: (context, orientation, deviceType) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                useMaterial3: true,
              ),
              home: const Navigation());
        }));
  }
}

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> with WidgetsBindingObserver {
  int _currentIndex = 0;
  late final LocalNotificationService service;
  late final Location locationService;

  Future<void> initService() async {
    service = LocalNotificationService();
    locationService = Location();
    service.initialize().then((value) async {
      locationService.service = service;
      locationService.initialize();
      await locationService.toggleListening();
    });
    await FirebaseMessaging.instance.subscribeToTopic("1locate");
    Config config = Config();
    await config.init();
    await getData("1locate");
  }

  @override
  void initState() {
    super.initState();
    initService();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      openUrl();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint("app in resumed");
        break;
      case AppLifecycleState.inactive:
        debugPrint("app in inactive");
        break;
      case AppLifecycleState.paused:
        debugPrint("app in paused");
        break;
      case AppLifecycleState.detached:
        debugPrint("app in detached");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          MoveToBackground.moveTaskToBack();
          return Future.value(false);
        },
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            // onDestinationSelected: (int index) {
            //   // if (index == 1) {
            //   //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Articles()));
            //   // }
            //   // if (index == 2) {
            //   //   index = 0;
            //   //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Settings()));
            //   // }
            //   // if (index == 3) {
            //   //   index = 0;
            //   //   Future.delayed(const Duration(milliseconds: 300), () {
            //   //     exit(0); // Prints after// 1 second.
            //   //   });
            //   // }
            //   //
            //   // if (index == 4) {
            //   //   _showListShop(context);
            //   // }
            //   //
            //   // if (index == 5) {
            //   //   launchUrlLink("http://www.locator.on-sale.co.za");
            //   // }
            //   //
            //   // // setState(() {
            //   // //   currentPageIndex = index;
            //   // // });
            //   // if (index == 6) {
            //   //   Navigator.push(context, MaterialPageRoute(builder: (context) =>  Settings()));
            //   //
            //   // }
            //
            //   print('Selected $index');
            //
            // },
            currentIndex: _currentIndex,

            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },

            items :[
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/images/home.png",
                  width: 28,
                  height: 28,
                ),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.area_chart),
                label: 'Arts',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Setting',
              ),
            ],

            // destinations: <NavigationDestination>[
            //   NavigationDestination(
            //     icon: Image.asset(
            //       "assets/images/home.png",
            //       width: 28,
            //       height: 28,
            //     ),
            //     label: 'Home',
            //   ),
            //   const NavigationDestination(
            //     icon: Icon(
            //       Icons.shopping_cart,
            //       size: 32,
            //     ),
            //     label: 'Arts',
            //   ),
            //   NavigationDestination(
            //     icon: Image.asset(
            //       "assets/images/settings.png",
            //       width: 36,
            //       height: 36,
            //     ),
            //     label: 'Settings',
            //   ),
            //
            // ],
          ),
          body: IndexedStack(
          index: _currentIndex,
          children: const [
            HomePage(),
            Articles(),
            Settings(),
          ],
        ),
        ));
  }

  @override
  void dispose() {
    locationService.deInit();
    super.dispose();
  }

  Future<void> launchUrlLink(String url) async {
    Uri notiUrl = Uri.parse(url);
    if (await canLaunchUrl(notiUrl)) {
      await launchUrl(notiUrl, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  void openUrl() async {
    final prefs = await SharedPreferences.getInstance();
    bool? status = prefs.getBool("openNotification");
    if (status == true) {
      String? url = prefs.getString("url");
      await prefs.setBool('openNotification', false);
      await launchUrlLink(url!);
    }
  }

  void _showListShop(context) {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  )
                ],
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "List of shops",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Close",
                              style: TextStyle(color: Colors.red),
                            ))
                      ],
                    ),
                    const Shops()
                  ],
                ),
              ),
            ),
          );
        });
  }
}
