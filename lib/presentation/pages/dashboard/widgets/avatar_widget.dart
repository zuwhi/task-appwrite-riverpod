import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AvatarWigets extends StatelessWidget {
  const AvatarWigets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // color: Colors.orange,
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundImage: AssetImage('assets/pp.jpg'),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  // color: Colors.amber,
                  // height: 50,
                  padding: const EdgeInsets.only(left: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 16,
                        child: Text(
                          'hallo',
                          style: GoogleFonts.poppins(
                              color: Colors.grey[700],
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(
                        height: 32,
                        child: Text(
                          'Tony  Chopper',
                          style: GoogleFonts.poppins(
                              color: Colors.grey[800],
                              fontSize: 25,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Icon(Icons.notifications_none),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
