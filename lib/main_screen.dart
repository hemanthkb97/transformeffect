import 'package:flutter/material.dart';
import 'package:matrix4_transform/matrix4_transform.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  Offset containerOffet = const Offset(0, 0);
  Curve curve = Curves.linear;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            curve = Curves.linear;
            containerOffet += details.delta;
            if (containerOffet.dx >= 60) {
              containerOffet = Offset(60, containerOffet.dy);
            } else if (containerOffet.dx <= -60) {
              containerOffet = Offset(-60, containerOffet.dy);
            }
            if (containerOffet.dy >= 80) {
              containerOffet = Offset(containerOffet.dx, 60);
            } else if (containerOffet.dy <= -80) {
              containerOffet = Offset(containerOffet.dx, -60);
            }
            setState(() {});
          },
          onPanEnd: (details) async {
            double dx = containerOffet.dx;
            double dy = containerOffet.dy;
            double newdx = dx, newdy = dy;
            if (dx > 0) {
              newdx = -10;
            } else if (dx < 0) {
              newdx = 10;
            }
            if (dy > 0) {
              newdy = -20;
            } else if (dy < 0) {
              newdy = 20;
            }
            curve = Curves.ease;
            containerOffet = Offset(newdx, newdy);
            setState(() {});
            await Future.delayed(const Duration(milliseconds: 300));
            containerOffet = Offset.zero;
            setState(() {});
          },
          child: SizedBox(
            width: 280,
            height: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                AnimatedContainer(
                  curve: curve,
                  duration: const Duration(milliseconds: 400),
                  transformAlignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0001)
                    ..rotateX(0.0050 * containerOffet.dy)
                    ..rotateY(-0.0075 * containerOffet.dx),
                  width: 280,
                  height: 400,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 233, 231, 228),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: kElevationToShadow[6]),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        const Align(
                          alignment: Alignment.center,
                          child: Text(
                            "Geek Shoes",
                            style: TextStyle(
                                fontSize: 24,
                                letterSpacing: 1,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin nec pretium mauris, nec mollis nibh. Cras at tempus ante.",
                        ),
                        const Expanded(child: SizedBox()),
                        Row(
                          children: [
                            const Text(
                              "Price \$20",
                              style: TextStyle(
                                  fontSize: 14,
                                  letterSpacing: 1,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Text(
                                "Add to cart",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 1,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 10,
                  child: AnimatedContainer(
                    curve: curve,
                    duration: const Duration(milliseconds: 400),
                    width: 220,
                    transform: Matrix4Transform()
                        .translateOffset(Offset(
                            containerOffet.dx * 0.56, containerOffet.dy * 0.30))
                        .matrix4
                      ..setEntry(3, 2, 0.0001)
                      ..rotateX(0.0050 * containerOffet.dy)
                      ..rotateY(-0.0075 * containerOffet.dx),
                    transformAlignment: Alignment.center,
                    child: Image.asset(
                      "assets/shoes.png",
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
