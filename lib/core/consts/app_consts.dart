class AppConst {
  static final AppConst instance = AppConst();

  //Endpoints
  final String getMenu = "/menu/get-menu";
  final String createMenuElement = "/menu/create-element";
  final String deleteMenuElement = "/menu/delete-element";
  final String updateMenuElement = "/menu/update-element";
  final String getActiveEvents = "/games/get-active-events";
  final String userPosts = "/user/user-posts";
  final String userScores = "/user/user-scores";
  final String userFoods = "/user/user-foods";
  final String users = "/community/users";
  final String orders = "/order/orders";
  final String createOrder = "/order/create-order";
  final String deleteOrder = "/order/delete-order";
  final String changeOrderState = "/order/change-order-state";
}
