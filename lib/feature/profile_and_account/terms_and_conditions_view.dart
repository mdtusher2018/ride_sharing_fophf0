import 'package:flutter/material.dart';
import 'package:velozaje/res/common_appbar.dart';
import 'package:velozaje/res/common_text.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(context, title: "Terms & Conditions"),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: CommonText(
          """
It is a long established fact that a reader will be distract by the readable content of a page the when looking at its layout. The point of using a Lorem Ipsum is that it has a more-or-less and normal distribution of letters, as opposed to the using 'Content here, content here', making it look like readable English. Many desktop then publishing packages and web page editors for now use Lorem Ipsum as their default model & text.
      
It is a long established fact that a reader will be distract by the readable content of a page the when looking at its layout. The point of using a Lorem Ipsum is that it has a more-or-less and normal distribution of letters, as opposed to the using 'Content here, content here', making it look like readable English. Many desktop then publishing packages and web page editors for now use Lorem Ipsum as their default model & text.
      
It is a long established fact that a reader will be distract by the readable content of a page the when looking at its layout. The point of using a Lorem Ipsum is that it has a more normal and distribution. 
      """,
          size: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
