import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_media_app/core/core.dart';
import 'package:social_media_app/features/auth/auth.dart';

@RoutePage()
class UserEmailVerifyScreen extends StatelessWidget {
  final String email;

  const UserEmailVerifyScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final router = context.router;
    final bloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listenWhen: (previous, current) =>
          previous.authStatus != current.authStatus,

      listener: (context, state) {
        final status = state.authStatus;
        if (status == AuthStatus.authenticated) {
          ToastHelper.success(
            context,
            state.successMessage ?? "Email verified successful",
          );

          Future.delayed(
            const Duration(milliseconds: 1242),
            () => router.replace(const UserLoginRoute()),
          );
        } else if (status == AuthStatus.error) {
          ToastHelper.error(
            context,
            state.errorMessage ??
                "Email verification failed. Please try again.",
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
                      'Verify Your Email',
                      style: context.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSize.marginSmall),
                    Text(
                      'We sent a verification code to:',
                      style: context.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(email, style: context.textTheme.bodyMedium),
                    const SizedBox(height: AppSize.marginExtraLarge * 1.5),
                    CustomTextField(
                      placeholder: 'Enter verification code',
                      label: 'Verification Code',
                      keyboardType: TextInputType.number,
                      onChanged: (value) => bloc.add(CodeChanged(value)),
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return "Code is required";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: AppSize.marginLarge),
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        title: 'Verify',
                        isLoading: state.authStatus == AuthStatus.loading,
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            bloc.add(const VerifyUserEmail());
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: AppSize.marginMedium),
                    Center(
                      child: AppButton(
                        title: 'Resend Code',
                        onPressed: () {},
                        type: AppButtonType.text,
                      ),
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
