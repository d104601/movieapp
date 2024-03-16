import 'package:flutter/material.dart';
import '../services/apiService.dart';
import '../models/movie.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final Future<List<Movie>> popular = ApiService.getPopular();
  final Future<List<Movie>> nowPlaying = ApiService.getNowPlaying();
  final Future<List<Movie>> commingSoon = ApiService.getCommingSoon();

  bool isLoading = true;

  Widget movieCard(BuildContext context, Movie movie) {
    final String imageUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}';
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: 150,
            height: 200,
            fit: BoxFit.cover,
          ),
          Text(
            movie.title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }

  Widget popularCard(BuildContext context, Movie movie) {
    // return poster only with square with circular border
    final String imageUrl = 'https://image.tmdb.org/t/p/w500${movie.backdropPath}';
    return Container(
      margin: const EdgeInsets.only(right: 10, left: 10),
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover,

          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 2,
            child: Text(
              'Popular',
              style: TextStyle(
                color: Theme.of(context).textTheme.headline1!.color,

                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            )
          ),
          Flexible(
            flex: 3,
            child: FutureBuilder(
                future: popular,
                builder: (context, AsyncSnapshot snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        var movie = snapshot.data[index];
                        return popularCard(context, movie);
                      },
                    );
                  }
                  else if(snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
            )
          ),
          Flexible(
              flex: 2,
              child: Text(
                'In Theaters Now',
                style: TextStyle(
                  color: Theme.of(context).textTheme.headline1!.color,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              )
          ),
          Flexible(
              flex: 3,
              child: FutureBuilder(
                  future: nowPlaying,
                  builder: (context, AsyncSnapshot snapshot) {
                    if(snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          var movie = snapshot.data[index];
                          return movieCard(context, movie);
                        },
                      );
                    }
                    else if(snapshot.hasError) {
                      return Center(child: Text('${snapshot.error}'));
                    }
                    else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }
              )
          ),
        ]
      ),
    );
  }
}
