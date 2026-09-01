class ApiUrls {

  static const baseURL = 'https://aseelrealestate.runasp.net/api/';
  static const register = '${baseURL}Auth/register';
  static const userProfile = '${baseURL}users/profile';
  static const login = '${baseURL}Auth/login';
  static const sendCode = '${baseURL}Auth/SendCode';
  static const verifyCode = '${baseURL}Auth/RestPassword';
  static const propertyType = '${baseURL}PropertyTypes';
  static const property = '${baseURL}Properties';
  static const favorites = '${baseURL}Favorites';
  static String favoritesByUserId(String userId) => '$favorites/$userId';
}
