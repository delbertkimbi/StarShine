// import 'package:star_shine/widgets/trending_topics.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:star_shine/constants/app_constants.dart';
import 'package:star_shine/screens/profile_screen.dart';
import 'package:star_shine/screens/shorts_screen.dart';
import 'package:star_shine/widgets/challenge_card.dart';
import 'package:star_shine/widgets/video_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with SingleTickerProviderStateMixin {
  final RxString activeTab = 'videos'.obs;
  final RxInt notificationCount = 3.obs;
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  final RxBool _showFloatingButton = true.obs;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _setupScrollListener();
  }

  void _setupScrollListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        _showFloatingButton.value = false;
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        _showFloatingButton.value = true;
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(),
      floatingActionButton: Obx(() => AnimatedScale(
        scale: _showFloatingButton.value ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: FloatingActionButton(
          onPressed: () {
            // Handle video upload
            _showUploadOptions(context);
          },
          child: const Icon(Icons.add),
        ),
      )),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: Row(
        children: [
          Image.asset(
            'assets/images/background.jpg',
            height: 30,
          ),
          const SizedBox(width: 8),
          const Text(
            AppConstants.appName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
      actions: [
        // Search Button
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            // Show search delegate
            showSearch(context: context, delegate: CustomSearchDelegate());
          },
        ),
        // Notifications
        Stack(
          alignment: Alignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () {
                _showNotificationsSheet(context);
              },
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Obx(() => notificationCount.value > 0
                  ? Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 20,
                  minHeight: 20,
                ),
                child: Text(
                  notificationCount.value.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              )
                  : const SizedBox()),
            ),
          ],
        ),
        // Profile Picture
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ArtistProfileScreen(),
                ),
              );
            },
            child: Hero(
              tag: 'profile-pic',
              child: CircleAvatar(
                radius: 18,
                backgroundImage: const CachedNetworkImageProvider(
                  'https://',
                ),
                backgroundColor: Colors.grey[300],
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(96),
        child: Column(
          children: [
            // Trending Topics
            SizedBox(
              height: 48,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: trendingTopics.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Chip(
                      label: Text(trendingTopics[index]),
                      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                    ),
                  );
                },
              ),
            ),
            // Tab Bar
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: 'Videos'),
                Tab(text: 'Challenges'),
              ],
              onTap: (index) {
                activeTab.value = index == 0 ? 'videos' : 'challenges';
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 1));
      },
      child: TabBarView(
        controller: _tabController,
        children: [
          _buildVideosFeed(),
          _buildChallengesFeed(),
        ],
      ),
    );
  }

  Widget _buildVideosFeed() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: dummyVideos.length + 1, // +1 for featured section
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildFeaturedSection();
        }
        final video = dummyVideos[index - 1];
        return VideoCard(
          title: video['title'] as String,
          artist: video['artist'] as String,
          thumbnailUrl: video['thumbnailUrl'] as String,
          views: 1500000,
          likes: 250000,
          description: "df" ,
          uploadDate: DateTime.now().subtract(const Duration(days: 2)),
          duration: const Duration(minutes: 2, seconds: 45),
          onTap: () => _navigateToVideo(context, video),
          onShare: () => _shareVideo(video),
          onLike: () => _likeVideo(video),
        );
      },
    );
  }

  Widget _buildFeaturedSection() {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16),
      child: PageView.builder(
        itemCount: featuredVideos.length,
        itemBuilder: (context, index) {
          final featured = featuredVideos[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: CachedNetworkImageProvider(featured['thumbnailUrl'] as String),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    featured['title'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    featured['artist'] as String,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChallengesFeed() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: dummyChallenges.length,
      itemBuilder: (context, index) {
        final challenge = dummyChallenges[index];
        return ChallengeCard(
          title: challenge['title'] as String,
          artist: challenge['artist'] as String,
          mediaUrl: challenge['mediaUrl'] != null ? challenge['mediaUrl']  as String : "",
          isVideo: challenge['isVideo'] as bool, // true for videos, false for images
          participants: challenge['participants'] as int,
          daysLeft: challenge['daysLeft'] as int,
          prizeAmount: challenge['prizeAmount'] as double,
          onJoin: () => _joinChallenge(challenge),
          onShare: () => _shareChallenge(challenge),
        );
      },
    );
  }

  void _showNotificationsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                height: 4,
                width: 40,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Notifications',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  itemCount: notifications.length,
                  itemBuilder: (context, index) {
                    final notification = notifications[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: CachedNetworkImageProvider(
                          notification['avatarUrl'] as String,
                        ),
                      ),
                      title: Text(notification['message'] as String),
                      subtitle: Text(
                        notification['time'] as String,
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                      onTap: () {
                        // Handle notification tap
                        Navigator.pop(context);
                        _handleNotificationTap(notification);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showUploadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.video_library),
            title: const Text('Upload Video'),
            onTap: () {
              Navigator.pop(context);
              // Handle video upload
            },
          ),
          ListTile(
            leading: const Icon(Icons.camera_alt),
            title: const Text('Record Video'),
            onTap: () {
              Navigator.pop(context);
              // Handle video recording
            },
          ),
        ],
      ),
    );
  }

  // Navigation and action methods
  void _navigateToVideo(BuildContext context, Map<String, dynamic> video) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ShortsScreen(videoId: video['id'] as String),
      ),
    );
  }

  void _shareVideo(Map<String, dynamic> video) {
    // Implement share functionality
  }

  void _likeVideo(Map<String, dynamic> video) {
    // Implement like functionality
  }

  void _joinChallenge(Map<String, dynamic> challenge) {
    // Implement join challenge functionality
  }

  void _shareChallenge(Map<String, dynamic> challenge) {
    // Implement share challenge functionality
  }

  void _handleNotificationTap(Map<String, dynamic> notification) {
    // Handle different types of notifications
  }
}

// Custom Search Delegate
class CustomSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement search results
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement search suggestions
    return Container();
  }
}

// Dummy data
final List<String> trendingTopics = [
  '#DanceChallenge',
  '#NewMusic',
  '#Trending',
  '#Viral',
  '#Popular',
];

final List<Map<String, dynamic>> notifications = [
  {
    'avatarUrl': 'https://example.com/avatar1.jpg',
    'message': 'John liked your video',
    'time': '2m ago',
  },
  // Add more notifications...
];

final List<Map<String, dynamic>> featuredVideos = [
  {
    'title': 'Amazing Dance Performance',
    'artist': 'Dance Pro',
    'thumbnailUrl': 'https://example.com/featured1.jpg',
  },
  // Add more featured videos...
];