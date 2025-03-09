
import 'package:advertisement_application_flutter/ui_screens/client_side/sign_in_screen.dart';
import 'package:advertisement_application_flutter/ui_screens/client_side/sign_up_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'admin_side/admin_login_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 0.2.sh),
            Center(
              child: Container(
                height: 50.h,
                width: 50.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFD9D9D9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Image.asset(
                    'assets/images/app_logo.png',
                    height: 40.h,
                    width: 40.w,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.02.sh),
            Text('AdverApp', style: GoogleFonts.poppins(
              fontSize: 22.sp,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),),
            SizedBox(height: 0.03.sh),
            SizedBox(
              width: 0.6.sw,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignInScreenUi()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
                child: Text(
                  'Sign In',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.03.sh),
            SizedBox(
              width: 0.6.sw,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignUpUiScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
                child: Text(
                  'Sign Up',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 0.02.sh),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 1.h,
                  width: 0.1.sw,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(width: 0.02.sw),
                const Text(
                  'or',
                  style: const TextStyle(color: Color(0xFF979797), fontSize: 12),
                ),
                SizedBox(width: 0.02.sw),
                Container(
                  height: 1.h,
                  width: 0.1.sw,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 0.02.sh),
            SizedBox(
              width: 0.6.sw,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AdminLoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                  ),
                ),
                child: Text(
                  'Admin Log In',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
