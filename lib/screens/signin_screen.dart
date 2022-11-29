import 'package:bloc_form_validation/screens/bloc/signin_bloc.dart';
import 'package:bloc_form_validation/screens/bloc/signin_event_bloc.dart';
import 'package:bloc_form_validation/screens/bloc/signin_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            BlocBuilder<SignInBloc,SignInState>(
                builder: (context,state){
                  if(state is SignInErrorState){
                    return Text('Error',style: TextStyle(color: Colors.red,fontSize: 20));
                  }
                  else{
                    return Container();
                  }
                },
            ),
            SizedBox(height: 30),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              onChanged: (value){
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(emailController.text, passwordController.text));
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
              ),
              onChanged: (value){
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(emailController.text, passwordController.text));
              },
            ),
            SizedBox(height: 30),
            SizedBox(
                width: 350,
                child: BlocBuilder<SignInBloc,SignInState>(
                    builder: (context,state){

                      if(state is SignInLoadingState){
                        return Center(child: CircularProgressIndicator());
                      }
                      return CupertinoButton(child: Text('Sign In'),color: (state is SignInValidState) ? Colors.blue :Colors.grey, onPressed: (){
                        if(state is SignInValidState){
                          BlocProvider.of<SignInBloc>(context).add(SignInSubmittedEvent(emailController.text, passwordController.text));
                        }
                      });

                    }
      )
    )
          ],
        ),
      ),
    );
  }
}
