import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/presentation/bloc/auth_bloc.dart';

@RoutePage()
class UserRegisterScreen extends StatelessWidget {
  const UserRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    final formKey = GlobalKey<FormState>();

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
                  style: context.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: AppSize.marginSmall),
                Text(
                  'Join and start connecting with people today.',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSize.marginExtraLarge * 1.2),

                // Name field
                CustomTextField(
                  placeholder: "Enter your full name",
                  label: 'Full Name',
                  onFieldSubmitted: (value) => bloc.add(NameChanged(value)),
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
                  onFieldSubmitted: (value) => bloc.add(EmailChanged(value)),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Email is required";
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
                  onFieldSubmitted: (value) => bloc.add(PasswordChanged(value)),
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Password is required";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSize.marginLarge),

                // Register Button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    isLoading: bloc.state.authStatus == AuthStatus.loading,
                    icon: Icons.person_add_alt_1_rounded,
                    title: "Register",
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {}
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
  }
}
