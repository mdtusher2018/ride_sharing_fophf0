import 'dart:async';
import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:velozaje/core/services/localstorage/i_local_storage_service.dart';
import 'package:velozaje/core/services/localstorage/storage_key.dart';
import 'package:velozaje/core/services/socket/socket_events.dart';
import 'package:velozaje/core/utils/api_end_points.dart';
import 'package:velozaje/core/utils/constants.dart';
import 'package:velozaje/core/utils/extention.dart';

class SocketService {
  SocketService(this._localStorageService);
  IO.Socket? _socket;

  final ILocalStorageService _localStorageService;

  final _connectionController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionController.stream;

  bool get isConnected => _socket?.connected ?? false;

  // ------------------ Store Active Events ------------------
  final Set<String> _activeListeners = {};
  Set<String> get activeListeners => _activeListeners;

  // ------------------ CONNECT ------------------
  Future<void> connect() async {
    if (_socket != null && _socket!.connected) return;
    final token = await _localStorageService.getString(StorageKey.accessToken);
    if (token == null) {
      throw Exception('SocketConfig not initialized');
    }

    _socket = IO.io(
      ApiEndpoints.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .setReconnectionAttempts(10)
          .setReconnectionDelay(2000)
          .build(),
    );

    _registerCoreListeners();
    _socket!.connect();
    log("================socket connected===========");
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
  void emit(String event, dynamic data) async {
    log("Socet Brfore Emit: $event with $data=============");
    try {
      _socket!.emitWithAck(event, data);
      log("Socet After Emit: $event with $data=============");
    } catch (e) {
      log("Socet EmitFaild: $event with $data=============");
      navigatorKey.currentContext?.showErrorSnackbar(
        title: "Error",
        message: e.toString(),
      );
    }
  }

  // ------------------ LISTEN ------------------
  void on(String event, Function(dynamic data) callback) {
    _activeListeners.add(event);

    log('Listening to event: $event========>>>>>>>>>');
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
