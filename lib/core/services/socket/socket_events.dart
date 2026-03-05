class SocketEvents {
  SocketEvents._();

  // =========================
  // CORE SOCKET EVENTS
  // =========================
  static const String connect = 'connect';
  static const String disconnect = 'disconnect';
  static const String error = 'error';

  // =========================
  // USER JOIN / MESSAGES
  // =========================
  static const String join = 'join';
  static const String joined = 'joined';
  static const String newMessage = 'new-message';
  static const String messagesRead = 'messages-read';

  // =========================
  // TRIP-RELATED EVENTS
  // =========================
  static const String joinTripRoom = 'join-trip-room';
  static const String tripRoomError = 'trip-room-error';
  static const String tripStarted = 'trip-started';
  static const String tripCompleted = 'trip-completed';
  static const String tripCancelled = 'trip-cancelled';

  // =========================
  // LOCATION UPDATES
  // =========================
  static const String passengerLocationUpdate = 'passenger-location-update';
  static const String passengerLocations = 'passenger-locations';
  static const String driverLocationUpdate = 'driver-location-update';

  // =========================
  // ROOM MANAGEMENT
  // =========================
  static const String leaveTripRoom = 'trip-room-left';
}
