import 'package:beco/cubits/auth_cubit.dart';
import 'package:beco/cubits/wallet_cubit.dart';
import 'package:beco/models/menu.dart';
import 'package:beco/models/user.dart';
import 'package:beco/models/wallet.dart';
import 'package:beco/resources/firestore_methods.dart';
import 'package:beco/utils/colors.dart';
import 'package:beco/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TossScreen extends StatefulWidget {
  const TossScreen({super.key});

  @override
  State<TossScreen> createState() => _TossScreenState();
}

class _TossScreenState extends State<TossScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<WalletCubit>().refreshWallet();
    return Scaffold(
      backgroundColor: kakaoBackgroundColor,
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 5),
            BlocBuilder<AuthCubit, User>(builder: (context, snapshot) {
              return Text(
                snapshot.username,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              );
            }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: kakaoSecondaryColor,
                  foregroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  enableFeedback: true,
                ),
                onPressed: () {},
                child: const Text(
                  '내 계좌',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
        centerTitle: false,
        backgroundColor: kakaoBackgroundColor,
        elevation: 0,
        actions: [
          BlocBuilder<AuthCubit, User>(builder: (context, snapshot) {
            return GestureDetector(
              onTap: () {
                // context.read<AuthCubit>().logout();
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(snapshot.photoUrl),
              ),
            );
          }),
          const SizedBox(width: 20),
        ],
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: MediaQuery.of(context).size.height * 0.3),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                clipBehavior: Clip.hardEdge,
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                decoration: const BoxDecoration(
                  color: kakaoWhite,
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
                            color: kakaoSecondaryColor,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '세뱃돈 보내면 최대 10만원 드려요',
                          style: TextStyle(
                            color: kakaoBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Transform.scale(
                      scale: 1.5,
                      child: Transform.translate(
                        offset: const Offset(30, 0),
                        child: Image.asset(
                          'assets/new_year.png',
                          width: 70,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              BlocBuilder<WalletCubit, List<Wallet>>(
                builder: (context, wallets) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wallets.length,
                    itemBuilder: (context, index) {
                      return Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, right: 30, left: 20),
                        decoration: const BoxDecoration(
                          color: kakaoYellow,
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              // TODO: Change this to dynamic
                              'assets/kakao_bank.png',
                              width: 45,
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    BlocBuilder<AuthCubit, User>(
                                        builder: (context, snapshot) {
                                      return Text(
                                        '${snapshot.username}의 통장',
                                        style: const TextStyle(
                                          color: kakaoSecondaryColor,
                                          fontSize: 16,
                                        ),
                                      );
                                    }),
                                    const SizedBox(width: 5),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.black87,
                                      size: 16,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  // wallets[index].amount.toString(),
                                  '0',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black54,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 20),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: kakaoDeepYellow,
                                      foregroundColor: primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      '이체',
                                      style: TextStyle(
                                        color: kakaoSecondaryColor,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: MaterialButton(
                      onPressed: () {
                        iconMenuModal(
                          title: '계좌 추가',
                          context: context,
                          list: [
                            Menu(
                              title: '카카오뱅크',
                              icon: Icons.account_balance,
                              onTap: () async {
                                String res = await FirestoreMethods().addWallet(
                                    context.read<AuthCubit>().state.uid);

                                if (res != 'success') {
                                  showSnackBar(context, res);
                                }

                                context.read<WalletCubit>().refreshWallet();

                                return Navigator.pop(context);
                              },
                            ),
                            Menu(
                              title: '토스뱅크',
                              icon: Icons.account_balance,
                              onTap: () {},
                            ),
                          ],
                        );
                        setState(() {});
                      },
                      color: const Color(0xFF31353F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 30),
                      child: Icon(
                        Icons.add,
                        color: Colors.grey.shade500,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
