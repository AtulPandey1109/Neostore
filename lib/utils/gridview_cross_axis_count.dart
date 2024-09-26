import 'package:neostore/utils/responsive_size_helper.dart';

int myCrossAxisCount(){
  if (SizeConfig.isMobile()) {
    return 2;
  } else {
    return 3;
  }
}