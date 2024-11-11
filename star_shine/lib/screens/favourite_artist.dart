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
      {'id': '1', 'name': 'Salatiel', 'imageUrl': 'assets/images/artists/salatiel.png', 'genre': 'Afropop'},
      {'id': '2', 'name': 'Charlotte Dipanda', 'imageUrl': 'assets/images/artists/charllote.png', 'genre': 'Folk'},
      {'id': '3', 'name': 'Locko', 'imageUrl': 'assets/images/artists/locko.png', 'genre': 'R&B'},
      {'id': '4', 'name': 'Daphne', 'imageUrl': 'assets/images/artists/daphne.png', 'genre': 'Urban'},
      {'id': '5', 'name': 'Manu Dibango', 'imageUrl': 'assets/images/artists/dibango.png', 'genre': 'Jazz'},
      {'id': '6', 'name': 'Mr. Leo', 'imageUrl': 'assets/images/artists/leo.png', 'genre': 'Afrobeats'},
      {'id': '7', 'name': 'Blanche Bailly', 'imageUrl': 'assets/images/artists/baily.png', 'genre': 'Afropop'},
      {'id': '8', 'name': 'Stanley Enow', 'imageUrl': 'assets/images/artists/enow.png', 'genre': 'Hip Hop'},
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
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 32),
              ),
              child: const Text('Continue'),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }
}