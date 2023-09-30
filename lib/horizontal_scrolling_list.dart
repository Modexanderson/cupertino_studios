import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HorizontalScrollingList extends StatefulWidget {
  final imageUrl;
  final itemCount;
  const HorizontalScrollingList({
    required this.imageUrl,
    required this.itemCount,
    super.key,
  });
  @override
  _HorizontalScrollingListState createState() =>
      _HorizontalScrollingListState();
}

class _HorizontalScrollingListState extends State<HorizontalScrollingList> {
  final ScrollController _scrollController = ScrollController();
  final double _scrollAmount = 20.0; // Adjust the scroll amount as needed

  bool _scrolling = false;

  void _startScrolling(bool forward) {
    _scrolling = true;
    _scrollContinuously(forward);
  }

  void _scrollContinuously(bool forward) {
    if (!_scrolling) return; // Stop scrolling if flag is false

    _scrollController.animateTo(
      _scrollController.offset + (forward ? _scrollAmount : -_scrollAmount),
      duration:
          const Duration(milliseconds: 100), // Adjust the duration as needed
      curve: Curves.linear,
    );

    // Delay the next scroll step
    Future.delayed(const Duration(milliseconds: 100), () {
      _scrollContinuously(forward); // Continue scrolling
    });
  }

  void _stopScrolling() {
    _scrolling = false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Card(
            child: GestureDetector(
              onLongPressStart: (details) {
                _startScrolling(false); // Scroll left when long press starts
              },
              onLongPressEnd: (details) {
                _stopScrolling(); // Stop scrolling when long press ends
              },
              child: IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.offset -
                        _scrollAmount, // Adjust the scroll amount as needed
                    duration: const Duration(
                        milliseconds: 100), // Adjust the duration as needed
                    curve: Curves.linear,
                  );
                  // Perform single tap action here
                },
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.itemCount, // Replace with your item count
              itemBuilder: (context, index) {
                // Replace with your item widget
                // double? imageWidth;

                // if (index == 0) {
                //   imageWidth = MediaQuery.of(context).size.width /
                //       2; // Set width for the first image
                // }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.imageUrl[index],
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover, // Adjust the image's fit
                  ),
                );
              },
              controller: _scrollController,
            ),
          ),
          Card(
            child: GestureDetector(
              onLongPressStart: (details) {
                _startScrolling(true); // Scroll right when long press starts
              },
              onLongPressEnd: (details) {
                _stopScrolling(); // Stop scrolling when long press ends
              },
              child: IconButton(
                icon: const Icon(CupertinoIcons.forward),
                onPressed: () {
                  _scrollController.animateTo(
                    _scrollController.offset +
                        _scrollAmount, // Adjust the scroll amount as needed
                    duration: const Duration(
                        milliseconds: 100), // Adjust the duration as needed
                    curve: Curves.linear,
                  );
                  // Perform single tap action here
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
