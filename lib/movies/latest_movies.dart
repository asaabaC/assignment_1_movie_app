import 'package:flutter/material.dart';
import 'movie_services.dart';
import 'movie_model.dart';

class LatestMovies extends StatelessWidget {
  final MovieService movieService = MovieService();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: movieService.fetchLatestMovies(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No movies found.'));
        }

        final movies = snapshot.data!;

        return SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              final imageUrl = movie.posterPath.isNotEmpty
                  ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                  : 'https://via.placeholder.com/150';

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    width: 150,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
