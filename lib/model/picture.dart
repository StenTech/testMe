//  "picture": {
//       "large": "https://randomuser.me/api/portraits/men/75.jpg",
//       "medium": "https://randomuser.me/api/portraits/med/men/75.jpg",
//       "thumbnail": "https://randomuser.me/api/portraits/thumb/men/75.jpg"
//   },

class Picture {
  String? large;
  String? medium;
  String? thumbnail;

  Picture({
    this.large,
    this.medium,
    this.thumbnail,
  });

  Picture.fromJson(Map<String, dynamic> json) {
    large = json['large'];
    medium = json['medium'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['large'] = large;
    data['medium'] = medium;
    data['thumbnail'] = thumbnail;
    return data;
  }

  @override
  String toString() {
    return 'Picture{large: $large, medium: $medium, thumbnail: $thumbnail}';
  }
}
