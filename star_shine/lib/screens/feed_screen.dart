import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:star_shine/widgets/challenge.dart';
import 'package:star_shine/widgets/challenge_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _ChallengeFeedScreenState();
}

class _ChallengeFeedScreenState extends State<FeedScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;
  List<Challenge> _challenges = [];

  @override
  void initState() {
    super.initState();
    _loadChallenges();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _loadChallenges() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    // Simulate API call with dummy data
    await Future.delayed(const Duration(seconds: 1));
    final newChallenges = [
      Challenge(
        id: '1',
        title: 'Dance Challenge',
        artistName: 'Sarah Dance',
        artistImageUrl: 'https://placeholder.com/artist1',
        thumbnailUrl: 'https://placeholder.com/thumbnail1',
        videoUrl: 'https://placeholder.com/video1',
        participants: 1500,
        daysLeft: 5,
        prizeMoney: 1000,
        prizeDescription: 'Win \$1000 and a chance to perform live!',
        description: 'Show us your best dance moves!',
        rules: [
          'Video must be 30-60 seconds',
          'Original choreography only',
          'Family-friendly content'
        ],
        audioUrl: 'https://placeholder.com/audio1',
        endDate: DateTime.now(),
      ),
      // Add more dummy challenges as needed
    ];

    setState(() {
      _challenges.addAll(newChallenges);
      _isLoading = false;
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadChallenges();
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      _challenges.clear();
    });
    await _loadChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildFilterSection(),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                color: Colors.orange.shade400,
                child: ListView.builder(
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _challenges.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _challenges.length) {
                      return _buildLoadingIndicator();
                    }
                    return ChallengeCard(challenge: _challenges[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildAppBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            'Challenges',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              // Implement notifications
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildFilterChip('All', true),
            _buildFilterChip('Dance', false),
            _buildFilterChip('Music', false),
            _buildFilterChip('Acting', false),
            _buildFilterChip('Comedy', false),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        labelStyle: GoogleFonts.inter(
          color: isSelected ? Colors.white : Colors.grey[800],
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: Colors.white,
        selectedColor: Colors.orange.shade400,
        checkmarkColor: Colors.white,
        side: BorderSide(
          color: isSelected ? Colors.transparent : Colors.grey.shade300,
        ),
        onSelected: (bool selected) {
          // Implement filter logic
        },
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return _isLoading
        ? Container(
            padding: const EdgeInsets.all(16),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          )
        : const SizedBox.shrink();
  }

  Widget _buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        // Implement create challenge functionality
      },
      backgroundColor: Colors.orange.shade400,
      child: const Icon(Icons.add),
    );
  }
}
