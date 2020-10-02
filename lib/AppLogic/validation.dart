String validateMobile(String value) {
  String patttern = r'(^[0-9]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Mobile number is Required";
  } else if(value.length != 11){
    return "Mobile number must 11 digits";
  }else if (!regExp.hasMatch(value)) {
    return "Mobile Number must be digits";
  }
  return null;
}



String validatePassword(String value){
String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$';
//RegExp regExp = new RegExp(pattern);
if(value.length==0) {
  return "Password required";
}

  return null;
}
String validateStars(String value){
  String pattern = r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[*.!@$%^&(){}[]:;<>,.?/~_+-=|\]).{8,32}$';
//RegExp regExp = new RegExp(pattern);
  if(value.length==0) {
    return "select Stars";
  }

  return null;
}
String validateEmail(String value) {
  String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.isEmpty ||
      !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value)) {
    return 'Please enter a valid email';
  }
}


//String _buildPasswordConfirmTextField() {
//    validator: (String value) {
//      if (_passwordTextController.text != value) {
//        return 'Passwords do not match.';
//      }
//    },
//}

String validateAge(String value){
  if(value.length==0){
    return "Age is required";
  }
  else if(int.parse(value) < 17){
    return " You are not eligible must be 18 or above";
  }
else if(value.length >2) {
  return "please enter correct age";
}
return null;

}

String validateName(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String validateTitle(String value) {
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Title is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Title must be a-z and A-Z";
  }
  return null;
}
String validatePrice(String value){

}
String ValidateLocation(String value){
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Location is Required";
  }
  return null;

}

String ValidateDescp(String value){
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Description is Required";
  }
  return null;

}

String ValidateComment(String value){
  String patttern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(patttern);
  if (value.length == 0) {
    return "Comment is Required";
  }
  return null;

}

