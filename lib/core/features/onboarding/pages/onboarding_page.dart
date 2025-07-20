import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OnboardingPage extends StatelessWidget {
const OnboardingPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Container(
      color: Color(0xff1B1B1B),
      child: Positioned
      
      (child: SvgPicture.asset('assets/icons/sms.svg'),
      top: 132,
      left: -219,
      right: 0,
      ),
      
    );
  }
}