// lib/screens/favorite_artists.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/widgets/artist_card.dart';

class FavoriteArtists extends StatelessWidget {
  const FavoriteArtists({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedArtists = <String>[].obs;


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
                  Get.offNamed('/users/mains');
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