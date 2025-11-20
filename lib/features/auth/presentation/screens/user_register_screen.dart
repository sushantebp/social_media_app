import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

@RoutePage()
class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final router = context.router;
    final formKey = GlobalKey<FormState>();

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus,

      listener: (context, state) {
        final status = state.authStatus;

        if (status == AuthStatus.unauthenticated) {
          ToastHelper.success(
            context,
            state.successMessage ?? "User Register successful",
          );
          Future.delayed(
            const Duration(seconds: 1),
            () => router.push(UserEmailVerifyRoute(email: bloc.state.email)),
          );
        } else if (status == AuthStatus.error) {
          ToastHelper.error(
            context,
            state.errorMessage ?? "Register failed. Please try again.",
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSize.paddingMedium),

              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: kToolbarHeight),
                    // Header
                    Text(
                      'Create Account ✨',
                      style: context.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSize.marginSmall),
                    Text(
                      'Join and start connecting with people today.',
                      style: context.textTheme.bodyMedium,
                    ),

                    const SizedBox(height: AppSize.marginExtraLarge * 1.2),

                    // Name field
                    CustomTextField(
                      placeholder: "Enter your full name",
                      label: 'Username',
                      onChanged: (value) => bloc.add(NameChanged(value)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Username is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.marginMedium),

                    // Email field
                    CustomTextField(
                      placeholder: "Enter your email",
                      label: 'Email',
                      onChanged: (value) => bloc.add(EmailChanged(value)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Email is required";
                        }
                        if (!AppRegex.emailRegex.hasMatch(value!)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.marginMedium),

                    // Password field
                    CustomTextField(
                      placeholder: "Create a password",
                      label: 'Password',
                      isPassword: true,
                      onChanged: (value) => bloc.add(PasswordChanged(value)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Password is required";
                        }
                        if (!AppRegex.passwordRegex.hasMatch(value!)) {
                          return 'Use 8+ chars with uppercase, lowercase, number & symbol';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.marginLarge),

                    // Register Button
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        isLoading: state.authStatus == AuthStatus.loading,
                        icon: Icons.person_add_alt_1_rounded,
                        title: "Register",
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            bloc.add(const RegisterSubmitted());
                          }
                        },
                      ),
                    ),
                    const Spacer(),
                    // Login redirect
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: context.textTheme.bodyMedium,
                        ),
                        AppButton(
                          title: "Login",
                          onPressed: () =>
                              context.pushRoute(const UserLoginRoute()),
                          type: AppButtonType.text,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
