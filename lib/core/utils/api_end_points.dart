class ApiEndpoints {
  static const String baseUrl = 'http://10.10.10.70:3033/api/v1/';
  static const String baseImageUrl = 'http://10.10.10.70:3033';
  static const String mapKey = 'AIzaSyAQk0BDUcdmln3zCV4CbPDn7UF2Y1PjD7Q';

  //authentication
  static const String signin = "auth/login";
  static const String signup = "auth/signup";
  static const String verifyOTP = "auth/verify-otp";
  static const String forgetPassword = "auth/token";
  static const String resetPassword = "auth/reset-password";

  //profile
  static const String profile = "users/profile";

  //notifications
  static const String notification = "notifications";
  static const String unreadNotificationCount = "notifications/unread-count";
  static const String markAllAsRead = "notifications/mark-all-read";
  static String markAsRead(String id) => "notifications/$id/read";

  //Vehicale
  static const String registerVehicale = "vehicles/register";
  static const String myVehicle = "vehicles/my-vehicle";

  static const String mySavedLocations = "saved-places";

  //trip
  static const String passengerTrips = "trips";
  static String passengerTripDetails(String id) => "trips/$id";
  static const String getPublishedTrips = "trips/my-trips";
  static const String createTrips = "trips/my-trips";

  //Wallet
  static const String driverTransactions = "transactions/driver";
  static const String driverTransactionsSummary = "transactions/driver/summary";

  //Review
  static const String giveReview = "reviews";
}
