// lib/widgets/artist_card.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArtistCard extends StatelessWidget {
  final String id;
  final String name;
  final String imageUrl;
  final String genre;
  final RxList<String> selectedArtists;

  const ArtistCard({
    super.key,
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.genre,
    required this.selectedArtists,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = selectedArtists.contains(id);
      return GestureDetector(
        onTap: () {
          if (isSelected) {
            selectedArtists.remove(id);
          } else {
            selectedArtists.add(id);
          }
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                      child: Image.asset(imageUrl, fit: BoxFit.cover)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          genre,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF4ECDC4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              if (isSelected)
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 12,
                    child: const Icon(Icons.check, size: 16, color: Colors.white),
                  ),
                ),
            ],
          ),
        )
    );});
  }
}