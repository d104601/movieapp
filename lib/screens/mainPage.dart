import 'package:flutter/material.dart';
import '../services/apiService.dart';
import '../models/movie.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  Future<List<Movie>> popular = ApiService.getPopular();
  Future<List<Movie>> nowPlaying = ApiService.getNowPlaying();

  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          '',
          style: TextStyle(
            color: Theme.of(context).textTheme.headline1!.color,
          ),
        ),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child:
              Column(
                children: [
                  Text(
                    'Popular Movies',
                    style: TextStyle(
                      color: Theme.of(context).textTheme.headline1!.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder(
                    future: popular,
                    builder: (context, snapshot) {
                      if(snapshot.hasData) {
                        return Text('Data: ${snapshot.data}');
                      }
                      else if(snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      }
                      else {
                        return Text('Loading...');
                      }
                    }
                  )
                ],
              )
            )
        ]
      ),
    );
  }
}
