import 'package:flutter/material.dart';

class FeedDetailScreen extends StatefulWidget {
  @override
  State<FeedDetailScreen> createState() => _FeedDetailScreenState();
}

class _FeedDetailScreenState extends State<FeedDetailScreen> {
  bool isPlaying = false;
  bool isFavorite = false;
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Detail'),
        actions: [
          IconButton(
            icon: Icon(isFavorite ? Icons.bookmark : Icons.bookmark_border),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareFeed,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderImage(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildMetadata(),
                  const SizedBox(height: 16),
                  _buildContent(),
                  const SizedBox(height: 16),
                  if (isPlaying) _buildProgressBar(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _togglePlayback,
        icon: Icon(isPlaying ? Icons.stop : Icons.volume_up),
        label: Text(isPlaying ? 'Stop' : 'Read Aloud'),
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Stack(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          child: Image.asset(
            'assets/sample_image.jpg',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Icon(Icons.image_not_supported, size: 50),
              );
            },
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.7),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Feed Title',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildMetadata() {
    return Row(
      children: [
        const Icon(Icons.access_time, size: 16),
        const SizedBox(width: 4),
        Text(
          '5 mins read',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.remove_red_eye, size: 16),
        const SizedBox(width: 4),
        Text(
          '1.2K views',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detailed description goes here...',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
        SizedBox(height: 16),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
          style: TextStyle(fontSize: 16, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        LinearProgressIndicator(value: progress),
        const SizedBox(height: 8),
        Text(
          '${(progress * 100).toInt()}% complete',
          style: TextStyle(
            color: Theme.of(context).textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }

  void _togglePlayback() {
    setState(() {
      isPlaying = !isPlaying;
      if (isPlaying) {
        _startReading();
      } else {
        _stopReading();
      }
    });
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isFavorite ? 'Added to bookmarks' : 'Removed from bookmarks'),
          duration: const Duration(seconds: 2),
        ),
      );
    });
  }

  void _shareFeed() {
    // Implement share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sharing...'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _startReading() {
    // Simulate reading progress
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 100));
      if (!mounted || !isPlaying) return false;

      setState(() {
        progress = (progress + 0.01).clamp(0.0, 1.0);
      });

      return progress < 1.0;
    });
  }

  void _stopReading() {
    setState(() {
      progress = 0.0;
    });
  }
}