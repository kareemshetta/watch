import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watch/core/utils/constants.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_bloc.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';
import 'package:watch/modules/movies/presentation/screens/movie_detail_screen.dart';

import 'package:watch/modules/movies/domain/entities/movie.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final listController = ScrollController();
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    repeat();
  }

  void repeat() {
    listController.addListener(() {
      // this listController.position.atEdge will be true if listview is at bottom  or top
      if (listController.position.atEdge) {
        if (listController.position.pixels != 0) {
          print('done');
          BlocProvider.of<MoviesBloc>(context)
              .add(GetSearchForMovieMoviesEvent(textController.text));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              BlocProvider.of<MoviesBloc>(context)
                  .add(GetClearSearchedListEvent());
              Navigator.of(context).pop();
            }),
        actions: [
          const SizedBox(width: 50),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(
                top: 7,
                bottom: 7,
                right: 30,
                left: 20,
              ),
              child: TextField(
                controller: textController,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: Colors.white,
                onSubmitted: (value) {
                  BlocProvider.of<MoviesBloc>(context)
                      .add(GetClearSearchedListEvent());
                  textController.text = value;
                  BlocProvider.of<MoviesBloc>(context)
                      .add(GetSearchForMovieMoviesEvent(value));
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 20),
                  focusColor: Colors.teal,
                  suffixIcon: const Icon(Icons.search, color: Colors.white),
                  hintText: 'search for movie',
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 2.0),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ),
        ],
        // title: const Text('Search'),
      ),
      body: SafeArea(
        child: BlocBuilder<MoviesBloc, MoviesState>(builder: (context, state) {
          final searchedList =
              BlocProvider.of<MoviesBloc>(context).searchedMovies;
          if (searchedList.isEmpty && state is GetClearSearchedListState) {
            return Center(
              child: Text(''),
            );
          } else {
            if (searchedList.isEmpty &&
                state is FirstLoadingSearchForMoviesState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetSearchForErrorState) {
              return Center(
                child: Text('something went wrong'),
              );
            } else if (state is GetClearSearchedListState) {
              return Center(
                child: Text(''),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Result (${searchedList.length})',
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: FadeIn(
                        duration: const Duration(milliseconds: 900),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: listController,
                                itemCount: searchedList.length,
                                itemBuilder: (context, index) {
                                  return buildContainer(height, width,
                                      searchedList[index], context);
                                },
                              ),
                            ),
                            if (state is LoadingSearchForMoviesState)
                              const Center(
                                child: CircularProgressIndicator(),
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
          }
        }),
      ),
    );
  }

  Widget buildContainer(
      double height, double width, Movie movie, BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return MovieDetailScreen(id: movie.id);
        }));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 5),
        height: height * 0.25,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                margin: EdgeInsets.only(right: 10),
                height: height * 0.25,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: CachedNetworkImage(
                  height: height * 0.25,
                  fit: BoxFit.cover,
                  imageUrl: concatImagePath(movie.backdropPath!),
                  placeholder: (context, url) {
                    return Shimmer.fromColors(
                        child: Container(
                          height: height * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        baseColor: Colors.grey[800]!,
                        highlightColor: Colors.grey[850]!);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.title,
                            style: GoogleFonts.cairo(
                              fontSize: 17,
                              height: 2,
                              fontWeight: FontWeight.w600,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2.0,
                            horizontal: 8.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(
                            movie.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 20.0,
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              (movie.voteAverage / 2).toStringAsFixed(1),
                              style: GoogleFonts.oleoScriptSwashCaps(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
