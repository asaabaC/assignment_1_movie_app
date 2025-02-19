import 'api_services.dart';
import 'movie_model.dart';

class MovieService {
  final ApiService _apiService = ApiService();

  Future<List<Movie>> fetchLatestMovies() async {
    try {
      final response = await _apiService.get('/movie/now_playing');

      if (response.containsKey('results')) {
        List<dynamic> results = response['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Movies data not found');
      }
    } catch (error) {
      print('Movie Fetch Error: $error');
      throw Exception('Failed to fetch latest movies');
    }
  }
}
