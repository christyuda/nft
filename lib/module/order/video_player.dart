import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:webordernft/module/order/provider/order_provider.dart';

class VideoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Video Tutorial"),
      ),
      body: Center(
        child: Column(
          children: [
            if (orderProvider.videoController.value.isInitialized)
              AspectRatio(
                aspectRatio: orderProvider.videoController.value.aspectRatio,
                child: VideoPlayer(orderProvider.videoController),
              ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(
                    orderProvider.videoController.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                  ),
                  onPressed: () {
                    if (orderProvider.videoController.value.isPlaying) {
                      orderProvider.pauseVideo();
                    } else {
                      orderProvider.playVideo();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          orderProvider.disposeVideo();
        },
        child: Icon(Icons.stop),
      ),
    );
  }
}
