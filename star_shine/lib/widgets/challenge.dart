// lib/models/challenge.dart

class Challenge {
  final String id;
  final String title;
  final String artistName;
  final String artistImageUrl;
  final String description;
  final String prizeDescription;
  final String videoUrl;
  final String audioUrl;
  final int participants;
  final int daysLeft;
  final String thumbnailUrl;
  final DateTime endDate;
  final List<String> rules;
  final double prizeMoney;

  Challenge({
    required this.id,
    required this.title,
    required this.artistName,
    required this.artistImageUrl,
    required this.description,
    required this.prizeDescription,
    required this.videoUrl,
    required this.audioUrl,
    required this.participants,
    required this.daysLeft,
    required this.thumbnailUrl,
    required this.endDate,
    required this.rules,
    required this.prizeMoney,
  });

  // Factory method to create Challenge from JSON
  factory Challenge.fromJson(Map<String, dynamic> json) {
    return Challenge(
      id: json['id'],
      title: json['title'],
      artistName: json['artistName'],
      artistImageUrl: json['artistImageUrl'],
      description: json['description'],
      prizeDescription: json['prizeDescription'],
      videoUrl: json['videoUrl'],
      audioUrl: json['audioUrl'],
      participants: json['participants'],
      daysLeft: json['daysLeft'],
      thumbnailUrl: json['thumbnailUrl'],
      endDate: DateTime.parse(json['endDate']),
      rules: List<String>.from(json['rules']),
      prizeMoney: json['prizeMoney'].toDouble(),
    );
  }
}
