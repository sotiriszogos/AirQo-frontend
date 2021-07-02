import 'package:app/constants/app_constants.dart';
import 'package:app/core/on_boarding/onBoarding_page.dart';
import 'package:app/screens/feedback_page.dart';
import 'package:app/screens/map_page.dart';
import 'package:app/screens/my_places.dart';
import 'package:app/screens/resources_page.dart';
import 'package:app/screens/search.dart';
import 'package:app/screens/search_location_page.dart';

import 'package:app/screens/settings_page.dart';
import 'package:app/screens/share_picture.dart';
import 'package:app/utils/services/local_storage.dart';
import 'package:app/utils/services/rest_api.dart';
import 'package:app/utils/ui/dialogs.dart';
import 'package:app/utils/ui/share.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'compare_page.dart';
import 'dashboard_page.dart';
import 'faqs_page.dart';

import 'package:url_launcher/url_launcher.dart';

const _url = 'https://forms.gle/oFjqpNoUKPY5ubAcA';
const _faqsUrl = 'https://www.airqo.net/faqs';

class HomePage extends StatefulWidget {
  final String title = 'AirQo';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageCtrl = PageController(initialPage: 0);
  String title = appName;
  bool showAddPlace = true;
  DateTime? exitTime;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          // showAddPlace
          //     ? IconButton(
          //         icon: const Icon(
          //           Icons.addchart_outlined,
          //         ),
          //         onPressed: () async {
          //
          //           // final sessionToken = Uuid().v4();
          //           await showSearch(
          //             context: context,
          //             delegate: LocationSearch(),
          //           );
          //
          //           // Navigator.push(context,
          //           //     MaterialPageRoute(builder: (context) {
          //           //   return AddPlacePage();
          //           //
          //           //
          //           // }));
          //         },
          //       )
          //     : Text(''),
          IconButton(
            icon: const Icon(
              Icons.search,
            ),
            onPressed: () async {
              await showSearch(
                context: context,
                delegate: LocationSearch(),
              ).then((value) {
                setState(() {});
              });

              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => LocationSearch()),
              // ).then((value) => setState(() {
              //       _pageCtrl.jumpToPage(0);
              //     }));
            },
          ),
          PopupMenuButton<dynamic>(
            onSelected: (value) => {navigateToMenuItem(value)},
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'MyPlaces',
                child: ListTile(
                  leading: Icon(
                    Icons.favorite_outlined,
                    color: appColor,
                  ),
                  title: Text(
                    'MyPlaces',
                  ),
                ),
              ),

              const PopupMenuItem<String>(
                value: 'camera',
                child: ListTile(
                  leading: Icon(
                    Icons.camera_alt_outlined,
                    color: appColor,
                  ),
                  title: Text(
                    'Take a Photo',
                  ),
                ),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: appColor,
                  ),
                  title: Text(
                    'Settings',
                  ),
                ),
              ),

              // const PopupMenuItem<String>(
              //   value: 'Faqs',
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.help_outline_outlined,
              //       color: appColor,
              //     ),
              //     title: Text(
              //       'Faqs',
              //     ),
              //   ),
              // ),
              // const PopupMenuItem<String>(
              //   value: 'Feedback',
              //   child: ListTile(
              //     leading: Icon(
              //       Icons.feedback_outlined,
              //       color: appColor,
              //     ),
              //     title: Text(
              //       'Feedback',
              //     ),
              //   ),
              // ),
              const PopupMenuDivider(),
              const PopupMenuItem<String>(
                value: 'Share',
                child: ListTile(
                  leading: Icon(
                    Icons.share_outlined,
                    color: appColor,
                  ),
                  title: Text(
                    'Share',
                    // style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          // height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Spacer(
                flex: 1,
              ),
              IconButton(
                // iconSize: 30.0,
                // padding: const EdgeInsets.only(left: 28.0),
                icon: const Icon(Icons.home_outlined, color: appColor),
                splashColor: appColor,
                onPressed: () {
                  setState(() {
                    _pageCtrl.jumpToPage(0);
                  });
                },
              ),
              Spacer(
                flex: 1,
              ),
              // IconButton(
              //   // iconSize: 30.0,
              //   // autofocus: true,
              //   // padding: const EdgeInsets.only(right: 28.0),
              //   icon: const Icon(Icons.stacked_bar_chart, color: appColor),
              //   splashColor: appColor,
              //   onPressed: () {
              //     setState(() {
              //       _pageCtrl.jumpToPage(1);
              //     });
              //   },
              // ),
              // Spacer(
              //   flex: 3,
              // ),
              // IconButton(
              //   // iconSize: 30.0,
              //   // padding: const EdgeInsets.only(left: 28.0),
              //   icon: const Icon(Icons.notifications_none_outlined,
              //       color: appColor),
              //   splashColor: appColor,
              //   onPressed: () {
              //     setState(() {
              //       _pageCtrl.jumpToPage(2);
              //     });
              //   },
              // ),
              Spacer(
                flex: 1,
              ),
              IconButton(
                // iconSize: 30.0,
                // padding: const EdgeInsets.only(right: 28.0),
                icon: const Icon(Icons.library_books_outlined, color: appColor),
                splashColor: appColor,
                onPressed: () {
                  setState(() {
                    _pageCtrl.jumpToPage(3);
                  });
                },
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      body: WillPopScope(
        onWillPop: onWillPop,
        child: PageView(
          controller: _pageCtrl,
          onPageChanged: (int) {
            switchTitle(int);
            print('Page Changes to index $int');
          },
          physics: const NeverScrollableScrollPhysics(),
          children: <Widget>[
            DashboardPage(),
            // ComparePage(),
            // Center(
            //   child: Container(
            //     child: Text('Coming Soon !'),
            //   ),
            // ),
            // Center(
            //   child: Container(
            //     child: Text('Coming Soon !'),
            //   ),
            // ),
            ResourcesPage(),
          ],
        ),
      ),
      floatingActionButton: Container(
        // height: 60.0,
        // width: 60.0,
        child: FittedBox(
          child: FloatingActionButton(
            backgroundColor: appColor,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return MapPage();
              })).then((value) => setState(() {
                    _pageCtrl.jumpToPage(0);
                  }));
            },
            child: const Icon(
              Icons.public_sharp,
              color: Colors.white,
            ),
            // elevation: 5.0,
          ),
        ),
      ),
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch feedback form, try opening $_url';

  void _launchURLFaqs() async => await canLaunch(_faqsUrl)
      ? await launch(_faqsUrl)
      : throw 'Could not launch feedback form, try opening $_faqsUrl';

  Future<bool> onWillPop() {
    var now = DateTime.now();

    if (exitTime == null ||
        now.difference(exitTime!) > const Duration(seconds: 2)) {
      exitTime = now;

      showSnackBar(context, 'Tap again to exit !');
      // final snackBar = const SnackBar(
      //   content: Text('Tap again to exit !'),
      //   backgroundColor: appColor,
      // );
      // ScaffoldMessenger.of(context).showSnackBar(snackBar);

      return Future.value(false);
    }
    return Future.value(true);
  }

  void switchTitle(int) {
    switch (int) {
      case 0:
        setState(() {
          title = appName;
          showAddPlace = true;
        });
        break;
      case 1:
        setState(() {
          title = 'News Feed';
          showAddPlace = false;
        });
        break;
      default:
        setState(() {
          title = appName;
          showAddPlace = true;
        });
        break;
    }
    // switch (int) {
    //   case 0:
    //     setState(() {
    //       title = appName;
    //       showAddPlace = true;
    //     });
    //     break;
    //   case 1:
    //     setState(() {
    //       title = 'Compare Places';
    //       showAddPlace = false;
    //     });
    //     break;
    //   case 2:
    //     setState(() {
    //       title = 'Notifications';
    //       showAddPlace = false;
    //     });
    //     break;
    //   case 3:
    //     setState(() {
    //       title = 'News Feed';
    //       showAddPlace = false;
    //     });
    //     break;
    //   default:
    //     setState(() {
    //       title = appName;
    //       showAddPlace = true;
    //     });
    //     break;
    // }
  }

  void navigateToMenuItem(dynamic position) {
    var menuItem = position.toString();

    if (menuItem.trim().toLowerCase() == 'feedback') {
      _launchURL();
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return FeedbackPage();
      // }));
    } else if (menuItem.trim().toLowerCase() == 'share') {
      shareApp();
    } else if (menuItem.trim().toLowerCase() == 'faqs') {
      _launchURLFaqs();
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return FaqsPage();
      // }));
    } else if (menuItem.trim().toLowerCase() == 'myplaces') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const MyPlaces();
      })).then((value) {
        setState(() {});
      });
    }
    else if (menuItem.trim().toLowerCase() == 'settings') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SettingsPage();
      })).then((value) {
        setState(() {});
      });
    } else if (menuItem.trim().toLowerCase() == 'camera') {
      takePhoto();
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SettingsPage();
      }));
    }
  }

  @override
  void initState() {
    displayOnBoarding();

    _getMeasurements();
    _getDevices();
    super.initState();
  }

  void _getMeasurements() async {
    print('Home page Getting measurements');

    var measurements = await AirqoApiClient(context).fetchMeasurements();

    if (measurements.isNotEmpty) {
      await DBHelper().insertMeasurements(measurements);
    }
  }

  Future<void> _getDevices() async {
    print('Home page Getting devices');

    var results = await AirqoApiClient(context).fetchDevices();

    if (results.isNotEmpty) {
      await DBHelper().insertDevices(results);
    }
  }

  Future<void> displayOnBoarding() async {
    var prefs = await SharedPreferences.getInstance();
    var isFirstUse = prefs.getBool(firstUse) ?? true;

    if (isFirstUse) {
      await Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) {
        return OnBoardingPage();
      }));
    }
  }

  Future<void> takePhoto() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    final firstCamera = cameras.first;

    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TakePicture(
        camera: firstCamera,
      );
    }));
  }
}