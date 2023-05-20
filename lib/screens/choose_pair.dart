import 'package:flutter/material.dart';
import 'package:trade_app/config/colors.dart';
import 'package:trade_app/config/scale.dart';
import 'package:trade_app/layout.dart';

class ChoosePairScreen extends StatefulWidget {
  const ChoosePairScreen({Key? key}) : super(key: key);

  @override
  State<ChoosePairScreen> createState() => _ChoosePairScreenState();
}

class _ChoosePairScreenState extends State<ChoosePairScreen> {
  @override
  Widget build(BuildContext context) {
    return Layout(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Currency pair",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: scale(22)),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(scale(37)),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: scale(54),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondButton,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(scale(12)),
                        ),
                      ),
                      child: Text('GPB / USD'),

                    ),
                  ),
                ),
                SizedBox(width: scale(21),),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: scale(54),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: secondButton,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(scale(12)),
                        ),
                      ),
                      child: Text('GPB / USD'),

                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
