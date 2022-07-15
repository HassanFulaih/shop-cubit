import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../helpers/cache.dart';
import 'login.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  const BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final List<BoardingModel> boardingList = [
    const BoardingModel(
      image: 'assets/images/istockphoto1.jpg',
      title: 'Welcome to Flutter',
      body:
          'Flutter is Google\'s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
    ),
    const BoardingModel(
      image: 'assets/images/istockphoto2.jpg',
      title:
          'Flutter is Google\'s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
      body:
          'Flutter is Google\'s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
    ),
    const BoardingModel(
      image: 'assets/images/istockphoto3.jpg',
      title:
          'Flutter is Google\'s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
      body:
          'Flutter is Google\'s mobile app SDK for crafting high-quality native interfaces on iOS and Android in record time.',
    ),
  ];

  bool isLast = false;

  final PageController _boardController = PageController(
    initialPage: 0,
    viewportFraction: 1,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: const Text(
              'SKIP',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              CacheHelper.setBool('on_boarding', true).then((value) {
                if (value)
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: _boardController,
                onPageChanged: (index) {
                  setState(() {
                    isLast = index == boardingList.length - 1;
                  });
                },
                itemBuilder: (context, index) {
                  return _buildItem(context, boardingList[index]);
                },
                itemCount: boardingList.length,
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: _boardController,
                  count: boardingList.length,
                  effect: ExpandingDotsEffect(
                    dotHeight: 15,
                    dotWidth: 15,
                    spacing: 7,
                    expansionFactor: 4,
                    dotColor: Colors.grey,
                    activeDotColor: Theme.of(context).primaryColor,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.setBool('on_boarding', true).then((value) {
                        if (value)
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                      });
                    } else {
                      _boardController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context, BoardingModel boardingItem) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(boardingItem.image),
          ),
        ),
        Text(
          boardingItem.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Text(
          boardingItem.body,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
