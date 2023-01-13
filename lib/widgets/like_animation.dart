import 'package:flutter/material.dart';

// 좋아요를 눌렀을 때 애니메이션을 실행하는 위젯
class LikeAnimation extends StatefulWidget {
  final Widget child; // 애니메이션으로 보여줄 위젯
  final bool isAnimating; // animation을 실행할지 말지 결정하는 변수
  final Duration duration; // animation의 duration
  final VoidCallback? onEnd; // animation이 끝난 후 실행할 함수
  final bool smallLike; // 작은 like 버튼인지 큰 like 버튼인지 결정하는 변수

  const LikeAnimation({
    super.key,
    required this.child,
    required this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.smallLike = false,
  });

  @override
  State<LikeAnimation> createState() => _LikeAnimationState();
}

// SingleTickerProviderStateMixin : this class is used to provide a single ticker to an animation controller.
class _LikeAnimationState extends State<LikeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    // 애니메이션 컨트롤러 생성
    _controller = AnimationController(
      vsync: this, // vsync : 애니메이션을 실행할 때 사용할 TickerProvider
      duration: Duration(milliseconds: widget.duration.inMilliseconds ~/ 2),
    );
    // 애니메이션 생성 ( scale )
    _scale = Tween<double>(begin: 1, end: 1.2).animate(_controller);
  }

  // didUpdateWidget : 위젯이 업데이트 될 때 호출되는 함수
  // covariant : 하위 클래스의 인스턴스를 받을 수 있도록 하는 키워드
  @override
  void didUpdateWidget(covariant LikeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 애니메이션 실행
    if (widget.isAnimating != oldWidget.isAnimating) {
      startAnimation();
    }
  }

  startAnimation() async {
    if (widget.isAnimating || widget.smallLike) {
      await _controller.forward(); // forward : 애니메이션 실행
      await _controller.reverse(); // reverse : 애니메이션 반대로 실행
      await Future.delayed( // Future.delayed : 일정 시간대기
        const Duration(
          milliseconds: 200,
        ),
      );

      // onEnd함수가 null이 아니면 실행 ( 객체생성시 onEnd함수를 넣어줄 수 있음 )
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    // dispose : 애니메이션 컨트롤러 해제
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ScaleTransition : scale 애니메이션을 실행할 위젯
    return ScaleTransition(
      scale: _scale,
      child: widget.child,
    );
  }
}
