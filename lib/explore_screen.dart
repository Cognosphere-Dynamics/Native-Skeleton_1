import 'package:flutter/material.dart';

class FeedItem {
  final String title;
  final String description;

  FeedItem({required this.title, required this.description});
}

class OperatorItem {
  final String name;
  final String location;

  OperatorItem({required this.name, required this.location});
}

class ExploreScreen extends StatefulWidget {
  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<FeedItem> _feedItems = [
    FeedItem(title: 'Ring takes on Nest', description: 'Ring announces a new cheaper home security system.'),
    FeedItem(title: 'New AI Tech Released', description: 'Explore the future of artificial intelligence.'),
    FeedItem(title: 'Ring takes on Nest', description: 'Ring announces a new cheaper home security system.'),
    FeedItem(title: 'New AI Tech Released', description: 'Explore the future of artificial intelligence.'),
  ];

  final List<OperatorItem> _operatorItems = [
    OperatorItem(name: 'John Doe', location: 'San Francisco, CA'),
    OperatorItem(name: 'Jane Smith', location: 'New York, NY'),
    OperatorItem(name: 'Emily Johnson', location: 'Austin, TX'),
    OperatorItem(name: 'Robert Brown', location: 'Seattle, WA'),
  ];

  final List<String> _imagePaths = [
    'assets/t1.jpg',
    'assets/t2.jpg',
    'assets/t3.jpg',
    'assets/t4.jpg',
  ];

  final List<int> _likeCounts = [10, 23, 15, 8];
  final List<List<bool>> _starRatings = List.generate(
    4,
        (_) => List.filled(5, false),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Removes the back arrow
        toolbarHeight: 60, // Adjust height of the AppBar to align with Tabs
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: Icon(Icons.feed), text: 'Your Feed'),
              Tab(icon: Icon(Icons.location_on), text: 'Near You'),
              Tab(icon: Icon(Icons.people), text: 'Operators'),
            ],
            labelColor: Colors.green,
            unselectedLabelColor: Colors.black54,
            indicatorColor: Colors.green,
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildFeedTab(),
          _buildNearYouTab(),
          _buildOperatorsTab(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushReplacementNamed('/main'),
        child: const Icon(Icons.home),
      ),
    );
  }

  Widget _buildFeedCard(FeedItem item, String imagePath) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(imagePath), // Use AssetImage here
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Title and Description Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Footer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Icon(Icons.article, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  'The Verge',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
                const Spacer(),
                Text(
                  '3 hours ago',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _feedItems.length,
      itemBuilder: (context, index) {
        return _buildFeedCard(_feedItems[index], _imagePaths[index]);
      },
    );
  }

  Widget _buildOperatorCard(OperatorItem operatorItem, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(_imagePaths[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Name and Location Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  operatorItem.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  operatorItem.location,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),

          // Footer Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Row(
                  children: List.generate(5, (starIndex) {
                    return IconButton(
                      icon: Icon(
                        _starRatings[index][starIndex]
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          _starRatings[index][starIndex] =
                          !_starRatings[index][starIndex];
                        });
                      },
                      iconSize: 24,
                    );
                  }),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.thumb_up, color: Colors.blue),
                  onPressed: () {
                    setState(() {
                      _likeCounts[index]++;
                    });
                  },
                ),
                Text(
                  '${_likeCounts[index]}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperatorsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _operatorItems.length,
      itemBuilder: (context, index) {
        return _buildOperatorCard(_operatorItems[index], index);
      },
    );
  }

  Widget _buildNearYouTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search nearby...',
              filled: true,
              fillColor: Theme.of(context).colorScheme.surface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: (value) {
              // Implement search functionality for "Near You"
            },
          ),
        ),
        Expanded(
          child: FutureBuilder<List<dynamic>>(
            future: _fetchNearbyLocations(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Discovering natives near you...'),
                    ],
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text('Error: ${snapshot.error}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => setState(() {}),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              return const Center(
                child: Text('No locations found nearby'),
              );
            },
          ),
        ),
      ],
    );
  }

  Future<List<dynamic>> _fetchNearbyLocations() async {
    // Implement location fetching logic
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    return [];
  }
}
