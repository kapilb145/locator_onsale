import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:move_to_background/move_to_background.dart';
import 'package:url_launcher/url_launcher.dart';

import '../helper/http_helper.dart';
import '../widgets/list_shops_widget.dart';


class Settings extends StatefulWidget {

  const Settings({super.key, });
//  const leftmenu({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();

}

Future<void> launchUrlLink(String url) async {
  Uri notiUrl = Uri.parse(url);
  if (await canLaunchUrl(notiUrl)) {
    await launchUrl(notiUrl, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}

class _SettingsState extends State<Settings> {
  String name = "";
  void initState()  {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Settings",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              launchUrlLink("http://www.up-locator.on-sale.co.za");
            },
            child:  Row(
              children: [
                Image.asset(
                  "assets/images/upload.png",
                  width: 36,
                  height: 36,
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Upload sale in your area',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

              Future.delayed(const Duration(milliseconds: 200), () {
                MoveToBackground.moveTaskToBack();
                getData("1locate"); // Prints after
                // 1 second.
              });

            },
            child: Padding(
              padding: EdgeInsets.only(top: 25.0),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/minimize.png",
                      width: 22,
                      height: 22,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'ON',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){

              Future.delayed(const Duration(milliseconds: 300), () {
                exit(0); // Prints after// 1 second.
              });

            },
            child:  Padding(
              padding: EdgeInsets.only(top: 25.0, bottom: 25),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      "assets/images/off.png",
                      width: 22,
                      height: 22,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      'OFF',
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                      size: 20,
                    ),
                  )
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              _showListShop(context);
            },
            child: Row(
              children:  [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/Remove.png",
                    width: 26,
                    height: 26,
                  ),
                ),
                Text(
                  'Shop List',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              ],
            ),
          ),

          GestureDetector(
            onTap: (){
              _showAboutUs(context);
            },
            child: Row(
              children:  [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/images/Remove.png",
                    width: 26,
                    height: 26,
                  ),
                ),
                const Text(
                  'What we do',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
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
void _showAboutUs(context) {
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
                        "What we do",
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
                  Text(
                    '''
                    FEATURES OF THE APP

 

1.     Supermarkets and Grocery stores

Many stores list their current promotions only next to the price of the item on the shelf. A customer often has to either look for a particular item that they usually get, and then notice that it is on sale, or they need to walk up and down all of the aisles in the store and identify items on sale. Often, it is too inconvenient for shops to have a ‘promotions’ section only, and many stores do not have catalogues, or it is too time-consuming to view each and every item on promotion. What our app does is as soon as a customer enters a shop that is signed up with us (and that the customer has chosen to receive notifications specifically) they will receive push notifications of all the items on sale. This will save them time in browsing all of the aisles in the store, as they will know exactly which items they will be looking for, in order to save money. Supermarket owners will also be able to get rid of their stock much quicker as our app is an effective form of advertising.

 

2.     Gas stations

Many drivers fill up their vehicles with gas and then leave. They often don’t visit the quick shops belonging to the gas station chain. However, with our app, drivers are able to stay aware of the current promotions in their favorite gas station quick shops, and others in their area/ areas of travel. This saves them time as they do not need to enter the shop – our app will immediately inform them of available promotions. By clicking on the push notification, drivers will also be directed to the gas station’s website, where they can also browse additional promotional items. Drivers do not even need to leave their cars in order to view the promotional catalogues in the store.

 

3.     Properties for sale

For future homeowners, real estate agents, and companies, our app is extremely useful! Users no longer have to browse different listings of properties for sale: our app allows users to drive to particular neighborhoods where they will be interested in purchasing or renting a home, and turn on the app notifications to receive information about the houses available. This will list all of the house specifications and allows users to also follow a link online to the specific listing of the property they are interested in. It is a comfortable way to browse the houses on sale!

 

4.     Restaurants

Restaurant chains are also able to use this app – customers can walk into a restaurant and receive notifications of menu items on promotions, meal combo deals, and so on. They can also be informed of the chef’s specialties and recommendations, adding a professional and impressive feel to the restaurant menu.

 

5.     General shops

Any other stores such as shoe shops, clothing stores, and so on can sign up to use this app. This means that when their customers (who have chosen to receive notifications from these stores) enter a mall, they are able to receive promotional notifications from these shops. This saves customers time as they do not need to even enter the stores to view the items on sale – when they are 300m from their chosen shop, they can view a summary on our app and decide if they want to visit these shops or not. Before users spend their money elsewhere, shops are able to play on their customer’s “mood to shop”, ensuring that their stores are visited as a priority. Customers are diverted to the shops of owners registered with our app.
                    
                    '''

                  )
                ],
              ),
            ),
          ),
        );
      });
}
