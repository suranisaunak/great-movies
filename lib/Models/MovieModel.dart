class MovieModel {
  int id;
  String name;
  String year;
  String director;
  String mainStar;
  String description;
  int favoritedByUsers;
  List<String> genres;
  String thumbnail;

  MovieModel(
      {this.id,
      this.name,
      this.year,
      this.director,
      this.mainStar,
      this.description,
      this.favoritedByUsers,
      this.genres,
      this.thumbnail});

  MovieModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    year = json['year'];
    director = json['director'];
    mainStar = json['main_star'];
    description = json['description'];
    favoritedByUsers = json['favorited_by_users'];
    genres = json['genres'].cast<String>();
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['year'] = this.year;
    data['director'] = this.director;
    data['main_star'] = this.mainStar;
    data['description'] = this.description;
    data['favorited_by_users'] = this.favoritedByUsers;
    data['genres'] = this.genres;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}
