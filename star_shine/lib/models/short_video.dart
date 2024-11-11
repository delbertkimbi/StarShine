// models/short_video.dart
class ShortVideo {
  final String id;
  final String videoUrl;
  final String audioUrl;
  final String username;
  final String profileImageUrl;
  final String songTitle;
  final String artistName;
  final List<String> genreTags;
  final String lyrics;
  final int likes;
  final int comments;
  final int shares;

  ShortVideo({
    required this.id,
    required this.videoUrl,
    required this.audioUrl,
    required this.username,
    required this.profileImageUrl,
    required this.songTitle,
    required this.artistName,
    required this.genreTags,
    required this.lyrics,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}
