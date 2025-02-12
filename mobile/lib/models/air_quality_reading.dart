import 'package:app/models/models.dart';
import 'package:app_repository/app_repository.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import '../constants/config.dart';

part 'air_quality_reading.g.dart';

@JsonSerializable()
@HiveType(typeId: 50, adapterName: 'AirQualityReadingAdapter')
class AirQualityReading extends HiveObject {
  AirQualityReading({
    required this.referenceSite,
    required this.source,
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.name,
    required this.location,
    required this.region,
    required this.dateTime,
    required this.pm2_5,
    required this.pm10,
    required this.distanceToReferenceSite,
    required this.placeId,
  });

  factory AirQualityReading.fromJson(Map<String, dynamic> json) =>
      _$AirQualityReadingFromJson(json);

  factory AirQualityReading.fromSiteReading(SiteReading siteReading) {
    return AirQualityReading(
      referenceSite: siteReading.siteId,
      latitude: siteReading.latitude,
      longitude: siteReading.longitude,
      country: siteReading.country,
      name: siteReading.name,
      location: siteReading.location,
      region: Region.fromString(siteReading.region),
      source: siteReading.source,
      dateTime: siteReading.dateTime,
      pm2_5: siteReading.pm2_5,
      pm10: siteReading.pm10,
      distanceToReferenceSite: 0.0,
      placeId: siteReading.siteId,
    );
  }

  factory AirQualityReading.fromFavouritePlace(FavouritePlace favouritePlace) {
    return AirQualityReading(
      referenceSite: favouritePlace.referenceSite,
      latitude: favouritePlace.latitude,
      longitude: favouritePlace.longitude,
      country: favouritePlace.location,
      name: favouritePlace.name,
      location: favouritePlace.location,
      region: Region.fromString(''),
      source: favouritePlace.location,
      dateTime: DateTime.now(),
      pm2_5: 0.0,
      pm10: 0.0,
      distanceToReferenceSite: 0.0,
      placeId: favouritePlace.placeId,
    );
  }

  factory AirQualityReading.duplicate(AirQualityReading airQualityReading) {
    return AirQualityReading(
      referenceSite: airQualityReading.referenceSite,
      source: airQualityReading.referenceSite,
      latitude: airQualityReading.latitude,
      longitude: airQualityReading.longitude,
      country: airQualityReading.country,
      name: airQualityReading.name,
      location: airQualityReading.location,
      region: airQualityReading.region,
      dateTime: airQualityReading.dateTime,
      pm2_5: airQualityReading.pm2_5,
      pm10: airQualityReading.pm10,
      distanceToReferenceSite: airQualityReading.distanceToReferenceSite,
      placeId: airQualityReading.placeId,
    );
  }

  AirQualityReading copyWith({
    double? distanceToReferenceSite,
    String? placeId,
    String? name,
    String? location,
    String? referenceSite,
    double? latitude,
    double? longitude,
    DateTime? dateTime,
    double? pm2_5,
    double? pm10,
  }) {
    return AirQualityReading(
      referenceSite: referenceSite ?? this.referenceSite,
      source: source,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      country: country,
      name: name ?? this.name,
      location: location ?? this.location,
      region: region,
      dateTime: dateTime ?? this.dateTime,
      pm2_5: pm2_5 ?? this.pm2_5,
      pm10: pm10 ?? this.pm10,
      distanceToReferenceSite:
          distanceToReferenceSite ?? this.distanceToReferenceSite,
      placeId: placeId ?? this.placeId,
    );
  }

  AirQualityReading populateFavouritePlace(FavouritePlace favouritePlace) {
    return AirQualityReading.duplicate(
      AirQualityReading(
        placeId: favouritePlace.placeId,
        latitude: favouritePlace.latitude,
        longitude: favouritePlace.longitude,
        name: favouritePlace.name,
        location: favouritePlace.location,
        referenceSite: referenceSite,
        source: source,
        country: country,
        region: region,
        dateTime: dateTime,
        pm2_5: pm2_5,
        pm10: pm10,
        distanceToReferenceSite: distanceToReferenceSite,
      ),
    );
  }

  @HiveField(0)
  @JsonKey(defaultValue: '')
  final String referenceSite;

  @HiveField(1)
  @JsonKey(defaultValue: 0.0)
  final double latitude;

  @HiveField(2)
  @JsonKey(defaultValue: 0.0)
  final double longitude;

  @HiveField(3)
  @JsonKey(defaultValue: '')
  final String country;

  @HiveField(4)
  @JsonKey(defaultValue: '')
  final String name;

  @HiveField(5)
  @JsonKey(defaultValue: '')
  final String source;

  @HiveField(6)
  @JsonKey(defaultValue: '')
  final String location;

  @HiveField(7)
  @RegionConverter()
  final Region region;

  @HiveField(8)
  final DateTime dateTime;

  @HiveField(9)
  @JsonKey(defaultValue: 0.0)
  final double pm2_5;

  @HiveField(10)
  @JsonKey(defaultValue: 0.0)
  final double pm10;

  @HiveField(11)
  @JsonKey(defaultValue: 0.0)
  final double distanceToReferenceSite;

  @HiveField(12)
  @JsonKey(defaultValue: '')
  final String placeId;

  Map<String, dynamic> toJson() => _$AirQualityReadingToJson(this);
}

List<AirQualityReading> sortAirQualityReadingsByDistance(
  List<AirQualityReading> airQualityReadings,
) {
  airQualityReadings.sort(
    (x, y) {
      return x.distanceToReferenceSite.compareTo(y.distanceToReferenceSite);
    },
  );

  return airQualityReadings;
}

List<AirQualityReading> filterNearestLocations(
  List<AirQualityReading> airQualityReadings,
) {
  airQualityReadings = airQualityReadings
      .where(
        (element) => element.distanceToReferenceSite <= Config.searchRadius,
      )
      .toList();
  airQualityReadings = sortAirQualityReadingsByDistance(airQualityReadings);

  return airQualityReadings;
}
