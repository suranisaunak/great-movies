import 'package:flutter/material.dart';
import 'dart:async' show Future;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:greatmovie/Models/MovieModel.dart';
import 'package:greatmovie/Utils/apis.dart';

class MovieProvider with ChangeNotifier {
  MovieProvider() {
    movieList();
  }

  Future movieList() async {
    movieListData().then((movieList) {
      setisListLoadingFalse();
      notifyListeners();
    }).catchError((e) {
      setisListLoadingFalse();
      isMovieListError = true;
      print(e);
      notifyListeners();
    });
  }

// fetch movie list
  List<MovieModel> _movieList = [];

  getMovieList() => _movieList;

  bool isMovieListLoading = false;

  getisListLoading() => isMovieListLoading;

  bool isMovieListError = false;

  setMovieListErrorFalse() => isMovieListError = false;

  getListError() => isMovieListError;

  setisListLoadingFalse() => isMovieListLoading = false;

  Future<List<MovieModel>> movieListData() async {
    _movieList = [];

    isMovieListLoading = true;

    notifyListeners();
    var response = await http.get(Uri.parse(getAllMovies), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }).catchError((onError) {
      isMovieListLoading = false;
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (var item in data['data']['movies']) {
        MovieModel movie = new MovieModel.fromJson(item);
        _movieList.add(movie);
      }

      setisListLoadingFalse();
      notifyListeners();
      return _movieList;
    } else {
      return _movieList;
    }
  }

// to simply the genre array
  String simplyfiedGenres({@required List<String> genres}) {
    String genreString = "";
    if (genres.length != 0) {
      for (var item in genres) {
        genreString = "${item + ' / ' + item}";
      }
    }
    return genreString;
  }

// to get sub string for Description
  String getSubDescrioption({String message}) {
    if (message.length <= 100) {
      return message;
    } else {
      return message.substring(0, 100) + ".......";
    }
  }

  // thumbnail modification

  String thumb({@required String thumbUrl}) {
    String result = thumbUrl.replaceAll("thumb/", "medium/");

    return result;
  }
}
