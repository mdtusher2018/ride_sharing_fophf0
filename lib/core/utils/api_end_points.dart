class ApiEndpoints {
  static const String baseUrl = 'http://10.10.10.70:3033/api/v1/';
  static const String socketUrl = 'http://10.10.10.70:3033';
  static const String baseImageUrl = 'http://10.10.10.70:3033';
  static const String mapKey = 'AIzaSyAQk0BDUcdmln3zCV4CbPDn7UF2Y1PjD7Q';

  //authentication
  static const String signin = "auth/login";
  static const String signup = "auth/signup";
  static const String verifyOTP = "auth/verify-otp";
  static const String forgetPassword = "auth/token";
  static const String resetPassword = "auth/reset-password";
  static const String changePassword = "auth/change-password";
  static const String deleteAccount = "auth/delete-account";

  //profile
  static const String profile = "users/profile";
  static String userById(String id) => "users/$id";

  //notifications
  static const String notification = "notifications";
  static const String unreadNotificationCount = "notifications/unread-count";
  static const String markAllAsRead = "notifications/mark-all-read";
  static String markAsRead(String id) => "notifications/$id/read";

  //Vehicale
  static const String registerVehicale = "vehicles/register";
  static const String myVehicle = "vehicles/my-vehicle";
  static const String applyReferralCode = "vehicles/apply-referral-code";

  //Saved Place
  static const String mySavedLocations = "saved-places";
  static const String saveLocation = "saved-places";
  static String removeSaveLocation(String id) => "saved-places/$id";

  //trip
  static const String passengerTrips = "trips";
  static String passengerTripDetails(String id) => "trips/$id";
  static const String getPublishedTrips = "trips/my-trips";
  static const String createTrips = "trips";
  static const String bookingTrip = "bookings";
  static const String myBookedTrip = "bookings/my-bookings";
  static String acceptBooking(String id) => "bookings/$id/accept";
  static String rejectBooking(String id) => "bookings/$id/cancle";
  static String bookedTripDetailsById(String id) => "bookings/$id";
  static String publishedTripDetailsById(String id) => "bookings/trip/$id";
  static String verifyOtpToStartRide(String id) => "bookings/$id/verify-otp";
  static String verifyOtpToEndRide(String id) => "bookings/$id/complete";
  static String generateDropOffOtp(String id) =>
      "bookings/$id/generate-dropoff-otp";
  static String cancelTripByUser(String bookingId) =>
      "bookings/$bookingId/cancel";

  //Chat
  static const String allConversation = "messages/conversations";
  static const String sendMessage = "messages";
  static const String unreadMessage = "messages/unread-count";
  static String conversationForSpacificBooking(String id) =>
      "messages/booking/$id";
  static String conversationMarkAsRead(String id) =>
      "messages/booking/$id/read";

  //Wallet And Payment
  static const String driverTransactions =
      "transactions/driver?populateBooking=true";
  static const String driverTransactionsSummary = "transactions/driver/summary";
  static const String payCommission = "commission-payments/initiate";

  //Review
  static const String giveReview = "reviews";
  static String getAllReviewById(String id) =>
      "reviews/driver/$id?populate=passenger";

  //Reports
  static const String reportSubjects = "report-subjects";
  static const String submitAReport = "reports";
  static String reportOfSpacificDriver(String userId) => "reports/user/$userId";
  static String reportOfSpacificDriverByTrip(String tripId) =>
      "reports/trip/$tripId";
  static String reportVerification(String reportId) =>
      "reports/$reportId/verify";

  //static-content
  static const String getTermsAndCondition = "terms-and-conditions";
  static const String getContact = "platforms";
}
