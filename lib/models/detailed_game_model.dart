// To parse this JSON data, do
//
//     final detailedGameModel = detailedGameModelFromJson(jsonString);

import 'dart:convert';

DetailedGameModel detailedGameModelFromJson(String str) =>
    DetailedGameModel.fromJson(json.decode(str));

String detailedGameModelToJson(DetailedGameModel data) =>
    json.encode(data.toJson());

class DetailedGameModel {
  final int id;
  final String title;
  final String thumbnail;
  final String status;
  final String shortDescription;
  final String description;
  final String gameUrl;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final DateTime releaseDate;
  final String freetogameProfileUrl;
  final MinimumSystemRequirements? minimumSystemRequirements;
  final List<Screenshot> screenshots;

  DetailedGameModel({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.status,
    required this.shortDescription,
    required this.description,
    required this.gameUrl,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.releaseDate,
    required this.freetogameProfileUrl,
    this.minimumSystemRequirements,
    required this.screenshots,
  });

  factory DetailedGameModel.fromJson(Map<String, dynamic> json) =>
      DetailedGameModel(
        id: json["id"],
        title: json["title"],
        thumbnail: json["thumbnail"],
        status: json["status"],
        shortDescription: json["short_description"],
        description: json["description"],
        gameUrl: json["game_url"],
        genre: json["genre"],
        platform: json["platform"],
        publisher: json["publisher"],
        developer: json["developer"],
        releaseDate: DateTime.parse(json["release_date"]),
        freetogameProfileUrl: json["freetogame_profile_url"],
        minimumSystemRequirements:
            json.containsKey("minimum_system_requirements")
            ? MinimumSystemRequirements.fromJson(
                json["minimum_system_requirements"],
              )
            : null,
        screenshots: List<Screenshot>.from(
          json["screenshots"].map((x) => Screenshot.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "thumbnail": thumbnail,
    "status": status,
    "short_description": shortDescription,
    "description": description,
    "game_url": gameUrl,
    "genre": genre,
    "platform": platform,
    "publisher": publisher,
    "developer": developer,
    "release_date":
        "${releaseDate.year.toString().padLeft(4, '0')}-${releaseDate.month.toString().padLeft(2, '0')}-${releaseDate.day.toString().padLeft(2, '0')}",
    "freetogame_profile_url": freetogameProfileUrl,
    "minimum_system_requirements": minimumSystemRequirements!.toJson(),
    "screenshots": List<dynamic>.from(screenshots.map((x) => x.toJson())),
  };
}

class MinimumSystemRequirements {
  final String os;
  final String processor;
  final String memory;
  final String graphics;
  final String storage;

  MinimumSystemRequirements({
    required this.os,
    required this.processor,
    required this.memory,
    required this.graphics,
    required this.storage,
  });

  factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json) =>
      MinimumSystemRequirements(
        os: json["os"],
        processor: json["processor"],
        memory: json["memory"],
        graphics: json["graphics"],
        storage: json["storage"],
      );

  Map<String, dynamic> toJson() => {
    "os": os,
    "processor": processor,
    "memory": memory,
    "graphics": graphics,
    "storage": storage,
  };
}

class Screenshot {
  final int id;
  final String image;

  Screenshot({required this.id, required this.image});

  factory Screenshot.fromJson(Map<String, dynamic> json) =>
      Screenshot(id: json["id"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "image": image};
}
