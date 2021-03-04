import 'package:flutter/material.dart';
import 'package:greatmovie/Controllers/MoviesProvider.dart';
import 'package:greatmovie/Models/MovieModel.dart';
import 'package:greatmovie/Utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class MovieDetails extends StatefulWidget {
  final MovieModel movie;
  MovieDetails({Key key, @required this.movie}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    final movieProvider = Provider.of<MovieProvider>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          height: height,
          width: width,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                  height: height * 0.5,
                  width: width,
                  child: widget.movie.thumbnail != ""
                      ? Stack(
                          children: [
                            ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                    sigmaY: 10,
                                    sigmaX:
                                        10), //SigmaX and Y are just for X and Y directions
                                child: Image.network(
                                  movieProvider.thumb(
                                      thumbUrl: widget.movie.thumbnail),
                                  fit: BoxFit.cover,
                                  height: height * 5,
                                  width: width,
                                ) //here you can use any widget you'd like to blur .
                                ),
                            Container(
                              height: height * 0.45,
                              child: CachedNetworkImage(
                                imageUrl: movieProvider.thumb(
                                    thumbUrl: widget.movie.thumbnail),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Center(child: Icon(Icons.error)),
                              ),
                            ),
                          ],
                        )
                      : Container(
                          color: Colors.grey,
                        )),
              Container(
                margin: EdgeInsets.only(
                  top: height * 0.45,
                ),
                //  height: height * 0.5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 1,
                          color: Colors.grey.withOpacity(0.4),
                          offset: Offset(0, 0),
                          spreadRadius: 2)
                    ]),
              ),
              Container(
                  margin:
                      EdgeInsets.only(top: height * 0.425, left: width * 0.1),
                  child: ListView(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          widget.movie.name,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          widget.movie.year,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                        child: Text(
                          movieProvider.simplyfiedGenres(
                              genres: widget.movie.genres),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      widget.movie.mainStar != ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 6),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'Main Actor :  ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      widget.movie.mainStar,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      widget.movie.director != ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 6),
                              child: Row(
                                children: [
                                  Container(
                                    child: Text(
                                      'Director :  ',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 12),
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Text(
                                      widget.movie.director,
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox(),
                      widget.movie.description != ""
                          ? Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 10),
                              child: Text(
                                "Description",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    height: 1.2),
                              ),
                            )
                          : SizedBox(),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 4, vertical: 10),
                        child: Text(
                          widget.movie.description,
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 1.1,
                              color: Colors.black,
                              height: 1.2),
                        ),
                      ),
                    ],
                  )),
              Positioned(
                top: 55,
                left: 15,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Card(
                    shape: CircleBorder(),
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Center(
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
