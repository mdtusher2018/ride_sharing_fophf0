/// Enum to define all keys in a type-safe way
enum StorageKey { accessToken, rememberMe, savedLoginsKey }

extension StorageKeyExtension on StorageKey {
  String get key {
    switch (this) {
      case StorageKey.accessToken:
        return 'token';
      case StorageKey.rememberMe:
        return 'rememberMe';
      case StorageKey.savedLoginsKey:
        return "saved_logins";
    }
  }
}
