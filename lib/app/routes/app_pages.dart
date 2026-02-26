import 'package:get/get.dart';

import '../features/auth/forgot/views/forgot_view.dart';
import '../features/auth/login/bindings/login_binding.dart';
import '../features/auth/login/views/login_view.dart';
import '../features/auth/register/register_binding.dart';
import '../features/auth/register/view/register_view.dart';
import '../features/auth/profile/view/profile_setup_view.dart';
import '../features/auth/profile/view/profile_view.dart';
import '../features/auth/reset/views/reset_view.dart';
import '../features/auth/verify/verify_view.dart';
import '../features/product/bindings/product_binding.dart';
import '../features/product/views/EditProductView.dart';
import '../features/product/views/add_product_view.dart';
import '../features/product/views/dashboard_view.dart';
import '../features/product/views/service_detail_view.dart';

import '../features/splash/views/splash_view.dart';
import '../features/splash/bindings/splash_binding.dart';
import '../features/onboarding/views/onboarding_view.dart';
import '../features/onboarding/bindings/onboarding_binding.dart';

import '../features/location/view/location_view.dart';
import '../../language/view/language_view.dart';

import 'app_routes.dart';

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.verify,
      page: () => const VerifyView(),
    ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => const ForgotView(),
    ),
    GetPage(
      name: AppRoutes.reset,
      page: () => const ResetView(),
    ),
    GetPage(
      name: AppRoutes.location,
      page: () => const LocationView(),
    ),
    GetPage(
      name: AppRoutes.language,
      page: () => const LanguageView(),
    ),
    GetPage(
      name: AppRoutes.profileSetup,
      page: () => const ProfileSetupView(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: ProductBinding(),
    ),
    GetPage(
      name: AppRoutes.serviceDetail,
      page: () => const ServiceDetailView(),
    ),

    GetPage(
      name: AppRoutes.addProduct,
      page: () => const AddProductView(),
      binding: ProductBinding(),
    ),

    GetPage(
      name: AppRoutes.editProduct,
      page: () => const EditProductView(),
      binding: ProductBinding(),
    ),


  ];
}