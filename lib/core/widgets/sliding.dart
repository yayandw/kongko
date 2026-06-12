import 'package:flutter/material.dart';

class SlidingSegmentedControl extends StatefulWidget {
  final List<String> labels;
  final List<Widget> children;

  const SlidingSegmentedControl({super.key, required this.labels, required this.children})
    : assert(labels.length == children.length);

  @override
  State<StatefulWidget> createState() => _SlidingSegmentedControlState();
}

class _SlidingSegmentedControlState extends State<SlidingSegmentedControl> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          decoration: BoxDecoration(
            color: Color(0xFFEEEEEE),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              AnimatedAlign(
                duration: Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                alignment: _selectedIndex == 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: FractionallySizedBox(
                  widthFactor: 0.5,
                  child: Container(
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: List.generate(widget.labels.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedIndex = index),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: Text(
                          widget.labels[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.black45,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
        AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: KeyedSubtree(
            key: ValueKey(_selectedIndex),
            child: widget.children[_selectedIndex],
          ),
        ),
      ],
    );
  }
}
