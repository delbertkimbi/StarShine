// lib/screens/favorite_artists.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/screens/main_screen.dart';
import 'package:star_shine/widgets/artist_card.dart';

class FavoriteArtists extends StatelessWidget {
  const FavoriteArtists({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedArtists = <String>[].obs;

    final dummyArtists = [
      {'id': '1', 'name': 'Salatiel', 'imageUrl': 'https://example.com/salatiel.jpg', 'genre': 'Afropop'},
      {'id': '2', 'name': 'Charlotte Dipanda', 'imageUrl': 'https://example.com/charlotte.jpg', 'genre': 'Folk'},
      {'id': '3', 'name': 'Locko', 'imageUrl': 'https://example.com/locko.jpg', 'genre': 'R&B'},
      {'id': '4', 'name': 'Daphne', 'imageUrl': 'https://example.com/daphne.jpg', 'genre': 'Urban'},
      {'id': '5', 'name': 'Manu Dibango', 'imageUrl': 'https://example.com/manu.jpg', 'genre': 'Jazz'},
      {'id': '6', 'name': 'Mr. Leo', 'imageUrl': 'https://example.com/mrleo.jpg', 'genre': 'Afrobeats'},
      {'id': '7', 'name': 'Blanche Bailly', 'imageUrl': 'https://example.com/blanche.jpg', 'genre': 'Afropop'},
      {'id': '8', 'name': 'Stanley Enow', 'imageUrl': 'https://example.com/stanley.jpg', 'genre': 'Hip Hop'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Choose Your Favorite Artists')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: dummyArtists.length,
              itemBuilder: (context, index) {
                final artist = dummyArtists[index];
                return ArtistCard(
                  id: artist['id']!,
                  name: artist['name']!,
                  imageUrl: artist['imageUrl']!,
                  genre: artist['genre']!,
                  selectedArtists: selectedArtists,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedArtists.isNotEmpty) {
                  // TODO: Save selected artists
                  Get.offAll(() => const MainScreen());
                } else {
                  Get.snackbar(
                    'Error',
                    'Please select at least one artist',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Continue'),
            ),
          ),
        ],
      ),
    );
  }
}