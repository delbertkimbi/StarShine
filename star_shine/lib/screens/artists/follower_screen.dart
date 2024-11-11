import 'package:flutter/material.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample data, replace with actual follower data from the server
    final List<String> followers = [
      'Follower 1',
      'Follower 2',
      'Follower 3',
      'Follower 4',
      'Follower 5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Followers'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: followers.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://placekitten.com/200/200'), // Replace with follower profile images
            ),
            title: Text(followers[index]),
            subtitle: Text('Followed by ${followers[index]}'),
            onTap: () {
              // Navigate to follower's profile
            },
          );
        },
      ),
    );
  }
}
