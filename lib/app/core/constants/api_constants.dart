class ApiConstants {
  static const String baseUrl =
      "https://product-management-seven-xi.vercel.app";


  static const String register = "/api/v1/users/register";
  static const String login = "/api/v1/auth/login";

  // Forgot Password Flow
  static const String forgotPassword = "/api/v1/auth/forgot-password";
  static const String verifyOtp = "/api/v1/auth/verify-otp";
  static const String resendOtp = "/api/v1/auth/resend-otp";
  static const String resetPassword = "/api/v1/auth/reset-password";


  static const String products = "/api/v1/products";
}