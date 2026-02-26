import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/auth_service.dart';
import '../../../../routes/app_routes.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Title
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Profile",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            /// Avatar + Name
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                        'assets/profile.jpg', // 🔥 asset add করো
                      ),
                    ),

                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Color(0xFF2F6FED),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  "Wade Warren",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Divider(),

            /// Menu List
            _ProfileTile(
              icon: Icons.edit_outlined,
              title: "Edit Profile",
              onTap: () {},
            ),

            const Divider(height: 1),

            _ProfileTile(
              icon: Icons.settings_outlined,
              title: "Support",
              onTap: () {},
            ),

            const Divider(height: 1),

            _ProfileTile(
              icon: Icons.privacy_tip_outlined,
              title: "Privacy",
              onTap: () {},
            ),

            const Divider(height: 1),

            const SizedBox(height: 20),

            /// Logout
            _ProfileTile(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.orange,
              onTap: () async {
                final authService = Get.find<AuthService>();

                await authService.logout();

                Get.offAllNamed(AppRoutes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final Color? color;

  const _ProfileTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black54),
      title: Text(
        title,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }
}