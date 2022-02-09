import 'package:json_annotation/json_annotation.dart';

part 'user_details.g.dart';

@JsonSerializable(explicitToJson: true)
class UserDetails {
  @JsonKey(defaultValue: '')
  String title = '';

  @JsonKey(defaultValue: '')
  String firstName = '';

  @JsonKey(defaultValue: '')
  String userId = '';

  @JsonKey(defaultValue: '')
  String lastName = '';

  @JsonKey(defaultValue: '')
  String emailAddress = '';

  @JsonKey(defaultValue: '')
  String phoneNumber = '';

  @JsonKey(defaultValue: '')
  String device = '';

  @JsonKey(defaultValue: '')
  String photoUrl = '';
  UserPreferences preferences = UserPreferences(false, false, false, 0);

  UserDetails(
      this.title,
      this.firstName,
      this.userId,
      this.lastName,
      this.emailAddress,
      this.phoneNumber,
      this.device,
      this.photoUrl,
      this.preferences);

  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);

  String getFullName() {
    var fullName = '$firstName $lastName'.trim();

    return fullName.isEmpty ? 'Hello' : fullName;
  }

  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);

  @override
  String toString() {
    return 'UserDetails{firstName: $firstName, userId: $userId, '
        'lastName: $lastName, emailAddress: $emailAddress, '
        'phoneNumber: $phoneNumber, device: $device, photoUrl: $photoUrl}';
  }

  static List<String> getNames(String fullName) {
    var namesArray = fullName.split(' ');
    if (namesArray.isEmpty) {
      return ['', ''];
    }
    if (namesArray.length >= 2) {
      return [namesArray.first, namesArray[1]];
    } else {
      return [namesArray.first, ''];
    }
  }

  static UserDetails initialize() {
    return UserDetails('Ms.', '', '', '', '', '', '', '',
        UserPreferences(false, false, false, 0));
  }

  static UserDetails parseUserDetails(dynamic jsonBody) {
    return UserDetails.fromJson(jsonBody);
  }
}

@JsonSerializable(explicitToJson: true)
class UserPreferences {
  @JsonKey(defaultValue: false)
  bool notifications;

  @JsonKey(defaultValue: false)
  bool location;

  @JsonKey(defaultValue: false)
  bool alerts;

  @JsonKey(defaultValue: 0)
  int aqShares;

  UserPreferences(
      this.notifications, this.location, this.alerts, this.aqShares);

  factory UserPreferences.fromJson(Map<String, dynamic> json) =>
      _$UserPreferencesFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreferencesToJson(this);

  @override
  String toString() {
    return 'UserPreferences{notifications: $notifications,'
        ' location: $location, alerts: $alerts}';
  }
}