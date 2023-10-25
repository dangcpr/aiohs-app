import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:rmservice/utilities/constants/variable.dart';
import 'package:simple_animations/animation_controller_extension/animation_controller_extension.dart';
import 'package:simple_animations/animation_mixin/animation_mixin.dart';

import '../components/animated_text_button.dart';

enum CustomDialogType {
  SUCCESS,
  WARNING,
  FAILURE,
  DELETE,
  NETWORK_ERROR,
  UPGRADE,
  QUESTION,
  INFORMATION,
}

extension CustomDialogTypeExtension on CustomDialogType {
  static const _getCustomDialogImagePath = <CustomDialogType, String>{
    CustomDialogType.SUCCESS: "assets/images/img_success.png",
    CustomDialogType.WARNING: "assets/images/img_warning.png",
    CustomDialogType.FAILURE: "assets/images/img_failure.png",
    CustomDialogType.DELETE: "assets/images/img_delete.png",
    CustomDialogType.NETWORK_ERROR: "assets/images/img_network_error.png",
    CustomDialogType.UPGRADE: "assets/images/img_upgrade.png",
    CustomDialogType.QUESTION: "assets/images/img_question.png",
    CustomDialogType.INFORMATION: "assets/images/img_information.png",
  };

  String get getCustomDialogImagePath => _getCustomDialogImagePath[this]!;
}

Future showCustomDialog(
    {required BuildContext context,
    required CustomDialogType dialogType,
    required String msg,
    String title = "",
    String subtitle = "",
    bool headerAnimationLoop = false,
    bool dismissOnTouchOutside = true,
    bool dismissOnBackKeyPress = true,
    required bool isMultipleButton,
    Function? btnOkOnPress,
    Function? btnCancelOnPress,
    String btnOkText = "Ok",
    String btnCancelText = "Cancel",
    String? subUserName,
    String? msg2,
    bool isHaveSubButton = false,
    String subBtnText = "sub_button_text",
    Color? btnSubColor,
    Function? subBtnOnPress,
    Color? btnOkColor,
    Color? btnCancelColor}) {
  return AwesomeDialog(
    context: context,
    dialogType: DialogType.noHeader,
    animType: AnimType.topSlide,
    headerAnimationLoop: headerAnimationLoop,
    dismissOnTouchOutside: dismissOnTouchOutside,
    dismissOnBackKeyPress: dismissOnBackKeyPress,
    showCloseIcon: true,
    // closeIcon: closeIcon,
    padding: const EdgeInsets.only(
        bottom: padding.paddingLarge, top: padding.paddingMedium),
    body: Container(
      padding: const EdgeInsets.symmetric(horizontal: padding.paddingLarge),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: 80,
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset(
                  dialogType.getCustomDialogImagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: padding.paddingSmall),
            Text(title,
                style: const TextStyle(
                  fontFamily: fontApp,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
                textAlign: TextAlign.center),
            const SizedBox(height: padding.paddingSmall),
            Container(
              child: dialogType == CustomDialogType.DELETE
                  ? RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                          text: msg,
                          style: const TextStyle(
                            fontFamily: fontApp,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        TextSpan(
                          text: subUserName,
                          style: const TextStyle(
                            fontFamily: fontApp,
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        TextSpan(
                          text: msg2,
                          style: const TextStyle(
                            fontFamily: fontApp,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                      ]))
                  : Text(
                      msg,
                      style: const TextStyle(
                        fontFamily: fontApp,
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: Color.fromRGBO(51, 51, 51, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
            ),
            subtitle.isNotEmpty
                ? Container(
                    margin: const EdgeInsets.only(
                      top: padding.paddingMedium,
                      left: padding.paddingMedium,
                      right: padding.paddingMedium,
                    ),
                    child: RichText(
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: "cautious",
                              style: TextStyle(
                                fontFamily: fontApp,
                                fontWeight: FontWeight.w700,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                            const TextSpan(text: " "),
                            TextSpan(
                              text: subtitle,
                              style: const TextStyle(
                                fontFamily: fontApp,
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center))
                : Container(),
            const SizedBox(height: padding.paddingMedium),
          ],
        ),
      ),
    ),
    btnOk: isHaveSubButton && !isMultipleButton
        ? Column(children: [
            CustomAnimatedButton(
              pressEvent: () {
                Navigator.of(context, rootNavigator: false).pop();
                if (btnOkOnPress != null) btnOkOnPress.call();
              },
              text: btnOkText,
              color: btnOkColor ?? colorProject.primaryColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              buttonTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: fontSize.medium,
                fontFamily: fontApp,
              ),
              borderColor: btnOkColor ?? colorProject.primaryColor,
            ),
            const SizedBox(height: 12),
            AnimatedTextButton(
              onTap: () {
                Navigator.of(context, rootNavigator: false).pop();
                if (subBtnOnPress != null) subBtnOnPress.call();
              },
              buttonText: subBtnText,
              buttonStyle: TextStyle(
                fontFamily: fontApp,
                fontWeight: FontWeight.w600,
                fontSize: fontSize.medium,
                color: btnSubColor ?? colorProject.primaryColor,
              ),
            )
          ])
        : CustomAnimatedButton(
            pressEvent: () {
              Navigator.of(context, rootNavigator: false).pop();
              if (btnOkOnPress != null) btnOkOnPress.call();
            },
            text: btnOkText,
            color: btnOkColor ?? colorProject.primaryColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0)),
            buttonTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: fontSize.medium,
              fontFamily: fontApp,
            ),
            borderColor: btnOkColor ?? colorProject.primaryColor,
          ),
    btnCancel: isMultipleButton
        ? CustomAnimatedButton(
            pressEvent: () {
              Navigator.of(context, rootNavigator: false).pop();
              if (btnCancelOnPress != null) btnCancelOnPress.call();
            },
            text: btnCancelText,
            color: Colors.white,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0)),
            buttonTextStyle: TextStyle(
              color: btnCancelColor ?? colorProject.primaryColor,
              fontWeight: FontWeight.w600,
              fontSize: fontSize.medium,
              fontFamily: fontApp,
            ),
            borderColor: btnCancelColor ?? colorProject.primaryColor,
          )
        : null,
  ).show();
}

class CustomAnimatedButton extends StatefulWidget {
  final Function pressEvent;
  final String? text;
  final IconData? icon;
  final double width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final TextStyle? buttonTextStyle;
  final Color? borderColor;

  const CustomAnimatedButton(
      {super.key,
      required this.pressEvent,
      this.text,
      this.icon,
      this.color,
      this.height,
      this.width = double.infinity,
      this.borderRadius,
      this.buttonTextStyle,
      this.borderColor});

  @override
  _CustomAnimatedButtonState createState() => _CustomAnimatedButtonState();
}

class _CustomAnimatedButtonState extends State<CustomAnimatedButton>
    with AnimationMixin<CustomAnimatedButton> {
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    final curveAnimation = CurvedAnimation(
        parent: controller, curve: Curves.easeIn, reverseCurve: Curves.easeIn);
    _scale = Tween<double>(begin: 1, end: 0.9).animate(curveAnimation);
  }

  void _onTapDown(TapDownDetails details) {
    controller.play(duration: const Duration(milliseconds: 150));
  }

  void _onTapUp(TapUpDetails details) {
    if (controller.isAnimating) {
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.playReverse(duration: const Duration(milliseconds: 100));
        }
      });
    } else {
      controller.playReverse(duration: const Duration(milliseconds: 100));
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.pressEvent(),
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: () {
        controller.playReverse(
          duration: const Duration(milliseconds: 100),
        );
      },
      child: Transform.scale(
        scale: _scale.value,
        child: _animatedButtonUI,
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: widget.height ?? 45,
        width: widget.width,
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
            border: Border.all(
                color: widget.borderColor ?? colorProject.primaryColor),
            borderRadius: widget.borderRadius ??
                const BorderRadius.all(Radius.circular(8.0)),
            color: widget.color ?? Theme.of(context).primaryColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            widget.icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: Icon(widget.icon, color: Colors.white),
                  )
                : const SizedBox(),
            const SizedBox(width: 5),
            Flexible(
              fit: FlexFit.loose,
              child: Text(
                widget.text ?? "",
                textAlign: TextAlign.center,
                style: widget.buttonTextStyle ??
                    const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize.medium,
                      fontFamily: fontApp,
                    ),
              ),
            ),
          ],
        ),
      );
}
