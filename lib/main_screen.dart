import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isListening = false;
  bool _isSpeaking = false;
  String _transcribedText = '';
  String _translatedText = '';
  String _fromLanguage = 'English';
  String _toLanguage = 'Spanish';

  final List<String> _languages = [
    'English', 'Spanish', 'French', 'German', 'Italian',
    'Portuguese', 'Russian', 'Chinese', 'Japanese', 'Korean'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      drawer: _buildDrawer(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildLanguageSelectors() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: DropdownButton<String>(
              value: _fromLanguage,
              isExpanded: true,
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _fromLanguage = newValue);
                }
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Icon(Icons.swap_horiz),
          ),
          Expanded(
            child: DropdownButton<String>(
              value: _toLanguage,
              isExpanded: true,
              items: _languages.map((String language) {
                return DropdownMenuItem<String>(
                  value: language,
                  child: Text(language),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() => _toLanguage = newValue);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildLanguageSelectors(),
          const SizedBox(height: 16),
          if (_transcribedText.isNotEmpty) ...[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Original Text:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(_transcribedText),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Translated Text:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        IconButton(
                          icon: const Icon(Icons.volume_up),
                          onPressed: () {
                            // Implement text-to-speech for translated text
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(_translatedText),
                  ],
                ),
              ),
            ),
          ] else
            const Expanded(
              child: Center(
                child: Text(
                  'Press the microphone button to start speaking',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFloatingButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton(
            onPressed: _toggleSpeaking,
            backgroundColor: _isSpeaking ? Colors.blue : null,
            shape: _isSpeaking ? const CircleBorder() : null,
            child: Icon(_isSpeaking ? Icons.volume_up : Icons.speaker),
          ),
          FloatingActionButton(
            onPressed: _toggleListening,
            backgroundColor: _isListening ? Colors.red : null,
            shape: _isListening ? const CircleBorder() : null,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ],
      ),
    );
  }

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      if (_isListening) {
        // Simulate speech recognition
        Future.delayed(const Duration(seconds: 3), () {
          setState(() {
            _transcribedText = 'Hello, how are you today?';
            _translatedText = '¡Hola, cómo estás hoy?';
            _isListening = false;
          });
        });
      }
    });
  }

  // Keep existing methods (_buildAppBar, _buildDrawer, _buildProfileTile, _toggleSpeaking, _handleLogout)
  // [Previous implementation remains unchanged]
  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Native'),
      centerTitle: true,
      elevation: 2,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Hero(
            tag: 'profile-avatar',
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/profile_avatar.jpg'),
              child: Icon(Icons.person),
            ),
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.explore),
          onPressed: () => Navigator.pushNamed(context, '/explore'),
        ),
      ],
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('Francis Ssessaazi'),
              accountEmail: const Text('francis@example.com'),
              currentAccountPicture: Hero(
                tag: 'profile-avatar',
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/profile_avatar.jpg'),
                  child: Icon(Icons.person),
                ),
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
            ),
            _buildProfileTile(Icons.person, 'Name', 'Francis Ssessaazi'),
            _buildProfileTile(Icons.email, 'Email', 'francis@example.com'),
            _buildProfileTile(Icons.phone, 'Phone', '+256 123 456 789'),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Log Out', style: TextStyle(color: Colors.red)),
              onTap: _handleLogout,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      dense: true,
    );
  }

  void _toggleSpeaking() {
    setState(() => _isSpeaking = !_isSpeaking);
  }

  void _handleLogout() {
    Navigator.pop(context);
    Navigator.pushReplacementNamed(context, '/');
  }
}