import 'package:flutter/material.dart';
import 'package:front/const/colors.dart';

class SnsScreen extends StatefulWidget {
  const SnsScreen({Key? key}) : super(key: key);

  @override
  State<SnsScreen> createState() => _SnsScreenState();
}

class _SnsScreenState extends State<SnsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'asset/img/logo.png',
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem(
                          child: Text('Option 1'),
                          value: 1,
                        ),
                        PopupMenuItem(
                          child: Text('Option 2'),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: Text('Option 3'),
                          value: 3,
                        ),
                      ];
                    },
                    onSelected: (value) {
                      // Do something when an option is selected
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  // 서버 요청
                  await Future.delayed(Duration(seconds: 3));
                },
                child: ListView.separated(
                  itemCount: 100,
                  itemBuilder: (BuildContext context, int index) {
                    return renderContainer(
                      color: rainbowColors[index % rainbowColors.length],
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return renderContainer(
                        color: Colors.black, index: index, height: 50);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget renderContainer({
    required Color color,
    required int index,
    double? height,
  }) {
    print(index);
    return Container(
      height: height ?? 500,
      color: color,
      child: Center(
        child: Text(
          index.toString(),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }
}
