import 'dart:convert';
import 'package:http/http.dart' as http;

class YoutubeService {
  final String _apiKey = "AIzaSyAI-2g4-3e2FQGWvvnV-PjMqFenxZFbfQM"; 

  Future<List<dynamic>> fetchTutorials(String productName) async {
    final String query = Uri.encodeComponent("$productName makeup tutorial");
    
    final String url = 
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$query&maxResults=3&type=video&key=$_apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['items']; 
      } else {
        print("Greška sa YouTube API-jem: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      print("Greška pri konekciji: $e");
      return [];
    }
  }
}