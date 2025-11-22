class ExploreResponse {
  int? page;
  List<ExploreModel>? results;
  int? totalPages;
  int? totalResults;

  ExploreResponse({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  ExploreResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    totalPages = json['total_pages'];
    totalResults = json['total_results'];

    if (json['results'] != null && json['results'] is List) {
      results = (json['results'] as List)
          .map((v) => ExploreModel.fromJson(v))
          .toList();
    } else {
      results = [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'results': results?.map((v) => v.toJson()).toList(),
      'total_pages': totalPages,
      'total_results': totalResults,
    };
  }
}

class ExploreModel {
  bool? adult;
  String? backdropPath;
  int? id;
  String? title;
  String? originalTitle;
  String? overview;
  String? posterPath;
  String? mediaType;
  String? originalLanguage;
  List<int>? genreIds;
  double? popularity;
  String? releaseDate;
  bool? video;
  double? voteAverage;
  int? voteCount;
  String? name;
  String? originalName;
  String? firstAirDate;
  List<String>? originCountry;

  ExploreModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.title,
    this.originalTitle,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.originalLanguage,
    this.genreIds,
    this.popularity,
    this.releaseDate,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.name,
    this.originalName,
    this.firstAirDate,
    this.originCountry,
  });

  ExploreModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    id = json['id'];
    title = json['title'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    posterPath = json['poster_path'];
    mediaType = json['media_type'];
    originalLanguage = json['original_language'];

    // SAFE LIST CAST
    genreIds = (json['genre_ids'] is List)
        ? (json['genre_ids'] as List)
              .whereType<num>()
              .map((e) => e.toInt())
              .toList()
        : [];

    popularity = _toDouble(json['popularity']);
    releaseDate = json['release_date'];
    video = json['video'];
    voteAverage = _toDouble(json['vote_average']);
    voteCount = (json['vote_count'] is num) ? json['vote_count'] : null;

    name = json['name'];
    originalName = json['original_name'];
    firstAirDate = json['first_air_date'];

    originCountry = (json['origin_country'] is List)
        ? (json['origin_country'] as List).map((e) => e.toString()).toList()
        : [];
  }

  Map<String, dynamic> toJson() {
    return {
      'adult': adult,
      'backdrop_path': backdropPath,
      'id': id,
      'title': title,
      'original_title': originalTitle,
      'overview': overview,
      'poster_path': posterPath,
      'media_type': mediaType,
      'original_language': originalLanguage,
      'genre_ids': genreIds,
      'popularity': popularity,
      'release_date': releaseDate,
      'video': video,
      'vote_average': voteAverage,
      'vote_count': voteCount,
      'name': name,
      'original_name': originalName,
      'first_air_date': firstAirDate,
      'origin_country': originCountry,
    };
  }

  double? _toDouble(dynamic v) {
    if (v == null) return null;
    if (v is num) return v.toDouble();
    if (v is String) return double.tryParse(v);
    return null;
  }
}
