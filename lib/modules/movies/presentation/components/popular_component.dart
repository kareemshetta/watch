import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_bloc.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_events.dart';
import 'package:watch/modules/movies/presentation/controllers/movies_states.dart';
import '../../../../core/utils/constants.dart';
import '../screens/movie_detail_screen.dart';

class PopularComponent extends StatefulWidget {
  PopularComponent({Key? key}) : super(key: key);

  @override
  State<PopularComponent> createState() => _PopularComponentState();
}

class _PopularComponentState extends State<PopularComponent> {
  ScrollController scrollController = ScrollController();

  void setUpScrollController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >
          (scrollController.position.maxScrollExtent)) {
        BlocProvider.of<MoviesBloc>(context).add(GetPopularMoviesEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(buildWhen: (previous, current) {
      return previous != current;
    }, builder: (context, state) {
      if (state is FirstLoadingGetPopularMoviesState) {
        return const SizedBox(
          height: 170,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else if (state is GetPopularErrorState) {
        return const SizedBox(
          height: 170,
          child: Center(
            child: Text('check your connection'),
          ),
        );
      } else {
        final moviesList = BlocProvider.of<MoviesBloc>(context).popularMovies;
        return FadeIn(
          duration: const Duration(milliseconds: 500),
          child: SizedBox(
            height: 170.0,
            child: ListView.builder(
              controller: scrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: moviesList.length,
              itemBuilder: (context, index) {
                final movie = moviesList[index];
                return Container(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetailScreen(id: moviesList[index].id);
                          },
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(8.0)),
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          CachedNetworkImage(
                            width: 120.0,
                            height: 170,
                            fit: BoxFit.cover,
                            imageUrl: concatImagePath(movie.backdropPath!),
                            placeholder: (context, url) => Shimmer.fromColors(
                              baseColor: Colors.grey[850]!,
                              highlightColor: Colors.grey[800]!,
                              child: Container(
                                height: 170.0,
                                width: 120.0,
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
                              width: 120,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(8.0)),
                              child: Center(
                                child: Text(
                                  movie.title,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      }
    });
  }
}
