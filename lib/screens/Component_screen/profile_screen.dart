import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            const Center(
                child: CircleAvatar(
              backgroundImage: AssetImage("assets/avaters/Avatar 1.jpg"),
              radius: 50,
            )),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Nguyễn Đăng Nam",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.orange),
              ),
              child: const Text("Edit Profile"),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white70),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.account_circle,
                    size: 30,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.purple),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.settings,
                    size: 30,
                    color: Colors.white70,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Setting",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.greenAccent),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.help,
                    size: 30,
                    color: Colors.purpleAccent,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text(
                    "Help Center",
                    style: TextStyle(fontSize: 24, color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(15),
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.redAccent),
              child: const Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.logout,
                    size: 30,
                    color: Colors.greenAccent,
                  ),
                  SizedBox(
                    width: 12,
                  ),
                  Text("Log out",
                      style:
                          TextStyle(fontSize: 24, color: Colors.greenAccent)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
