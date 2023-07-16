/*
  @2022-12 LoyE
  Provider Widget Home Page
 */
import 'dart:async';
import 'package:flutter/material.dart';
import '../helper/http_helper.dart';
import 'package:move_to_background/move_to_background.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  final fieldText = TextEditingController();
  String topic = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      width: 150,
                      height: 150,
                    ),
                    const Text(
                      "Sale Locator",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                          child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text:
                                    "Our app allows you to receive notifications from different",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " Shops ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 11)),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "in your area that have",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " products/services ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "on special.",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                ]),
                          ),
                        ],
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: "You will receive the notifications",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " ONLY ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "when you're ",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "around",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " 200 meters ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "from the shop or at the entrance.",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text:
                                    "To start receiving notifications click on the ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " 'On' ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "button,",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "also, switch on your phone location",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 11),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text: "If this bothers you, click the",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " 'Off' ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "button and you will not receive",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "any notifications from these shops.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text:
                                    "If you would like to receive permanent notifications from a specific shop",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text:
                                    "every time they have a special, enter the ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " shop password ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "in the bottom space and click",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " ‘Submit’. ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Column(
                        children: [
                          RichText(
                            text: const TextSpan(
                                text:
                                    "You can remove any shop from your shop’s list by clicking on",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text: "the ",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: " ‘Remove’ ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                    text: "button, then clicking on",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 11),
                                  ),
                                  TextSpan(
                                      text: " ‘Remove Shop’.",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                ]),
                          ),
                          RichText(
                            text: const TextSpan(
                                text:
                                    "This will permanently stop you from receiving notifications from that shop.",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 11),
                                children: <TextSpan>[]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                        child: Column(
                      children: [
                        RichText(
                          text: const TextSpan(
                              text: "",
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text:
                                        "The app doesn't use any data when it's on.",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11)),
                              ]),
                        ),
                      ],
                    )),
                    Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: [
                            RichText(
                              text: const TextSpan(
                                  text: "",
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: "Support: +27 79 186 3435",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11)),
                                  ]),
                            ),
                            RichText(
                              text: const TextSpan(
                                  text: "",
                                  style: TextStyle(color: Colors.black),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            "Sale Locator © Copyright on sale I.T (Pty) Ltd",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11)),
                                  ]),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  width: 250,
                  height: 40,
                  child: TextField(
                    controller: fieldText,
                    obscureText: false,
                    // keyboardType: TextInputType.number,
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
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                            const SnackBar(
                              backgroundColor: Colors.orange,
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
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
                      Future.delayed(const Duration(milliseconds: 1000), () {
                        MoveToBackground.moveTaskToBack(); // Prints after
                        // 1 second.
                      });
                    }),
              ]),
        ],
      ),
    );
  }
}
