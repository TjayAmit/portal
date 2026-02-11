import 'package:flutter/material.dart';
import 'package:zcmc_portal/core/widgets/cards/attendance_report_summary_card.dart';
import 'package:zcmc_portal/core/widgets/cards/leave_credits_card.dart';
import 'package:zcmc_portal/core/widgets/cards/today_dtr_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF22C55E), Color(0xFF16A34A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF22C55E).withOpacity(0.5),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Good morning,',
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        Text(
                            'Tristan jay L. Amit',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                                  fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Strengthening Care Through Technology',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 50,
                      height: 100,
                      child: Image.asset('assets/logo/zcmc.png', fit: BoxFit.contain),
                    )
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Row(children: [
                Text(
                  'Your Dashboard',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),  
              ],
              )
      
            // const SizedBox(height: 20),
            // const LeaveCreditsCard(),
            // const SizedBox(height: 20),
            // const TodayDTRWidget(),
            // const SizedBox(height: 20),
            // const AttendanceSummaryWidget(),
          ],
        ),
      ),
    );
  }
}