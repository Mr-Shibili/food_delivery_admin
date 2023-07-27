class Api {
  static const baseUrl = 'http://3.110.170.212:8000';
  static const signIn = '$baseUrl/admin/login';
  static const categoryAdd = '$baseUrl/category/add';
  static const getCategories = '$baseUrl/category/view';
  static const addImage = '$baseUrl/image/add';
  static const editCategory = '$baseUrl/category/edit';
  static const deleteCategory = '$baseUrl/category/delete';
  static const getType = '$baseUrl/food/type/view';
  static const getSize = '$baseUrl/size/view';
  static const addProduct = '$baseUrl/product/add';
  static const getProduct = '$baseUrl/product/view';
  static const getAProduct = '$baseUrl/product/view/id?id=';
  static const deleteProduct = '$baseUrl/product/delete?id=';
}
