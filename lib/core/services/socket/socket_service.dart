import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:velozaje/core/services/socket/socket_config.dart';
import 'package:velozaje/core/services/socket/socket_events.dart';
import 'package:velozaje/core/utils/constants.dart';
import 'package:velozaje/core/utils/extention.dart';

class SocketService {
  SocketService._internal();
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;

  IO.Socket? _socket;
  SocketConfig? _config;

  final _connectionController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionController.stream;

  bool get isConnected => _socket?.connected ?? false;

  // ------------------ Store Active Events ------------------
  final Set<String> _activeListeners = {};
  Set<String> get activeListeners => _activeListeners;

  // ------------------ INIT ------------------
  void init(SocketConfig config) {
    _config = config;
  }

  // ------------------ CONNECT ------------------
  void connect() {
    if (_socket != null && _socket!.connected) return;
    if (_config == null) {
      throw Exception('SocketConfig not initialized');
    }

    _socket = IO.io(
      _config!.url,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setAuth({'token': _config!.token})
          .setReconnectionAttempts(10)
          .setReconnectionDelay(2000)
          .build(),
    );

    _registerCoreListeners();
    _socket!.connect();
  }

  // ------------------ CORE LISTENERS ------------------
  void _registerCoreListeners() {
    _socket!
      ..on(SocketEvents.connect, (_) {
        _connectionController.add(true);
      })
      ..on(SocketEvents.disconnect, (_) {
        _connectionController.add(false);
      })
      ..on(SocketEvents.error, (e) {
        if (e is Map<String, dynamic>) {
          if (e['success'] == false) {
            navigatorKey.currentContext?.showErrorSnackbar(
              title: "Socket Error",
              message: e['message'] ?? "",
            );
          }
        }
      });
  }

  // ------------------ EMIT ------------------
  Future<dynamic> emit(String event, dynamic data) async {
    if (!isConnected) {
      return;
    }

    try {
      _socket!.emitWithAck(
        event,
        data,
        ack: (response) {
          if (response?['success'] == false) {
            throw Exception(response['message'] ?? "Unknown error");
          }

          return response;
        },
      );
    } catch (e) {
      if (e is Map<String, dynamic>) {
        throw Exception(e['message'] ?? "Unknown Error Occoured");
      } else {
        throw Exception("Unknown Error Occoured");
      }
    }
  }

  // ------------------ LISTEN ------------------
  void on(String event, Function(dynamic data) callback) {
    _activeListeners.add(event);

    _socket?.on(event, callback);
  }

  // ------------------ LISTEN Once------------------
  void listenOnce(String event, Function(dynamic data) callback) {
    _socket?.once(event, callback);
  }

  void off(String event) {
    _activeListeners.remove(event);

    _socket?.off(event);
  }

  // ------------------ SAFE DISCONNECT ------------------
  void disconnect() {
    _socket?.disconnect();
    _socket?.dispose();
    _socket = null;
  }

  // ------------------ CLEANUP ------------------
  void dispose() {
    disconnect();
    _connectionController.close();
  }
}
