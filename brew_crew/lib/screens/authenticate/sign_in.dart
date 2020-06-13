import 'package:brewcrew/services/auth.dart';
import 'package:brewcrew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brewcrew/shared/constants.dart';

class SignIn extends StatefulWidget {
//contructor in widget itself
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final Authservice _auth = Authservice();
  final _formKey = GlobalKey<FormState>();
  bool loading =false;

  //text field state
  String email = '';
  String  password= '';
  String Error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign in the Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],

      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical:20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoraion.copyWith(hintText: 'Email'),
                  validator: (val)=> val.isEmpty? 'Enter an email' : null,
                  onChanged: (val) {
                  setState(() {
                    email = val;
                  });

                }

              ),
              SizedBox(height: 20.0),
              TextFormField(
                  decoration: textInputDecoraion.copyWith(hintText: 'Password'),
                  validator: (val)=> val.length < 6 ? 'Enter a password 6+ character long' : null,
                obscureText: true,
                onChanged: (val){
                  setState(() {
                    password = val;
                  });


                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pink[400],
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async{
                  if(_formKey.currentState.validate())
                  {
                    setState(() {
                      loading=true;
                    });
                    dynamic result = await _auth.signInWithEmailandPassword(email, password);


                    if(result== null){
                      setState(() {

                        Error='could not sign in with those credentials';
                        loading = false;
                      });

                    }
                  }

                }
              ),
              SizedBox(height: 20.0),
              Text(
                Error,
                style: TextStyle(color: Colors.red,fontSize: 14.0),
              ),
            ],
          )
        ),






//        child:
//        RaisedButton(
//          child: Text('Sign in anon'),
//          onPressed: () async{
//            dynamic result = await _auth.signInAnon();
//            if(result==null)
//              {
//                print('error signing in');
//              }
//            else{
//              print('signed in');
//              print(result.uid);
//            }
//
//          },
//        ),
      ),
    );
  }
}
