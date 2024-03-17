import 'package:flutter/material.dart';
import '../models/movieDetail.dart';
import '../screens/movieDetailPage.dart';
import '../services/apiService.dart';
import '../models/movie.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final Future<List<Movie>> popular = ApiService.getPopular();
  final Future<List<Movie>> nowPlaying = ApiService.getNowPlaying();
  final Future<List<Movie>> comingSoon = ApiService.getComingSoon();

  bool isLoading = true;

  Widget movieCard(BuildContext context, Movie movie) {
    final String imageUrl =
        'https://image.tmdb.org/t/p/w500${movie.backdropPath}';
    final String posterUrl =
        'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    return Container(
        constraints: const BoxConstraints(maxWidth: 175),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(
                          movieDetail: ApiService.getMovieDetail(movie.id),
                          posterPath: posterUrl,
                        )));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: const Offset(5, 0),
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ],
                  ),
                  child: Image.network(
                    imageUrl,
                    width: 175,
                    height: 175,
                    fit: BoxFit.cover,
                  )),
              Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ));
  }

  Widget popularCard(BuildContext context, Movie movie) {
    // return poster only with square with border radius
    final String imageUrl =
        'https://image.tmdb.org/t/p/w500${movie.backdropPath}';
    final String posterUrl =
        'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    return Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              offset: const Offset(5, 0),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(
                          movieDetail: ApiService.getMovieDetail(movie.id),
                          posterPath: posterUrl,
                        )));
          },
          child: Image.network(
            imageUrl,
            width: 360,
            height: 300,
            fit: BoxFit.cover,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(height: 75),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Popular',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                constraints: const BoxConstraints(maxHeight: 300),
                margin: const EdgeInsets.only(bottom: 20),
                child: FutureBuilder(
                    future: popular,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var movie = snapshot.data[index];
                            return popularCard(context, movie);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 20);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
            SizedBox(
              height: 20,
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'In Theaters Now',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: FutureBuilder(
                    future: nowPlaying,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var movie = snapshot.data[index];
                            return movieCard(context, movie);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 15);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
            Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Text(
                  'Coming Soon',
                  style: TextStyle(
                    color: Theme.of(context).textTheme.headline1!.color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            Container(
                constraints: const BoxConstraints(maxHeight: 250),
                child: FutureBuilder(
                    future: comingSoon,
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            var movie = snapshot.data[index];
                            return movieCard(context, movie);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(width: 10);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(child: Text('${snapshot.error}'));
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    })),
          ]),
        ));
  }
}
