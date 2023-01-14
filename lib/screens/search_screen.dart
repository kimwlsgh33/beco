import 'package:beco/screens/post_screen.dart';
import 'package:beco/screens/profile_screen.dart';
import 'package:beco/utils/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  bool isShowUsers = false, isLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: mobileBackgroundColor,
              title: TextFormField(
                controller: _searchController,
                decoration: const InputDecoration(
                  labelText: 'Search for a user',
                ),
                onFieldSubmitted: (String _) {
                  setState(() {
                    isShowUsers = true;
                  });
                  print(_);
                },
              ),
            ),
            body: isShowUsers
                ? FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .where('username',
                            isGreaterThanOrEqualTo: _searchController.text)
                        .get(),
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return ListView.builder(
                        itemCount: snapshot.data.docs.length,
                        itemBuilder: (BuildContext context, int index) {
                          final doc = snapshot.data.docs[index].data();
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    uid: doc['uid'],
                                  ),
                                ),
                              );
                            },
                            child: ListTile(
                              title: Text(
                                doc['username'],
                              ),
                              subtitle: Text(
                                doc['email'],
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(doc['photoUrl']),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                : FutureBuilder(
                    future:
                        FirebaseFirestore.instance.collection('posts').get(),
                    // initialData: InitialData,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return GridView.custom(
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 3,
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: const [
                            QuiltedGridTile(2, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(2, 1),
                            QuiltedGridTile(1, 1),
                            QuiltedGridTile(1, 1),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          (context, index) => InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PostScreen(
                                  snap: snapshot.data.docs[index].data(),
                                ),
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data.docs[index]
                                      .data()['postUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          childCount: snapshot.data.docs.length,
                        ),
                      );
                    },
                  ),
          );
  }
}
