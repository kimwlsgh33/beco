import 'package:beco/screens/admins/add_skill.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/widgets/admins/manage_card.dart';
import 'package:flutter/material.dart';

class MainAdmin extends StatelessWidget {
  const MainAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kakaoBackgroundColor,
      appBar: AppBar(
        title: const Text('MainAdmin'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('MainAdmin'),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: kakaoSecondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: const Text('Managements'),
            ),
            const SizedBox(height: 20),
            ManageCard(
              page: Container(),
              icon: const Icon(
                Icons.person,
                color: kakaoSecondaryColor,
              ),
              child: const Text(
                'Manage Users',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ManageCard(
              page: AddSkill(),
              icon: Icon(
                Icons.person,
                color: kakaoSecondaryColor,
              ),
              child: Text(
                'Manage Admins',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const ManageCard(
              page: AddSkill(),
              icon: Icon(
                Icons.work,
                color: kakaoSecondaryColor,
              ),
              child: Text(
                'Manage Skills',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
