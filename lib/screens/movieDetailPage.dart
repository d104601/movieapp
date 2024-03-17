import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/movieDetail.dart';

class MovieDetailPage extends StatelessWidget {
  Future<MovieDetail> movieDetail;
  String posterPath;

  MovieDetailPage(
      {super.key, required this.movieDetail, required this.posterPath});

  String getStars(double voteAverage) {
    String stars = '';
    for (int i = 0; i < 5; i++) {
      if (voteAverage / 2 > i) {
        // full star
        stars += '★';
      } else {
        // empty star
        stars += '☆';
      }
    }
    return stars;
  }

  String runtimeAndGenre(int minutes, List<Genre> genres) {
    int hours = minutes ~/ 60;
    int mins = minutes % 60;
    String time = '';
    if (hours > 0) {
      time += '$hours h ';
    }
    time += '$mins min | ';
    for (int i = 0; i < genres.length; i++) {
      time += genres[i].name;
      if (i < genres.length - 1) {
        time += ', ';
      }
    }
    return time;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text(
            'Back to List',
            style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  offset: Offset(0, 1),
                  blurRadius: 3.0,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ],
            ),
          ),
          centerTitle: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(posterPath),
                fit: BoxFit.cover,
                // 조금 흐리게
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.5),
                  BlendMode.darken,
                ),
              ),
            ),
            child: FutureBuilder<MovieDetail>(
              future: movieDetail,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 200),

                            Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            // 평점
                            Text(
                              getStars(snapshot.data!.vote_average),
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.yellow,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            Text(
                                runtimeAndGenre(snapshot.data!.runtime,
                                    snapshot.data!.genres),
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                )),

                            const SizedBox(height: 25),

                            const Text("Overview",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 3.0,
                                      color: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                  ],
                                )),

                            const SizedBox(height: 10),

                            Text(
                              snapshot.data!.overview,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 3.0,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 50),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          onPrimary: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                        ),
                        onPressed: () {
                          launchUrl(snapshot.data!.homepage as Uri);
                        },
                        child: const Text('Buy Ticket or Watch now'),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
