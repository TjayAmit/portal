import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoAvatar extends StatelessWidget {
  const LogoAvatar({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, '/personal-information'),
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 80,
            child: Image.asset('assets/logo/zcmc.png', fit: BoxFit.contain),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Row(
              children: [
                Text(
                  "MY", 
                  style: GoogleFonts.poppins(
                    fontSize: 18, 
                    fontWeight: FontWeight.w700, 
                    color: Colors.black87,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(width: 1),
                Text(
                  "PORTAL", 
                  style: GoogleFonts.poppins(
                    fontSize: 18, 
                    fontWeight: FontWeight.w700, 
                    color: Colors.green,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
            Text(
              "Zamboanga City Medical Center", 
              style: GoogleFonts.poppins(
                fontSize: 11, 
                fontWeight: FontWeight.w500, 
                color: Colors.black87
              ),
            ),
          ])
        ],
      ),
    );
  }
}