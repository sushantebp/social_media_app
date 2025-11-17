class ApiEndpoint {
  static const String register = "/auth/register";
  static const String verifyEmail = "/auth/verify-email";

  static const String login = "/auth/login";

  static const String logout = "/auth/logout";

  static const String subscription = "/subscription/create";
  static const String subscriptionStatus = "/subscription/status";

  static const String createPost = "/posts/uploadpost";
  static const String getUserProfile = "/user/profile";
  static const String getPost = "/posts/getposts";

  static const String updateHobbie = "/user/hobbies";
  static const String updateAcademicQ = "/user/academic-qualification";
  static const String updateDOB = '/user/date-of-birth';
  static const String updateLocation = "/user/location";

  static const String getFollower = "/user/followers";
  static const String getFollwing = "/user/following";
  static const String followUser = "/user/follow";
  static const String unfollowUser = '/user/unfollow';
}
