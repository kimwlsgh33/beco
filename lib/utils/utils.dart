import 'package:beco/models/menu.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage(ImageSource source) async {
  final ImagePicker _picker = ImagePicker();

  XFile? _file = await _picker.pickImage(source: source);

  if (_file != null) {
    // dart.io의 File 클래스를 사용하여 이미지 파일을 읽지않음 ( web 환경에서는 dart.io가 지원되지 않음 )
    return await _file.readAsBytes();
  }
  print("No image selected");
}

// 알림을 보내는 기능 ( 자주 사용하므로 따로 빼놓음 )
showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}

iconMenuModal({
  required BuildContext context,
  String? title,
  required List<Menu> list,
  leading = true,
}) {
  return showModalBottomSheet(
    backgroundColor: Colors.grey.shade800,
    clipBehavior: Clip.hardEdge,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) => Wrap(
      // mainAxisSize: MainAxisSize.min,
      children: [
        // make slide bar
        title == null
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        height: 5,
                        width: 50,
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 10),
                        child: Text(
                          title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
        const Divider(height: 0, color: Colors.white24),
        ListView.separated(
          shrinkWrap: true,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onTap: list[index].onTap,
              leading: leading ? Icon(list[index].icon) : null,
              trailing: leading
                  ? null
                  : Icon(
                      list[index].icon,
                      color: Colors.white,
                    ),
              title: Text(
                list[index].title,
                style: const TextStyle(color: Colors.white),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 0, color: Colors.white24);
          },
        ),
        const SizedBox(height: 30),
      ],
    ),
  );
}




