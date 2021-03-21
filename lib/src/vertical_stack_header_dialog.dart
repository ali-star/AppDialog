import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VerticalStackDialog extends StatelessWidget {
  final String? title;
  final String? desc;
  final Widget? btnOk;
  final Widget? btnCancel;
  final Widget? header;
  final Widget? body;
  final bool isDense;
  final AlignmentGeometry? alignment;
  final EdgeInsetsGeometry? padding;
  final bool keyboardAware;
  final double? width;
  final bool showCloseIcon;
  final Function onClose;
  final Widget? closeIcon;
  final Color? dialogBackgroundColor;
  final BorderSide? borderSide;
  final bool noVerticalMargin;
  final BorderRadius? backgroundBorderRadius;

  const VerticalStackDialog({
    Key? key,
    required this.title,
    required this.desc,
    this.btnOk,
    this.btnCancel,
    this.body,
    this.alignment,
    this.isDense = false,
    required this.header,
    this.padding,
    this.keyboardAware = false,
    this.width,
    this.showCloseIcon = false,
    required this.onClose,
    this.closeIcon,
    this.dialogBackgroundColor = Colors.transparent,
    this.borderSide,
    this.noVerticalMargin = false,
    this.backgroundBorderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: EdgeInsets.only(
          bottom: keyboardAware ? MediaQuery.of(context).viewInsets.bottom : 0),
      child: Stack(
        children: <Widget>[
          Container(
            width: width ?? MediaQuery.of(context).size.width,
            padding: isDense
                ? const EdgeInsets.only(
                    top: 65.0, left: 15.0, right: 15.0, bottom: 10.0)
                : const EdgeInsets.only(
                    top: 65.0, left: 40.0, right: 40.0, bottom: 10.0),
            child: Material(
              shape: RoundedRectangleBorder(
                borderRadius: backgroundBorderRadius ?? BorderRadius.circular(10.0),
                side: borderSide ?? BorderSide.none,
              ),
              elevation: 0.5,
              color: dialogBackgroundColor ?? Theme.of(context).cardColor,
              child: Padding(
                padding: padding ?? EdgeInsets.zero,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(
                        height: header != null ? 50.0 : noVerticalMargin ? 0.0 : 15,
                      ),
                      body ??
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                title ?? '',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: SingleChildScrollView(
                                  physics: BouncingScrollPhysics(),
                                  child: Text(
                                    desc ?? '',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                      SizedBox(
                        height: noVerticalMargin ? 0 : 16.0,
                      ),
                      if (btnOk != null || btnCancel != null)
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              if (btnCancel != null)
                                Expanded(
                                  child: btnCancel ?? Container(),
                                ),
                              if (btnCancel != null && btnOk != null)
                                SizedBox(
                                  width: 10,
                                ),
                              if (btnOk != null)
                                Expanded(
                                  child: btnOk!,
                                )
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (header != null)
            Container(
              width: width ?? MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                    shape: CircleBorder(
                      side: borderSide ?? BorderSide.none,
                    ),
                    child: CircleAvatar(
                      backgroundColor:
                          dialogBackgroundColor ?? Theme.of(context).cardColor,
                      radius: 55.0,
                      child: header,
                    ),
                  ),
                ],
              ),
            ),
          if (showCloseIcon)
            Positioned(
              right: 50.0,
              top: 75.0,
              child: GestureDetector(
                onTap: () {
                  onClose.call();
                },
                child: closeIcon ?? Icon(Icons.close),
              ),
            ),
        ],
      ),
    );
  }
}
