import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 165,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF5F33E1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    // color: Colors.amber,
                    width: 150,
                    child: Text(
                      'Your Today`s Task almost done',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    )),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      'View Task',
                      style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF5F33E1)),
                    ))
              ],
            ),
            const SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: CircularPercentIndicator(
                      radius: 43.0,
                      lineWidth: 8.0,
                      animation: true,
                      percent: 0.7,
                      center: const Text(
                        "70%",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 17.0,
                            color: Colors.white),
                      ),
                      circularStrokeCap: CircularStrokeCap.round,
                      progressColor: Colors.white,
                      backgroundColor: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Container(
                    height: 25,
                    width: 25,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child:
                        Center(child: SvgPicture.asset('assets/pointer.svg')),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
