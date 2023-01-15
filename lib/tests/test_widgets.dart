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

  
Widget testWrap(){
  // Wrap을 사용하면 자식들이 부모의 크기를 넘어가면 다음줄로 넘어간다.
  return SizedBox(
    width: double.infinity, // Wrap의 가로크기를 부모의 가로크기로 맞춘다.
    child: Wrap(
      spacing: 35.0, // gap between adjacent chips
      runSpacing: 20.0, // gap between lines
      alignment: WrapAlignment.center,
      children: <Widget>[
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('AH')),
          label: const Text('Hamilton'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('ML')),
          label: const Text('Lafayette'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('HM')),
          label: const Text('Mulligan'),
        ),
        Chip(
          avatar: CircleAvatar(backgroundColor: Colors.blue.shade900, child: const Text('JL')),
          label: const Text('Laurens'),
        ),
      ],
    ),
  );
}

