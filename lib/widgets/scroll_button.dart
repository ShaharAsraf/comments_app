import 'package:flutter/material.dart';

class ScrollButton extends StatelessWidget {
  const ScrollButton({
    Key? key,
    required this.scrollController,
  }) : super(key: key);

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        double scrollOffset =
            scrollController.hasClients ? scrollController.offset : 0;
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: scrollOffset > MediaQuery.of(context).size.height * 0.5
              ? _renderButton()
              : const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _renderButton() {
    return FloatingActionButton(
      tooltip: "Scroll to top",
      onPressed: _scrollToTop,
      child: const Icon(
        Icons.arrow_upward,
      ),
    );
  }

  void _scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
