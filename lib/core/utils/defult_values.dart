import 'package:google_maps_flutter/google_maps_flutter.dart';

class AppDefaultValue {
  // Basic user info
  static const String name = "Unnamed User";
  static const String email = "noemail@domain.com";
  static const String phone = "N/A";

  // Profile images
  static const String profilePicture =
      "https://static.vecteezy.com/system/resources/previews/036/280/651/original/default-avatar-profile-icon-social-media-user-image-gray-avatar-icon-blank-profile-silhouette-illustration-vector.jpg"; // default avatar URL
  static const String coverPhoto =
      "https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg";

  // Account status
  static const bool isActive = true;
  static const bool emailVerified = false;
  static const bool isLocked = false;

  // Stats
  static const int tripCount = 0;
  static const int bookingCount = 0;
  static const int packageDelivered = 0;
  static const int packageSent = 0;
  static const int travelCount = 0;

  // Location
  static const LatLng latLng = LatLng(10.380808, 51.091988);

  // Messages
  static const String genericErrorMessage = "Something went wrong";
  static const String loadingMessage = "Loading, please wait...";
}
