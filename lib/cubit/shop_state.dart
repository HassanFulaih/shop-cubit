import '../models/change_fav_model.dart';
import '../models/login_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopBottomNavStatus extends ShopStates {}

class ShopGetLoadingStatus extends ShopStates {}

class ShopGetSuccessStatus extends ShopStates {}

class ShopGetErrorStatus extends ShopStates {
  final String error;

  ShopGetErrorStatus(this.error);
}

class ShopGetCategoryLoadingStatus extends ShopStates {}

class ShopGetCategorySuccessStatus extends ShopStates {}

class ShopGetCategoryErrorStatus extends ShopStates {
  final String error;

  ShopGetCategoryErrorStatus(this.error);
}

class ShopGetFavLoadingStatus extends ShopStates {}

class ShopGetFavSuccessStatus extends ShopStates {}

class ShopGetFavErrorStatus extends ShopStates {
  final String error;

  ShopGetFavErrorStatus(this.error);
}

class ShopChangeFavLoadingStatus extends ShopStates {}

class ShopChangeFavStatus extends ShopStates {}

class ShopChangeFavSuccessStatus extends ShopStates {
  final ChangeFavourites changeFavourites;

  ShopChangeFavSuccessStatus(this.changeFavourites);
}

class ShopChangeFavErrorStatus extends ShopStates {
  final String error;

  ShopChangeFavErrorStatus(this.error);
}

class ShopUserDataLoadingStatus extends ShopStates {}

class ShopUserDataSuccessStatus extends ShopStates {
  Login userData;

  ShopUserDataSuccessStatus(this.userData);
}

class ShopUserDataErrorStatus extends ShopStates {
  final String error;

  ShopUserDataErrorStatus(this.error);
}
