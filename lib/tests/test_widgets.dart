import 'package:beco/models/menu.dart';
import 'package:beco/utils/utils.dart';
import 'package:flutter/material.dart';

Widget testIntrinsicHeight() {
  // 가장큰 자식의 높이를 기준으로 높이를 결정한다.
  return IntrinsicHeight(
      child: Row(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      Expanded(
        flex: 2,
        child: Image.network(
          'https://picsum.photos/250?image=9',
          fit: BoxFit.cover,
        ),
      ),
      Expanded(
        flex: 3,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
          ),
          // Lorem
          child: const Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies tincidunt, nunc nisl aliquam nisl, eget aliquam nisl nunc vel nisl. Donec auctor, nisl eget ultricies t'),
        ),
      ),
    ],
  ));
}

Widget testWrap() {
  // Wrap을 사용하면 자식들이 부모의 크기를 넘어가면 다음줄로 넘어간다.
  return SizedBox(
    width: double.infinity, // Wrap의 가로크기를 부모의 가로크기로 맞춘다.
    child: Wrap(
      spacing: 35.0, // gap between adjacent chips
      runSpacing: 20.0, // gap between lines
      alignment: WrapAlignment.center,
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('AH')),
          label: const Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('ML')),
          label: const Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('HM')),
          label: const Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(
              backgroundColor: Colors.blue.shade900, child: const Text('JL')),
          label: const Text('Laurens'),
        ),
      ],
    ),
  );
}

Widget testButtons(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TextButton(
        onPressed: () {
          iconMenuModal(
            context: context,
            list: [
              Menu(title: '카카오뱅크', icon: Icons.account_balance),
              Menu(title: '토스뱅크', icon: Icons.account_balance),
            ],
          );
        },
        child: const Text('TextButton'),
      ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {},
        child: const Text('ElevatedButton'),
      ),
      const SizedBox(height: 30),
      OutlinedButton(
        onPressed: () {},
        child: const Text('OutlinedButton'),
      ),
      const SizedBox(height: 30),
      TextButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('TextButton.icon'),
      ),
      const SizedBox(height: 30),
      ElevatedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('ElevatedButton.icon'),
      ),
      const SizedBox(height: 30),
      OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('OutlinedButton.icon'),
      ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const BeveledRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(7))),
        ),
        child: const Text('ElevatedButton (shape)'),
      ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
        ),
        child: const Text('ElevatedButton (shape)'),
      ),
      const SizedBox(height: 30),
      ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
        child: const Text('ElevatedButton (shape)'),
      ),
      const SizedBox(height: 30),
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.add),
      ),
      const SizedBox(height: 30),
      PopupMenuButton(
        itemBuilder: (context) {
          return const [
            PopupMenuItem(child: Text('item1')),
            PopupMenuItem(child: Text('item2')),
            PopupMenuItem(child: Text('item3')),
          ];
        },
      ),
      const SizedBox(height: 30),
      BackButton(),
      const SizedBox(height: 30),
      CloseButton(),
      const SizedBox(height: 30),
      FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      const SizedBox(height: 30),
      FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('label'),
        icon: const Icon(Icons.add),
      ),
      const SizedBox(height: 30),
      FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
        mini: true,
      ),
      const SizedBox(height: 30),
      MaterialButton(
        onPressed: () {},
        child: const Text('MaterialButton'),
      ),
      const SizedBox(height: 30),
      MaterialButton(
        onPressed: () {},
        child: const Text('MaterialButton'),
        shape: const StadiumBorder(),
      ),
      const SizedBox(height: 30),
      MaterialButton(
        onPressed: () {},
        child: const Text('MaterialButton'),
        shape: const CircleBorder(),
      ),
      const SizedBox(height: 30),
      MaterialButton(
        onPressed: () {},
        child: const Text('MaterialButton'),
        shape: const BeveledRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7))),
      ),
      const SizedBox(height: 30),
    ],
  );
}
