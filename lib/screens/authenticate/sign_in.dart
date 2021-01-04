import 'package:ProfessionConnect/services/auth.dart';
import 'package:ProfessionConnect/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  Color mainColor = Color(0xff2FD159);

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: <Widget>[
                Container(
                  height: 650,
                  child: RotatedBox(
                    quarterTurns: 2,

                    /// -----------------------------------------
                    /// WaveWidget for background shape animation.
                    /// -----------------------------------------
                    child: WaveWidget(
                      /// -----------------------------------------
                      /// Set up all configerations with duration and colors.
                      /// -----------------------------------------
                      // backgroundColor: Colors.black,
                      config: CustomConfig(
                        gradients: [
                          [mainColor, Colors.white],
                          [mainColor, Colors.white],
                        ],
                        durations: [19440, 10800],
                        heightPercentages: [0.20, 0.15],
                        blur: MaskFilter.blur(BlurStyle.solid, 10),
                        gradientBegin: Alignment.bottomLeft,
                        gradientEnd: Alignment.topRight,
                      ),
                      waveAmplitude: 0,
                      size: Size(
                        double.infinity,
                        double.infinity,
                      ),
                    ),
                  ),
                ),

                /// -----------------------------------------
                /// Build scrollable content with ListView widget.
                /// -----------------------------------------
                Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      Container(
                        height: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            /// -----------------------------------------
                            /// Header login text.
                            /// -----------------------------------------
                            Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 28.0),
                            ),

                            /// -----------------------------------------
                            /// shaped Card with TextField child with it for adding username .
                            /// -----------------------------------------
                            Card(
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 30),
                              elevation: 11,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: TextFormField(
                                validator: (val) =>
                                    val.isEmpty ? 'Enter an email' : null,
                                onChanged: (val) {
                                  email = val;
                                  print(email);
                                },
                                decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: mainColor,
                                    ),
                                    suffixIcon: Icon(
                                      Icons.check_circle,
                                      color: mainColor,
                                    ),
                                    hintText: "email",
                                    hintStyle: TextStyle(color: Colors.black26),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20.0, vertical: 16.0)),
                              ),
                            ),

                            /// -----------------------------------------
                            /// shaped Card with TextField child with it for adding Password .
                            /// -----------------------------------------
                            Card(
                              margin:
                                  EdgeInsets.only(left: 30, right: 30, top: 20),
                              elevation: 11,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40))),
                              child: TextFormField(
                                validator: (val) => val.length < 6
                                    ? 'Enter a password 6+ chars long'
                                    : null,
                                onChanged: (val) {
                                  password = val;
                                  print(password);
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: mainColor,
                                  ),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: Colors.black26,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide.none,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40.0)),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 16.0),
                                ),
                              ),
                            ),

                            /// -----------------------------------------
                            /// shaped Container with RaisedButton child with it for Submitting login data.
                            /// -----------------------------------------
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(30.0),
                              child: RaisedButton(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                color: mainColor,
                                onPressed: () async {
                                  if (_formKey.currentState.validate()) {
                                    setState(() => loading = true);
                                    dynamic result =
                                        await _auth.signInWithEmailAndPassword(
                                            email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Could not sign in with those credentials';
                                      });
                                    }
                                  }
                                },
                                elevation: 11,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                                child: Text("Login",
                                    style: TextStyle(color: Colors.white70)),
                              ),
                            ),

                            /// -----------------------------------------
                            /// Forgot your password text.
                            /// -----------------------------------------

                            Text(
                              "Forgot your password?",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 100,
                      ),

                      /// -----------------------------------------
                      /// Aligned content to bottom of parent.
                      /// -----------------------------------------
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              "or , continue with",
                              style: TextStyle(
                                color: Colors.white70,
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  /// -----------------------------------------
                                  /// RaisedButton login through facebook auth.
                                  /// -----------------------------------------
                                  child: RaisedButton(
                                    child: Text("Google"),
                                    textColor: Colors.white,
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    ),
                                    onPressed: () {
                                      print('google');
                                    },
                                    // onPressed: ()
                                    //     //     googleSignIn().whenComplete(() {
                                    //     //   // FirebaseUser user =
                                    //     //   //     await FirebaseAuth.instance.currentUser();

                                    //     //   Navigator.of(context).pushReplacement(
                                    //     //       MaterialPageRoute(
                                    //     //           builder: (context) => HomePage()));
                                    //     // }

                                    //     async {
                                    //   signInWithGoogle()
                                    //       .then((FirebaseUser user) {
                                    //     Navigator.of(context).pushReplacement(
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 HomePage()));
                                    //   }).catchError((e) => print(e));
                                    // },
                                  ),
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Expanded(
                                  /// -----------------------------------------
                                  /// RaisedButton login through Twitter auth.
                                  /// -----------------------------------------
                                  child: RaisedButton(
                                    child: Text("Facebook"),
                                    textColor: Colors.white,
                                    color: Colors.indigo,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(40)),
                                    ),
                                    onPressed: () {},
                                  ),
                                ),
                                SizedBox(
                                  width: 20.0,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "Dont have an account?",
                                  style: TextStyle(
                                    color: Colors.white70,
                                  ),
                                ),

                                /// -----------------------------------------
                                /// FlatButton signUp .
                                /// -----------------------------------------
                                FlatButton(
                                  child: Text("Sign up"),
                                  textColor: mainColor,
                                  onPressed: () {
                                    widget.toggleView();
                                  },
                                )
                              ],
                            ),
                            Center(
                              child: Text(
                                error,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 20),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

            //
            //
            // body: Container(
            //   padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
            //   child: Form(
            //     key: _formKey,
            //     child: Column(
            //       children: <Widget>[
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           decoration:
            //               textInputDecoration.copyWith(hintText: 'email'),
            //           validator: (val) => val.isEmpty ? 'Enter an email' : null,
            //           onChanged: (val) {
            //             setState(() => email = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         TextFormField(
            //           obscureText: true,
            //           decoration:
            //               textInputDecoration.copyWith(hintText: 'password'),
            //           validator: (val) => val.length < 6
            //               ? 'Enter a password 6+ chars long'
            //               : null,
            //           onChanged: (val) {
            //             setState(() => password = val);
            //           },
            //         ),
            //         SizedBox(height: 20.0),
            //         RaisedButton(
            //             color: Colors.pink[400],
            //             child: Text(
            //               'Sign In',
            //               style: TextStyle(color: Colors.white),
            //             ),
            //             onPressed: () async {
            //               if (_formKey.currentState.validate()) {
            //                 setState(() => loading = true);
            //                 dynamic result = await _auth
            //                     .signInWithEmailAndPassword(email, password);
            //                 if (result == null) {
            //                   setState(() {
            //                     loading = false;
            //                     error =
            //                         'Could not sign in with those credentials';
            //                   });
            //                 }
            //               }
            //             }),
            //         SizedBox(height: 12.0),
            //         Text(
            //           error,
            //           style: TextStyle(color: Colors.red, fontSize: 14.0),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          );
  }
}
