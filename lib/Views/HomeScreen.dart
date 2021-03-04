import 'package:flutter/material.dart';
import 'package:greatmovie/Controllers/MoviesProvider.dart';
import 'package:greatmovie/Controllers/connectivityProvider.dart';
import 'package:greatmovie/Models/MovieModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:greatmovie/Views/movieDetails.dart';
import 'package:greatmovie/Widgets/loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MovieModel> _movieList = [];

  bool isInternet = true;
  Future demo() async {}
  @override
  void initState() {
    final connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);

    connectivityProvider.checkInternet().then((internet) {
      isInternet = internet;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    final movieProvider = Provider.of<MovieProvider>(context);

    _movieList = movieProvider.getMovieList();
    final connectionProvider = Provider.of<ConnectivityProvider>(context);
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () {
        connectionProvider.checkInternet().then((internet) {
          setState(() {
            isInternet = internet;
          });
          if (internet == true) {
            setState(() {
              _movieList = [];
            });
            return movieProvider.movieList();
          }
        });
        return demo();
      },
      child: Container(
        height: height,
        width: width,
        child: Column(
          children: [
            SizedBox(
              height: height * 0.07,
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "Great Movie",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                child: isInternet == true
                    ? movieProvider.getListError() == false
                        ? movieProvider.getisListLoading() == false
                            ? AnimationLimiter(
                                child: ListView.builder(
                                  //  shrinkWrap: true,
                                  //   physics: NeverScrollableScrollPhysics(),
                                  itemCount: _movieList.length,
                                  itemBuilder: (context, index) {
                                    return AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      child: SlideAnimation(
                                        verticalOffset: 44.0,
                                        child: FadeInAnimation(
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MovieDetails(
                                                          movie:
                                                              _movieList[index],
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 5),
                                              width: width,
                                              height: height * 0.25,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                        blurRadius: 2,
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        offset: Offset(0, 0),
                                                        spreadRadius: 2)
                                                  ]),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: width * 0.35,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          movieProvider.thumb(
                                                              thumbUrl:
                                                                  _movieList[
                                                                          index]
                                                                      .thumbnail),
                                                      imageBuilder: (context,
                                                              imageProvider) =>
                                                          Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius: BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(10),
                                                              bottomLeft: Radius
                                                                  .circular(10),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          40)),
                                                          image:
                                                              DecorationImage(
                                                            image:
                                                                imageProvider,
                                                            fit: BoxFit.cover,
                                                            /* colorFilter:
                                                                ColorFilter.mode(
                                                                    Colors.red,
                                                                    BlendMode
                                                                        .colorBurn) */
                                                          ),
                                                        ),
                                                      ),
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                              child:
                                                                  CircularProgressIndicator()),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Center(
                                                              child: Icon(
                                                                  Icons.error)),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height * 0.25,
                                                    width: width * 0.5,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 8,
                                                            vertical: 4),
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          _movieList[index]
                                                              .name,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          // textAlign: TextAlign.center,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 4),
                                                          child: Text(
                                                            _movieList[index]
                                                                .year,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            //  textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 4),
                                                          child: Text(
                                                            movieProvider
                                                                .simplyfiedGenres(
                                                                    genres: _movieList[
                                                                            index]
                                                                        .genres),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            // textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal: 4,
                                                                  vertical: 10),
                                                          child: Text(
                                                            movieProvider.getSubDescrioption(
                                                                message: _movieList[
                                                                        index]
                                                                    .description),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color:
                                                                  Colors.black,
                                                            ),
                                                            // textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : Center(child: Loader())
                        : Center(
                            child: Text(
                                "Oops.. Some Error occured.\nPlease try later"))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.3,
                          ),
                          Container(
                            child: Text("Looks like no internet available"),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          FlatButton(
                            color: Colors.blue,
                            onPressed: () {
                              connectionProvider
                                  .checkInternet()
                                  .then((internet) {
                                print(internet);

                                //   if (internet == true) {

                                setState(() {
                                  isInternet = internet;
                                });
                                if (internet == true) {
                                  movieProvider.setMovieListErrorFalse();
                                  movieProvider.movieList();
                                }
                                //  }
                              });
                            },
                            child: Text(
                              "Try Again",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      )),
          ],
        ),
      ),
    ));
  }
}
