// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/voice_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final voice = context.watch<VoiceProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("AI Voice Assistant"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          /// ================= MAIN CONTENT =================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 150),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  /// 🗣 YOU SAID
                  Expanded(
                    child: _InfoCard(
                      title: "You said",
                      content: voice.userText.isEmpty
                          ? "Tap the mic and start speaking"
                          : voice.userText,
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// 🤖 AI RESPONSE
                  Expanded(
                    child: _InfoCard(
                      title: "AI response",
                      content: voice.aiText.isEmpty
                          ? "AI response will appear here"
                          : voice.aiText,
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          /// ================= BOTTOM CONTROLS =================
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// 🔄 RESET BUTTON
                _CircleButton(
                  size: 60,
                  color: Colors.grey.shade600,
                  icon: Icons.refresh,
                  onTap: voice.resetConversation,
                ),

                /// 🎤 MIC BUTTON
                _CircleButton(
                  size: 80,
                  color: voice.isListening
                      ? Colors.redAccent
                      : Theme.of(context).primaryColor,
                  icon: voice.isListening ? Icons.stop : Icons.mic,
                  onTap: voice.isListening
                      ? voice.stopListening
                      : voice.startListening,
                ),

                /// ⏹️ STOP AI BUTTON (only show when AI is speaking)
                if (voice.isSpeaking)
                  _CircleButton(
                    size: 60,
                    color: Colors.orange.shade600,
                    icon: Icons.stop_circle,
                    onTap: voice.stopAiResponse,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ================= INFO CARD =================
class _InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const _InfoCard({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TITLE
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const Divider(height: 1),

            /// SCROLLABLE CONTENT (ANTI OVERFLOW)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ================= CIRCLE BUTTON =================
class _CircleButton extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.size,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
              blurRadius: 18,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(
          icon,
          size: size * 0.45,
          color: Colors.white,
        ),
      ),
    );
  }
}
