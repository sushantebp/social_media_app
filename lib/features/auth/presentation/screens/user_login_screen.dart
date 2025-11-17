import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';
import 'package:social_media_app/features/dashboard/presentation/cubit/profile_cubit.dart';

@RoutePage()
class UserLoginScreen extends StatelessWidget {
  const UserLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final router = context.router;
    final formKey = GlobalKey<FormState>();
    final bloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus,

      listener: (context, state) {
        final status = state.authStatus;
        final cubit = context.read<ProfileCubit>();

        if (status == AuthStatus.authenticated) {
          ToastHelper.success(
            context,
            state.successMessage ?? "Login successful",
          );
          Future.delayed(const Duration(seconds: 2), () {
            if (cubit.hasRegister()) {
              router.replace(const DashboardRoute());
            } else {
              router.replace(const UserRegisterFormRoute());
            }
          });
        } else if (status == AuthStatus.error) {
          ToastHelper.error(
            context,
            state.errorMessage ?? "Login failed. Please try again.",
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
                    const SizedBox(height: AppSize.marginExtraLarge),
                    Text(
                      'Welcome Back 👋',
                      style: context.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSize.marginSmall),
                    Text(
                      'Log in to continue sharing and exploring.',
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: AppSize.marginExtraLarge * 1.2),
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
                    CustomTextField(
                      placeholder: "Enter your password",
                      label: 'Password',
                      isPassword: true,
                      onChanged: (value) => bloc.add(PasswordChanged(value)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Password is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.marginLarge),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        icon: Icons.login_rounded,
                        title: "Login",
                        isLoading: state.authStatus == AuthStatus.loading,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            bloc.add(const LoginSubmitted());
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: AppSize.marginMedium),
                    Align(
                      alignment: Alignment.centerRight,
                      child: AppButton(
                        title: "Forgot Password?",
                        onPressed: () =>
                            router.push(const UserPasswordChangeRoute()),
                        type: AppButtonType.text,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: context.textTheme.bodyMedium,
                        ),
                        AppButton(
                          title: "Register",
                          onPressed: () =>
                              router.push(const UserRegisterRoute()),
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
