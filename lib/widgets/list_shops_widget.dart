/*
  Render List Shop from Json Data
  author LoyE - 2022/12/28
 */
import 'package:flutter/material.dart';
import '../helper/config_helper.dart';
import 'package:url_launcher/url_launcher.dart';

  class Shops extends StatefulWidget {
  const Shops({super.key});

    @override
  State<Shops> createState() {
    return _ShopState();
  }
  }

  class _ShopState extends State<Shops> {
    List<Shop> shops = [];
    late Config config;

    Future getData() async  {
      config = Config();
      config.init().then((value) => setState(() {
        shops = value;
        shops.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      }));
    }

    Future<void> _launchUrl(String url) async {
      Uri notiUrl = Uri.parse(url);
      if (!await launchUrl(notiUrl, mode: LaunchMode.externalApplication)) {
        throw 'Could not launch $notiUrl';
      }
    }

    @override
    void initState() {
      // TODO: implement initState
      super.initState();
      getData();
    }

    @override
    Widget build(BuildContext context) {
      // TODO: implement build
      return SingleChildScrollView(
        child: Column(
          children:
          shops.map((item) {
            return SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: () {
                    _launchUrl(item.url);
                  }, child: SizedBox(
                    width: MediaQuery.of(context).size.width/2,
                    child: Text(item.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
              const TextStyle(
                      fontSize: 16,
                      color: Colors.black
                    ),),
                  )),
                  TextButton(onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return WillPopScope(
                          onWillPop: () async => false,
                          child: AlertDialog(
                            title: const Center(
                              child: Text
                                ("  Delete Shop",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle
                                (fontWeight: FontWeight.bold),
                              ),),
                            content: const Text('Are you sure you want to '
                                'delete this Shop?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: (){
                                  config.removeShop(item.password);
                                  addShopBan(item.password);
                                  setState(() {
                                  });
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red
                                ),
                                child: const Text('Delete',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle
                                  (color: Colors.white),),
                              )
                            ],
                          ),
                        );
                      },
                    );
                    setState(() {

                    });
                  }, child: const Text("Remove Shop"),)
                ],
              ),
            );
          }).toList(),
        ),
      );
    }
  }