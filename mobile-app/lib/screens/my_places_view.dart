import 'package:app/constants/app_constants.dart';
import 'package:app/models/measurement.dart';
import 'package:app/models/site.dart';
import 'package:app/screens/place_details.dart';
import 'package:app/screens/search_location_page.dart';
import 'package:app/services/local_storage.dart';
import 'package:app/services/rest_api.dart';
import 'package:app/utils/dialogs.dart';
import 'package:app/utils/share.dart';
import 'package:app/widgets/air_quality_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyPlacesView extends StatefulWidget {
  MyPlacesView({Key? key}) : super(key: key);

  @override
  _MyPlacesViewState createState() => _MyPlacesViewState();
}

class _MyPlacesViewState extends State<MyPlacesView> {
  var results = <Measurement>[];
  var order = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: ColorConstants.appBodyColor,
        child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 6, 6, 6),
            child: FutureBuilder(
                future: DBHelper().getFavouritePlaces(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    results = sortPlaces(snapshot.data as List<Measurement>);
                    if (results.isEmpty) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(40.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Empty in My Places',
                                softWrap: true,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                'Add places of interest using the AirQo map '
                                'or search',
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              OutlinedButton(
                                onPressed: () async {
                                  await showSearch(
                                    context: context,
                                    delegate: LocationSearch(),
                                  ).then((_) {
                                    setState(() {});
                                  });
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const CircleBorder(),
                                  padding: const EdgeInsets.all(24),
                                ),
                                child: Text(
                                  'Add',
                                  style:
                                      TextStyle(color: ColorConstants.appColor),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }

                    return RefreshIndicator(
                        color: ColorConstants.appColor,
                        onRefresh: _getLatestMeasurements,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Spacer(),
                                GestureDetector(
                                  child: const Icon(Icons.sort),
                                  onTap: () {
                                    setState(() {
                                      order = -order;
                                    });
                                    reloadData();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () {
                                    viewDetails(results[index]);
                                  },
                                  child: Slidable(
                                      actionPane:
                                          const SlidableDrawerActionPane(),
                                      actionExtentRatio: 0.25,
                                      actions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Share',
                                          color: Colors.transparent,
                                          foregroundColor:
                                              ColorConstants.appColor,
                                          icon: Icons.share_outlined,
                                          onTap: () => shareLocation(
                                              results[index].site),
                                        ),
                                      ],
                                      secondaryActions: <Widget>[
                                        IconSlideAction(
                                          caption: 'Remove',
                                          foregroundColor: Colors.red,
                                          color: Colors.transparent,
                                          icon: Icons.delete_outlined,
                                          onTap: () {
                                            removeFromFavourites(
                                                results[index].site);
                                          },
                                        ),
                                      ],
                                      child: AirQualityCard(
                                        data: results[index],
                                      )),
                                ),
                                itemCount: results.length,
                              ),
                            ),
                          ],
                        ));
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                            ColorConstants.appColor),
                      ),
                    );
                  }
                })));
  }

  @override
  void initState() {
    super.initState();
    _getLatestMeasurements();
  }

  Future<void> reloadData() async {
    await DBHelper().getFavouritePlaces().then((value) => {
          if (mounted)
            {
              setState(() {
                results = sortPlaces(value);
              })
            }
        });
  }

  Future<void> removeFromFavourites(Site site) async {
    await DBHelper().updateFavouritePlaces(site).then((value) => {
          showSnackBar(context, '${site.getName()} is removed from your places')
        });

    if (mounted) {
      setState(() {});
    }
  }

  List<Measurement> sortPlaces(List<Measurement> values) {
    if (order == -1) {
      values.sort((valueA, valueB) =>
          -(valueA.getPm2_5Value().compareTo(valueB.getPm2_5Value())));
    } else {
      values.sort((valueA, valueB) =>
          valueA.getPm2_5Value().compareTo(valueB.getPm2_5Value()));
    }

    return values;
  }

  Future<void> viewDetails(Measurement measurement) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return PlaceDetailsPage(measurement: measurement);
    })).then((value) {
      setState(() {});
    });
  }

  Future<void> _getLatestMeasurements() async {
    await AirqoApiClient(context).fetchLatestMeasurements().then((value) => {
          if (value.isNotEmpty)
            {
              DBHelper()
                  .insertLatestMeasurements(value)
                  .then((value) => {reloadData()})
            }
        });
  }
}
