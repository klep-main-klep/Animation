import 'package:flutter/material.dart';
import 'package:flutter_progress_button/flutter_progress_button.dart';

class AnimatedButton extends StatefulWidget{
  final String initialText, finalText; 
  final ButtonStyles buttonStyle;
  final IconData iconData;
  final double iconSize;
  final Duration animationDuration;
  //final function onTap;

  AnimatedButton(
    {this.initialText, this.finalText, this.iconData, this.iconSize, this.animationDuration, this.buttonStyle});
  
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
  with TickerProviderStateMixin {
  //AnimationController loadcontroller;
  AnimationController _controller;
  ButtonState _currentState;
  Duration _smallDuration;
  Animation<double> _scaleFinalTextAnimation;

  @override
  void initState(){
    super.initState();
    _currentState = ButtonState.SHOW_ONLY_TEXT;
    _smallDuration = Duration(milliseconds: (widget.animationDuration.inMilliseconds * 0.2).round());
    _controller = AnimationController(vsync: this, duration: widget.animationDuration); 
    _controller.addListener(() {
      double _controllerValue = _controller.value;
      if ( _controllerValue < 0.3 ) {
        setState(() {
          _currentState= ButtonState.SHOW_ONLY_ICON;
        });
          
      }
      else if (_controllerValue > 0.7){
        setState(() {
          _currentState = ButtonState.SHOW_TEXT_ICON;
        });
          
      }
    });
    /*loadcontroller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    loadcontroller.repeat(reverse: false);*/
    //super.initState();
    _controller.addStatusListener((currentStatus) { 
      if(currentStatus == AnimationStatus.completed){
        print("the button clicked");
      }
    });
    _scaleFinalTextAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }
@override
  void dispose(){
    _controller.dispose();
    //loadcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      //border: Border.all(color: (_currentState == ButtonState.SHOW_ONLY_ICON) ? widget.buttonStyle.secondaryColor : Colors.transparent ) ,
      borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)) ,
      elevation: widget.buttonStyle.elevation,
      child: InkWell(
        onTap: (){
          //loadcontroller.forward();
          _controller.forward();
          /*setState(() {
            _currentState = ButtonState.SHOW_ONLY_ICON;
          });*/

        },

        child: AnimatedContainer(
          duration: _smallDuration,
          height: widget.iconSize + 16.0,
          decoration: BoxDecoration(
            color: (_currentState == ButtonState.SHOW_ONLY_ICON) ? widget.buttonStyle.primaryColor : widget.buttonStyle.secondaryColor,
            border: Border.all(color: (_currentState == ButtonState.SHOW_ONLY_ICON) ? widget.buttonStyle.secondaryColor : Colors.transparent ) ,
            borderRadius: BorderRadius.all(Radius.circular(widget.buttonStyle.borderRadius)) ,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: (_currentState == ButtonState.SHOW_ONLY_ICON) ? 16.0 : 48.0, 
            vertical : 8.0),
        
        child: AnimatedSize(
          vsync: this,
          curve:Curves.easeIn,
          duration:  _smallDuration,
          
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              (_currentState == ButtonState.SHOW_ONLY_ICON) 
                ? Icon(widget.iconData, size: widget.iconSize,color: widget.buttonStyle.secondaryColor,
                  ) : Container(),
              
              (_currentState == ButtonState.SHOW_ONLY_TEXT) 
              ? Text(widget.initialText, style: widget.buttonStyle.initialTextStyle,
              ): Container(),
              getTextWidget()
            ],

          ),
        ),
      ),
    ),
    );
  }
  Widget getTextWidget(){
    /*if(_currentState == ButtonState.SHOW_ONLY_TEXT){
      return Text(
        widget.initialText,
        style: widget.buttonStyle.initialTextStyle,
      );
    } else*/ if (_currentState == ButtonState.SHOW_ONLY_ICON) {
      return Container();
    } else {
      return ScaleTransition(
        scale: _scaleFinalTextAnimation,
        child: Text(
          widget.finalText,
          style: widget.buttonStyle.finalTextStyle,
          ),
          );
    }
  }
}
class ButtonStyles {
  final TextStyle initialTextStyle, finalTextStyle;
  final Color primaryColor, secondaryColor;
  final double elevation, borderRadius;

  ButtonStyles({this.finalTextStyle, this.initialTextStyle, this.primaryColor, this.secondaryColor, this.elevation, this.borderRadius});
}
enum ButtonState{
   SHOW_ONLY_TEXT,
   SHOW_ONLY_ICON,
   SHOW_TEXT_ICON
}