import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_bloc.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';
import '../../../../core/utils/constants.dart';
import 'movie_detail_screen.dart';

class PopularMoreScreen extends StatefulWidget {
  const PopularMoreScreen({Key? key}) : super(key: key);

  @override
  State<PopularMoreScreen> createState() => _PopularMoreScreenState();
}

class _PopularMoreScreenState extends State<PopularMoreScreen> {
  ScrollController listController = ScrollController();
  @override
  void initState() {
    super.initState();
    repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    listController.dispose();
  }

  void repeat() {
    listController.addListener(() {
      // this listController.position.atEdge will be true if listview is at bottom  or top
      if (listController.position.atEdge) {
        if (listController.position.pixels != 0) {
          BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        final movieList = BlocProvider.of<MoviesBloc>(context).popularMovies;
        return Scaffold(
            appBar: AppBar(
              title: Text(
                'popular',
                style: Theme.of(context)
                    .appBarTheme
                    .titleTextStyle!
                    .copyWith(fontSize: 20),
              ),
            ),
            body: FadeIn(
              duration: Duration(milliseconds: 900),
              child: Column(
                children: [
                  Expanded(
                    child: GridView.builder(
                        controller: listController,
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 10,
                                childAspectRatio: 3 / 2.3),
                        itemCount: movieList.length,
                        itemBuilder: (context, index) {
                          final movie = movieList[index];
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(builder: (context) {
                                        return MovieDetailScreen(id: movie.id);
                                      }));
                                    },
                                    child: Container(
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: concatImagePath(
                                            movie.backdropPath!),
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                          baseColor: Colors.grey[850]!,
                                          highlightColor: Colors.grey[300]!,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.49,
                                            decoration: BoxDecoration(
                                              color: Colors.black,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                  FittedBox(
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.49,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 3),
                                      decoration: BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius:
                                              BorderRadius.circular(8.0)),
                                      child: Center(
                                        child: Text(
                                          movie.title,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child:
                                        Text(movie.releaseDate.split('-')[0]),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(
                                            color: Colors.white24, width: 1),
                                        color: Colors.black12),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 3, vertical: 2),
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: Colors.yellow,
                                      ),
                                      Text(
                                        (movie.voteAverage / 2)
                                            .toStringAsFixed(1),
                                        style: GoogleFonts.oleoScriptSwashCaps(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          );
                        }),
                  ),
                  if (state is LoadingGetPopularMoviesState)
                    Center(
                      child: CircularProgressIndicator(),
                    )
                ],
              ),
            ));
      },
    );
  }
}
/*
*  InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return MovieDetailScreen(id: movie.id);
                }));
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: concatImagePath(movie.backdropPath!),
                      placeholder: (context, url) => Shimmer.fromColors(
                        baseColor: Colors.grey[850]!,
                        highlightColor: Colors.grey[800]!,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    FittedBox(
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Center(
                          child: Text(
                            movie.title,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
*
* */
