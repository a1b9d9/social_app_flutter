import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/social_home_screen.dart';
import '../../shared/components/reuseble_components.dart';
import '../../shared/style/colors.dart';
import '../register/register_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var emailController = TextEditingController();
    var passController = TextEditingController();
    return BlocConsumer<SocialLoginCubit, SocialLoginStates>(
      listener: (context, state) {
        if (state is SocialLoginErrorState) {
          toast(message:state.error, state: ToastColor.error,);
        } else if(state is SocialLoginSuccessState) {
          toast(message: "Success", state: ToastColor.success,);

          naviAndExit(context,const SocialHome());
        }
      },

      builder: (context, state) {
        var bloc = SocialLoginCubit.get(context);
        return Scaffold(
          backgroundColor: defaultColorBackGround,
          appBar: AppBar(
            backgroundColor: defaultColorBackGround,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("LOGIN",
                            style: TextStyle(
                                color: defaultColor,
                                fontSize: 30,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text("Welcome To Our App Social ",
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 25,
                        ),
                        formField(
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          label: "Email Address",
                          preIcon: const Icon(Icons.email),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                          },
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        formField(
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          label: "Password",
                          preIcon: const Icon(Icons.lock),
                          obscure: bloc.secure,
                          sufIcon: IconButton(
                            icon: Icon(
                              bloc.secure
                                  ? Icons.visibility_off
                                  : Icons.remove_red_eye,
                            ),
                            onPressed: () {
                              bloc.changeIcon();
                            },
                          ),
                          validat: (value) {
                            if (value!.isEmpty) {
                              return "please enter your Password";
                            }
                          },
                          onFieldSubmitted: (v) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        state is! SocialLoginLoadingState
                            ? Container(
                                width: double.infinity,
                                color: defaultColor,
                                height: 40,
                                child: MaterialButton(
                                  onPressed: () {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus(); //هون لنسكر الكيبورد

                                    if (formKey.currentState!.validate()) {
                                      bloc.userLogin(
                                          email: emailController.text,
                                          password: passController.text);
                                    }
                                  },
                                  child: const Text("LOGIN",
                                      style:
                                          TextStyle(color: Colors.white)),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                  color: defaultColor,
                                ),
                              ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                                onPressed: () {
                                  naviAndExit(context,const Register());

                                },
                                child: Text(
                                  "REGISTER",
                                  style:
                                      TextStyle(color: defaultColor),
                                ))
                          ],
                        ),
                      ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
