import 'package:beco/utils/colors.dart';
import 'package:flutter/material.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  TextEditingController _skillController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Skill'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          color: kakaoBackgroundColor,
        ),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              TextField(
                controller: _skillController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Skill Name',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _skillController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Skill Description',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigator.pop(context, _descriptionController.text);
                  // Navigator.pop(context, _skillController.text);

                },
                child: const Text('Add'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
