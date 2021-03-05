import 'package:flutter/material.dart';
import 'package:greatmovie/Controllers/MoviesProvider.dart';
import 'package:greatmovie/Controllers/connectivityProvider.dart';
import 'package:greatmovie/Models/MovieModel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:greatmovie/Views/tablet/TabMovieDetails.dart';
import 'package:greatmovie/Widgets/loader_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class TabHomeScreen extends StatefulWidget {
  @override
  _TabHomeScreenState createState() => _TabHomeScreenState();
}

class _TabHomeScreenState extends State<TabHomeScreen> {
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
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

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
                      style: TextStyle(
                          fontSize: isPortrait ? 30 : 30,
                          fontWeight: FontWeight.bold),
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
                                                        TabMovieDetails(
                                                          movie:
                                                              _movieList[index],
                                                        )),
                                              );
                                            },
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 5),
                                              width: width,
                                              height: isPortrait
                                                  ? height * 0.33
                                                  : height * 0.5,
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
                                                    width: isPortrait
                                                        ? width * 0.35
                                                        : height * 0.35,
                                                    child: Hero(
                                                      tag: _movieList[index].id,
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            movieProvider.thumb(
                                                                thumbUrl: _movieList[
                                                                        index]
                                                                    .thumbnail),
                                                        imageBuilder: (context,
                                                                imageProvider) =>
                                                            Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius: BorderRadius.only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        60)),
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
                                                                child: Icon(Icons
                                                                    .error)),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: height * 0.35,
                                                    width: width * 0.63,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 20),
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
                                                              fontSize:
                                                                  isPortrait
                                                                      ? 35
                                                                      : 40,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          // textAlign: TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: isPortrait
                                                              ? height * 0.012
                                                              : height * 0.02,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                width * 0.01,
                                                          ),
                                                          child: Text(
                                                            _movieList[index]
                                                                .year,
                                                            style: TextStyle(
                                                              fontSize:
                                                                  isPortrait
                                                                      ? 30
                                                                      : 30,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            //  textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.012,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                width * 0.01,
                                                          ),
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
                                                              fontSize:
                                                                  isPortrait
                                                                      ? 30
                                                                      : 30,
                                                              color:
                                                                  Colors.grey,
                                                            ),
                                                            // textAlign: TextAlign.center,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.017,
                                                        ),
                                                        Container(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                            horizontal:
                                                                width * 0.01,
                                                          ),
                                                          child: Text(
                                                            movieProvider.getSubDescrioption(
                                                                message: _movieList[
                                                                        index]
                                                                    .description),
                                                            /*  overflow:
                                                                TextOverflow
                                                                    .ellipsis, */
                                                            style: TextStyle(
                                                                fontSize:
                                                                    isPortrait
                                                                        ? 25
                                                                        : 25,
                                                                color: Colors
                                                                    .black,
                                                                height: 1.7),
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
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.3,
                              ),
                              Container(
                                child: Text(
                                  "Oops...\n\nSome error occured. Please try again later.",
                                  style: TextStyle(
                                    fontSize: isPortrait ? 30 : 30,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(
                                height: height * 0.1,
                              ),
                              FlatButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 15),
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ],
                          )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: height * 0.3,
                          ),
                          Container(
                            child: Text(
                              "Looks like no internet available",
                              style: TextStyle(
                                fontSize: isPortrait ? 30 : 30,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.1,
                          ),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 15),
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
                                  //   movieProvider.setMovieListErrorFalse();
                                  movieProvider.movieList();
                                }
                                //  }
                              });
                            },
                            child: Text(
                              "Try Again",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
