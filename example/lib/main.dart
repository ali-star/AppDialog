import 'package:app_dialog/app_dialog.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fancy Dialog Example',
      theme: ThemeData.dark(),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('App Dialog Example'),
        ),
        body: Center(
            child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                AnimatedButton(
                  text: 'Info Dialog fixed width and sqare buttons',
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      borderSide: BorderSide(color: Colors.green, width: 2),
                      width: 280,
                      buttonsBorderRadius: BorderRadius.all(Radius.circular(2)),
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOM_SLIDE,
                      title: 'INFO',
                      desc: 'Dialog description here...',
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Question Dialog With Custom BTN Style',
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      dialogType: DialogType.QUESTION,
                      headerAnimationLoop: false,
                      animType: AnimType.BOTTOM_SLIDE,
                      title: 'Question',
                      desc: 'Dialog description here...',
                      buttonsTextStyle: TextStyle(color: Colors.black),
                      showCloseIcon: true,
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Info Dialog Without buttons',
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      headerAnimationLoop: true,
                      animType: AnimType.BOTTOM_SLIDE,
                      title: 'INFO',
                      desc:
                          'Lorem ipsum dolor sit amet consectetur adipiscing elit eget ornare tempus, vestibulum sagittis rhoncus felis hendrerit lectus ultricies duis vel, id morbi cum ultrices tellus metus dis ut donec. Ut sagittis viverra venenatis eget euismod faucibus odio ligula phasellus,',
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Warning Dialog',
                  color: Colors.orange,
                  pressEvent: () {
                    AppDialog(
                        context: context,
                        dialogType: DialogType.WARNING,
                        headerAnimationLoop: false,
                        animType: AnimType.TOP_SLIDE,
                        showCloseIcon: true,
                        closeIcon: Icon(Icons.close_fullscreen_outlined),
                        title: 'Warning',
                        desc:
                            'Dialog description here..................................................',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {})
                      ..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Error Dialog',
                  color: Colors.red,
                  pressEvent: () {
                    AppDialog(
                        context: context,
                        dialogType: DialogType.ERROR,
                        animType: AnimType.RIGHT_SLIDE,
                        headerAnimationLoop: false,
                        title: 'Error',
                        desc:
                            'Dialog description here..................................................',
                        btnOkOnPress: () {},
                        btnOkIcon: Icons.cancel,
                        btnOkColor: Colors.red)
                      ..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Succes Dialog',
                  color: Colors.green,
                  pressEvent: () {
                    AppDialog(
                        context: context,
                        animType: AnimType.LEFT_SLIDE,
                        headerAnimationLoop: false,
                        dialogType: DialogType.SUCCESS,
                        title: 'Succes',
                        desc:
                            'Dialog description here..................................................',
                        btnOkOnPress: () {
                          debugPrint('OnClcik');
                        },
                        btnOkIcon: Icons.check_circle,
                        onDismissCallback: () {
                          debugPrint('Dialog Dissmiss from callback');
                        })
                      ..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'No Header Dialog',
                  color: Colors.cyan,
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      headerAnimationLoop: false,
                      dialogType: DialogType.NO_HEADER,
                      title: 'No Header',
                      desc:
                          'Dialog description here..................................................',
                      btnOkOnPress: () {
                        debugPrint('OnClick');
                      },
                      btnOkIcon: Icons.check_circle,
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Custom Body Dialog',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      body: Center(
                        child: Text(
                          'If the body is specified, then title and description will be ignored, this allows to further customize the dialogue.',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'No Vertical Margin Dialog',
                  color: Colors.blue,
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      animType: AnimType.SMOOTH_SCALE,
                      animDuration: Duration(milliseconds: 270),
                      dialogType: DialogType.NO_HEADER,
                      body: Container(
                        height: 120.0,
                        child: Column(
                          children: [
                            Container(width: 20.0, height: 2.0, color: Colors.white),
                            Spacer(),
                            Row(
                              children: [
                                Container(width: 2.0, height: 20.0, color: Colors.white),
                                Spacer(),
                                Container(
                                  width: 300.0,
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'The body takes all of the dialog space',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontStyle: FontStyle.italic),
                                  ),
                                ),
                                Spacer(),
                                Container(width: 2.0, height: 20.0, color: Colors.white),
                              ],
                            ),
                            Spacer(),
                            Container(width: 20.0, height: 2.0, color: Colors.white),
                          ],
                        ),
                      ),
                      title: 'This is Ignored',
                      desc: 'This is also Ignored',
                      noVerticalMargin: true,
                      padding: EdgeInsets.zero,
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Auto Hide Dialog',
                  color: Colors.purple,
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      dialogType: DialogType.INFO,
                      animType: AnimType.SCALE,
                      title: 'Auto Hide Dialog',
                      desc: 'AutoHide after 2 seconds',
                      autoHide: Duration(seconds: 2),
                    )..show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Testing Dialog',
                  color: Colors.orange,
                  pressEvent: () {
                    AppDialog(
                      context: context,
                      keyboardAware: true,
                      dismissOnBackKeyPress: false,
                      dialogType: DialogType.WARNING,
                      animType: AnimType.BOTTOM_SLIDE,
                      btnCancelText: "Cancel Order",
                      btnOkText: "Yes, I will pay",
                      title: 'Continue to pay?',
                      padding: const EdgeInsets.all(16.0),
                      desc:
                          'Please confirm that you will pay 3000 INR within 30 mins. Creating orders without paying will create penalty charges, and your account may be disabled.',
                      btnCancelOnPress: () {},
                      btnOkOnPress: () {},
                    ).show();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                AnimatedButton(
                  text: 'Body with Input',
                  color: Colors.blueGrey,
                  pressEvent: () {
                    AppDialog dialog;
                    dialog = AppDialog(
                      context: context,
                      animType: AnimType.SCALE,
                      dialogType: DialogType.INFO,
                      keyboardAware: true,
                      body: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Form Data',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                autofocus: true,
                                minLines: 1,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Title',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Material(
                              elevation: 0,
                              color: Colors.blueGrey.withAlpha(40),
                              child: TextFormField(
                                autofocus: true,
                                keyboardType: TextInputType.multiline,
                                maxLengthEnforced: true,
                                minLines: 2,
                                maxLines: null,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Description',
                                  prefixIcon: Icon(Icons.text_fields),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            AnimatedButton(
                                text: 'Close',
                                pressEvent: () {
                                  dialog.dismiss();
                                })
                          ],
                        ),
                      ),
                    )..show();
                  },
                ),
              ],
            ),
          ),
        )));
  }
}
