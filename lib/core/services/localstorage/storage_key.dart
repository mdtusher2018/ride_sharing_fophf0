/// Enum to define all keys in a type-safe way
enum StorageKey { token, accessToken, rememberMe, savedLoginsKey }

extension StorageKeyExtension on StorageKey {
  String get key {
    switch (this) {
      case StorageKey.token:
        return 'token';
      case StorageKey.accessToken:
        return 'token';
      case StorageKey.rememberMe:
        return 'rememberMe';
      case StorageKey.savedLoginsKey:
        return "saved_logins";
    }
  }
}
