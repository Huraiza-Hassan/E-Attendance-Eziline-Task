import 'package:get/get.dart';

class Student {
  //to make individual variable observable
  // var name = "Huraiza".obs;
  // var age = 22.obs;

  //to make the entire class observable
  var name;
  var age;
  Student({this.name, this.age});
}
