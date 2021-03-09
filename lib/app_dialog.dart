library app_dialog;

import 'package:flutter/material.dart';

import 'src/animated_button.dart';
import 'src/anims/anims.dart';
import 'src/anims/flare_header.dart';
import 'src/vertical_stack_header_dialog.dart';

export 'src/animated_button.dart';
export 'src/anims/anims.dart';
export 'src/anims/flare_header.dart';

enum DialogType { INFO, WARNING, ERROR, SUCCESS, QUESTION, NO_HEADER }
enum AnimType {
  SCALE,
  LEFT_SLIDE,
  RIGHT_SLIDE,
  BOTTOM_SLIDE,
  TOP_SLIDE,
  FADE,
  SMOOTH_SCALE
}

class AppDialog {
  /// [@required]
  final BuildContext context;

  /// Dialog Type can be INFO, WARNING, ERROR, SUCCESS, NO_HEADER
  final DialogType dialogType;

  /// Widget with priority over DialogType, for a custom header widget
  final Widget customHeader;

  /// Dialog Title
  final String title;

  /// Set the description text of the dialog.
  final String desc;

  /// Create your own Widget for body, if this property is set title and description will be ignored.
  final Widget body;

  /// Btn OK props
  final String btnOkText;
  final IconData btnOkIcon;
  final Function btnOkOnPress;
  final Color btnOkColor;

  /// Btn Cancel props
  final String btnCancelText;
  final IconData btnCancelIcon;
  final Function btnCancelOnPress;
  final Color btnCancelColor;

  /// Custom Btn OK
  final Widget btnOk;

  /// Custom Btn Cancel
  final Widget btnCancel;

  /// Barrier Dismissible
  final bool dismissOnTouchOutside;

  /// Callback to execute after dialog get dismissed
  final Function onDismissCallback;

  /// Anim Type can be { SCALE, LEFT_SLIDE, RIGHT_SLIDE, BOTTOM_SLIDE, TOP_SLIDE, SMOOTH_SCALE }
  final AnimType animType;

  /// Alignment of the Dialog
  final AlignmentGeometry alignment;

  /// Padding off inner content of Dialog
  final EdgeInsetsGeometry padding;

  /// This Prop is useful to Take advantage of screen dimensions
  final bool isDense;

  /// Whenever the animation Header loops or not.
  final bool headerAnimationLoop;

  /// To use the RootNavigator
  final bool useRootNavigator;

  /// For Auto Hide Dialog after some Duration.
  final Duration autoHide;

  ///Control if add or not the Padding EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom).
  final bool keyboardAware;

  ///Control if Dialog is dismiss by back key.
  final bool dismissOnBackKeyPress;

  ///Max with of entire Dialog.
  final double width;

  ///Border Radius for built in buttons.
  final BorderRadiusGeometry buttonsBorderRadius;

  ///TextStyle for built in buttons.
  final TextStyle buttonsTextStyle;

  /// Control if close icon is appear.
  final bool showCloseIcon;

  /// Custom closeIcon.
  final Widget closeIcon;

  /// Custom background color for dialog + header
  final Color dialogBackgroundColor;

  /// Set BorderSide of DialogShape
  final BorderSide borderSide;

  /// Set zero margin of dialog if true
  final bool noVerticalMargin;

  /// Changes the BorderRadius of the dialog background
  final BorderRadius backgroundBorderRadius;

  /// Custom duration for dialog animation
  final Duration animDuration;

  AppDialog(
      {@required this.context,
      this.dialogType = DialogType.INFO,
      this.customHeader,
      this.title,
      this.desc,
      this.body,
      this.btnOk,
      this.btnCancel,
      this.btnOkText,
      this.btnOkIcon,
      this.btnOkOnPress,
      this.btnOkColor,
      this.btnCancelText,
      this.btnCancelIcon,
      this.btnCancelOnPress,
      this.btnCancelColor,
      this.onDismissCallback,
      this.isDense = false,
      this.dismissOnTouchOutside = true,
      this.headerAnimationLoop = true,
      this.alignment = Alignment.center,
      this.animType = AnimType.SCALE,
      this.animDuration,
      this.padding,
      this.useRootNavigator = false,
      this.autoHide,
      this.keyboardAware = true,
      this.dismissOnBackKeyPress = true,
      this.width,
      this.buttonsBorderRadius,
      this.showCloseIcon = false,
      this.closeIcon,
      this.dialogBackgroundColor,
      this.backgroundBorderRadius,
      this.borderSide,
      this.buttonsTextStyle,
      this.noVerticalMargin = false})
      : assert(
          context != null,
        );

  bool isDismissedBySystem = false;

  Future show() => showDialog(
          context: this.context,
          barrierDismissible: dismissOnTouchOutside,
          builder: (BuildContext context) {
            if (autoHide != null) {
              Future.delayed(autoHide).then((value) => dismiss());
            }
            switch (animType) {
              case AnimType.SCALE:
                return ScaleFade(
                  scale: 0.1,
                  fade: true,
                  curve: Curves.fastLinearToSlowEaseIn,
                  child: _buildDialog,
                  duration: animDuration,
                );
                break;
              case AnimType.LEFT_SLIDE:
                return FadeIn(
                    from: SlideFrom.LEFT,
                    child: _buildDialog,
                    duration: animDuration);
                break;
              case AnimType.RIGHT_SLIDE:
                return FadeIn(
                    from: SlideFrom.RIGHT,
                    child: _buildDialog,
                    duration: animDuration);
                break;
              case AnimType.BOTTOM_SLIDE:
                return FadeIn(
                    from: SlideFrom.BOTTOM,
                    child: _buildDialog,
                    duration: animDuration);
                break;
              case AnimType.TOP_SLIDE:
                return FadeIn(
                    from: SlideFrom.TOP,
                    child: _buildDialog,
                    duration: animDuration);
                break;
              case AnimType.FADE:
                return FadeIn(child: _buildDialog, duration: animDuration);
                break;
              case AnimType.SMOOTH_SCALE:
                return ScaleFade(
                    scale: 0.8,
                    fade: true,
                    curve: Curves.easeOutCirc,
                    child: _buildDialog,
                    duration: animDuration);
                break;
              default:
                return _buildDialog;
            }
          }).then((_) {
        isDismissedBySystem = true;
        if (onDismissCallback != null) onDismissCallback();
      });

  Widget get _buildHeader {
    if (customHeader != null) return customHeader;
    if (dialogType == DialogType.NO_HEADER) return null;
    return FlareHeader(
      loop: headerAnimationLoop,
      dialogType: this.dialogType,
    );
  }

  Widget get _buildDialog => WillPopScope(
        onWillPop: _onWillPop,
        child: VerticalStackDialog(
          dialogBackgroundColor: dialogBackgroundColor,
          borderSide: borderSide,
          header: _buildHeader,
          title: this.title,
          desc: this.desc,
          body: this.body,
          isDense: isDense,
          alignment: alignment,
          keyboardAware: keyboardAware,
          width: width,
          padding: padding ?? EdgeInsets.only(left: 5, right: 5),
          btnOk: btnOk ?? (btnOkOnPress != null ? _buildFancyButtonOk : null),
          btnCancel: btnCancel ??
              (btnCancelOnPress != null ? _buildFancyButtonCancel : null),
          showCloseIcon: this.showCloseIcon,
          onClose: dismiss,
          closeIcon: closeIcon,
          noVerticalMargin: noVerticalMargin,
          backgroundBorderRadius: backgroundBorderRadius,
        ),
      );

  Widget get _buildFancyButtonOk => AnimatedButton(
        isFixedHeight: false,
        pressEvent: () {
          dismiss();
          btnOkOnPress?.call();
        },
        text: btnOkText ?? 'Ok',
        color: btnOkColor ?? Color(0xFF00CA71),
        icon: btnOkIcon,
        borderRadius: buttonsBorderRadius,
        buttonTextStyle: buttonsTextStyle,
      );

  Widget get _buildFancyButtonCancel => AnimatedButton(
        isFixedHeight: false,
        pressEvent: () {
          dismiss();
          btnCancelOnPress?.call();
        },
        text: btnCancelText ?? 'Cancel',
        color: btnCancelColor ?? Colors.red,
        icon: btnCancelIcon,
        borderRadius: buttonsBorderRadius,
        buttonTextStyle: buttonsTextStyle,
      );

  dismiss() {
    if (!isDismissedBySystem)
      Navigator.of(context, rootNavigator: useRootNavigator)?.pop();
  }

  Future<bool> _onWillPop() async => dismissOnBackKeyPress;
}
