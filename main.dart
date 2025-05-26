import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Vote Confirmation',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF2E7D32),
        brightness: Brightness.light,
      ),
      useMaterial3: true,
      fontFamily: 'Roboto',
    ),
    home: const VoteConfirmationPage(),
  );
}

class VoteConfirmationPage extends StatefulWidget {
  const VoteConfirmationPage({super.key});

  @override
  State<VoteConfirmationPage> createState() => _VoteConfirmationPageState();
}

class _VoteConfirmationPageState extends State<VoteConfirmationPage> {
  bool _showConfirmation = true;
  bool _voteSubmitted = false;

  final _candidates = const [
    {'position': 'President', 'candidate': 'Maria Gonzales'},
    {'position': 'Vice President', 'candidate': 'Juan Dela Cruz'},
    {'position': 'Secretary', 'candidate': 'Ana Santos'},
    {'position': 'Treasurer', 'candidate': 'Leo Ramirez'},
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text(
          'Vote Confirmation',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          _buildBackground(theme),
          if (_showConfirmation && !_voteSubmitted) _buildModal(theme),
        ],
      ),
    );
  }

  Widget _buildBackground(ThemeData theme) => Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF5F5F5), Color(0xFFE8F5E8)],
      ),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.how_to_vote_rounded,
            size: 80,
            color: theme.colorScheme.primary.withOpacity(0.3),
          ),
          const SizedBox(height: 20),
          Text(
            _voteSubmitted
                ? 'Vote Successfully Submitted!'
                : 'Welcome to the Voting System',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          if (_voteSubmitted)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'Thank you for participating in the election',
                style: TextStyle(
                  fontSize: 16,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
            ),
        ],
      ),
    ),
  );

  Widget _buildModal(ThemeData theme) => Positioned.fill(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Container(
            width:
                MediaQuery.of(context).size.width * 0.9, // 90% of screen width
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildHeader(theme),
                const SizedBox(height: 24),
                _buildVoteSummary(theme),
                const SizedBox(height: 24),
                _buildWarning(theme),
                const SizedBox(height: 28),
                _buildButtons(theme),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildHeader(ThemeData theme) => Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: theme.colorScheme.primary,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: const [
        Icon(Icons.ballot_outlined, color: Colors.white, size: 32),
        SizedBox(height: 8),
        Text(
          'Confirm Your Vote',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );

  Widget _buildVoteSummary(ThemeData theme) => Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: const Color(0xFFF8F9FA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your Selected Candidates',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        ..._candidates.map(
          (c) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 8, right: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['position']!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        c['candidate']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildWarning(ThemeData theme) => Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.amber.withOpacity(0.3)),
    ),
    child: Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: Colors.amber[700], size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'You are about to cast your vote. Once confirmed, this vote cannot be changed.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.amber[800],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildButtons(ThemeData theme) => Row(
    children: [
      Expanded(
        child: OutlinedButton(
          onPressed: () => setState(() => _showConfirmation = false),
          child: const Text(
            'Cancel',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        flex: 2,
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _showConfirmation = false;
              _voteSubmitted = true;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 20),
                    SizedBox(width: 12),
                    Text(
                      'Vote confirmed successfully!',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                backgroundColor: Colors.green[600],
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(16),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text(
            'Confirm Vote',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    ],
  );
}
