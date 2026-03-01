class GetContactResponse {
  bool success;
  String message;
  _PlatformData data;

  GetContactResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetContactResponse.fromJson(Map<String, dynamic> json) {
    return GetContactResponse(
      success: json['success'],
      message: json['message'],
      data: _PlatformData.fromJson(json['data']),
    );
  }
}

class _PlatformData {
  int count;
  List<ContactPlatform> platforms;

  _PlatformData({required this.count, required this.platforms});

  factory _PlatformData.fromJson(Map<String, dynamic> json) {
    return _PlatformData(
      count: json['count'],
      platforms: List<ContactPlatform>.from(
        json['data'].map((x) => ContactPlatform.fromJson(x)),
      ),
    );
  }
}

class ContactPlatform {
  String id;
  String name;
  String link;
  String thumbnail;

  ContactPlatform({
    required this.id,
    required this.name,
    required this.link,
    required this.thumbnail,
  });

  factory ContactPlatform.fromJson(Map<String, dynamic> json) {
    return ContactPlatform(
      id: json['_id'],
      name: json['name'],
      link: json['link'],
      thumbnail: json['thumbnail'],
    );
  }
}
