// import 'package:dio/dio.dart';
// import 'package:takesavenue/utils/models/user.dart';
// import 'package:takesavenue/utils/app_constants.dart';

// class AuthRepository {
//   final dio = Dio();

//   Future<User> createUserRecord({required String id, required String email, required String username}) async {
//     final userData = {
//       'email': email,
//       'username': username,
//       'id': id,
//     };

//     try {
//       var response = await dio.post(AppConstants.userUrl, data: userData);
      
//       var mapOfUser = (response.data as Map<String, dynamic>)["user"];
//       return User.fromJson(mapOfUser);
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to create user record: $e');
//     }
//   }

//   Future<User> getUserRecord({required String id}) async{
//     try {
//       var response = await dio.post("${AppConstants.loginUrl}", data: {"userId": id});

//       var mapOfUser = (response.data as Map<String, dynamic>)["user"];
//       return User.fromJson(mapOfUser);
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to get user record: $e');
//     }
//   }

//   Future<User> signInWithGoogle({required String id, required String email, required String username, String? profilePicture})async {
//     final userData = {
//       'email': email,
//       'username': username,
//       'id': id,
//       'profile_pics': profilePicture,
//     };

//     try {
//       var response = await dio.post(AppConstants.loginWithGoogleUrl, data: userData);
      
//       var mapOfUser = (response.data as Map<String, dynamic>)["user"];
//       return User.fromJson(mapOfUser);
//     } catch (e) {
//       print(e);
//       throw Exception('Failed to create user record: $e');
//     }
//   }
// }
