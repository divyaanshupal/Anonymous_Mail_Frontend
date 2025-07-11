import 'package:anon_mailer/provider/SendMailProvider.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController nicknameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B2D31),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Container(
            padding: const EdgeInsets.all(32),
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1F22),
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 15,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.email, size: 40, color: Color(0xFF7289DA)),
                    SizedBox(width: 10),
                    Text(
                      "AnonMailer",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    "Send mail anonymously like a Discord ninja 🕵️‍♂️",
                    style: TextStyle(fontSize: 14, color: Colors.white60),
                  ),
                ),
                const SizedBox(height: 24),

                _buildInputField(
                  controller: emailController,
                  icon: Icons.alternate_email_rounded,
                  hint: "Recipient's Email",
                ),
                const SizedBox(height: 16),

                _buildInputField(
                  controller: messageController,
                  icon: Icons.message_outlined,
                  hint: "Your Message",
                  maxLines: 5,
                ),
                const SizedBox(height: 16),

                _buildInputField(
                  controller: nicknameController,
                  icon: Icons.person_outline,
                  hint: "Anonymous Nickname",
                ),
                const SizedBox(height: 24),

                isLoading
                    ? const Center(child: CircularProgressIndicator(color: Color(0xFF7289DA)))
                    : ElevatedButton(
                        onPressed: _handleSend,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF5865F2),
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Send Anonymously",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          '🔒 Made with Discord vibes by DP',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white60),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white54),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: const Color(0xFF313338),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF5865F2), width: 2),
        ),
      ),
    );
  }

  void _handleSend() async {
    final to = emailController.text.trim();
    final message = messageController.text.trim();
    final nickname = nicknameController.text.trim();

    if (to.isEmpty || message.isEmpty || nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    setState(() => isLoading = true);

    final success = await sendMail(
      to: to,
      message: message,
      nickname: nickname,
    );

    setState(() => isLoading = false);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Email Sent Successfully!')),
      );
      emailController.clear();
      messageController.clear();
      nicknameController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to send message.')),
      );
    }
  }
} 