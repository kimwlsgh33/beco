import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TossScreen extends StatelessWidget {
  const TossScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF282A31),
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 5),
            BlocBuilder<AuthCubit,User>(
              builder: (context, snapshot) {
                return Text(
                  'Username',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                );
              }
            ),
            const SizedBox(width: 10),
            TextButton(
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                backgroundColor: const Color(0xFF31353F),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: null,
              child: const Text(
                '내 계좌',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: const Color(0xFF282A31),
        elevation: 0,
        actions: [
          InkWell(
            onTap: () {},
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://picsum.photos/200',
              ),
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        '2023년에도 세뱃돈은 카뱅으로!',
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '세뱃돈 보내면 최대 10만원 드려요',
                        style: TextStyle(
                          // color: Color(0xFFE5A00D),
                          color: Color(0xFF282A31),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Transform.scale(
                    scale: 1.5,
                    child: Transform.translate(
                      offset: const Offset(20, 0),
                      child: Image.asset(
                        'assets/new_year.png',
                        width: 100,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
              clipBehavior: Clip.hardEdge,
              padding: const EdgeInsets.only(top: 15,bottom: 15, right: 30, left: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE300),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/kakao_bank.png',
                    width: 45,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            '김진호의 통장',
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            Icons.star,
                            color: Colors.black87,
                            size: 16,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '10,000,000,000원',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: const [
                        Icon(
                          Icons.more_horiz,
                          color: Colors.black54,
                          size: 18,
                        ),
                        
                        SizedBox(height: 20),
                        Text(
                          '카카오뱅크',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Container(
                clipBehavior: Clip.hardEdge,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: const BoxDecoration(
                  color: Color(0xFF31353F),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: InkWell(
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.grey.shade500,
                      size: 30,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
