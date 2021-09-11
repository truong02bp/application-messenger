import 'package:flutter/material.dart';
import 'package:messenger_ui/contants/input_decorator_contants.dart';

Color getColor(String? color) {
  switch (color) {
    case "RED":
      return Colors.red;
    case "PINK_CUSTOM":
      return Color(0xfff78379).withOpacity(0.75);
    case "PINK":
      return Colors.pinkAccent.withOpacity(0.6);
    default:
      return Colors.blue.withOpacity(0.8);
  }
}

void showDialogErrors({required BuildContext context, required List<String> errors, required String title}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text('$title', style: TextStyle(color: Colors.orangeAccent),),
        content: Container(
          height: 40.0 * errors.length,
          width: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            errors.map((error) => Text('$error', style: TextStyle(color: Colors.redAccent),)).toList(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'))
        ],
      ));
}

void validateOtp({required BuildContext context, required String otp, required String email, required Function(bool) callBack}) {
  List<String> numbers = ["","","",""];
  bool verifyRs = false;
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context){
        return Column(
          children: [
            SizedBox(height: 20,),
            Text('We sent otp code to $email\nPlease verify it !', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),),
            SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildOtpInput(onChange: (value){
                  numbers[0] = value;
                }),
                buildOtpInput(onChange: (value){
                  numbers[1] = value;
                }),
                buildOtpInput(onChange: (value){
                  numbers[2] = value;
                }),
                buildOtpInput(onChange: (value){
                  numbers[3] = value;
                }),
              ],
            ),
            SizedBox(height: 50,),
            SizedBox(height: 20,),
            InkWell(
              onTap: (){
                String values = numbers[0] + numbers[1] + numbers[2] + numbers[3];
                if (values == otp) {
                  callBack(true);
                }
                else {
                  showDialogErrors(context: context, errors: ["This code is wrong"], title: 'Verify failure');
                }
              },
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Center(child: Text('Verify', style: TextStyle(color: Colors.black),)),
              ),
            )
          ],
        );
      }
  );
}
Container buildOtpInput({required Function(String) onChange}) {
  return Container(
    width: 50,
    child: TextFormField(
      onChanged: onChange,
      style: TextStyle(fontSize: 18, color: Colors.black),
      decoration: otpDecoration,
    ),
  );
}