/*
  @2022-12 LoyE
  Provider Widget input Shop code
 */
import 'dart:ui';
import 'dart:async';
import 'package:flutter/material.dart';
import '../widgets/list_shops_widget.dart';
import 'package:move_to_background/move_to_background.dart';

//helper
// import '../helper/config_helper.dart';
import '../helper/http_helper.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() {
    // TODO: implement createState
    return _ShopPageState();
  }
}

class _ShopPageState extends State<ShopPage> {
  final fieldText = TextEditingController();
  String topic = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData("1locate").then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => _showListShop(context),
                          child: const Text("View / Remove a Shop"),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Image.asset(
                        "assets/images/store.png",
                        width: 128,
                        height: 128,
                      ),
                      TextField(
                        controller: fieldText,
                        obscureText: false,
                        // keyboardType: TextInputType.number,
                        maxLength: 7,
                        onChanged: (String newText) {
                          if (newText.isNotEmpty) {
                            debugPrint(newText);
                            topic = newText;
                          } else {
                            topic = newText;
                            debugPrint("Empty!");
                          }
                        },
                        onSubmitted: (value) {
                          debugPrint(value);
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter shop password',
                        ),
                      ),
                      ElevatedButton(
                          child: const Text("Submit"),
                          onPressed: () async {
                            debugPrint("$topic\nit Here");
                            fieldText.clear();
                            FocusManager.instance.primaryFocus?.unfocus();
                            checkShop(topic).then((value) {
                              if (value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.green,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Adding Shop Success!',
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.orange,
                                    content: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: const [
                                        Text(
                                          'Check shop password!',
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }
                            });
                            getData("1locate");
                            Future.delayed(const Duration(milliseconds: 500),
                                () {
                              MoveToBackground.moveTaskToBack(); // Prints after
                              // 1 second.
                            });
                          }),
                    ],
                  )
                ],
              )
            ],
          ),
        ));
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
