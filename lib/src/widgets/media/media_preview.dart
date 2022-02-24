import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';
import 'package:video_player/video_player.dart';

import 'media_type.dart';

class MediaPreview extends StatefulWidget {
  const MediaPreview({
    Key? key,
    this.file,
    this.onPressed,
    this.mediaType = MediaType.image,
    this.mediaUrl,
    this.withDeleteButton = true,
  }) : super(key: key);

  final File? file;
  final VoidCallback? onPressed;
  final MediaType mediaType;
  final String? mediaUrl;
  final bool withDeleteButton;

  @override
  _MediaPreviewState createState() => _MediaPreviewState();
}

class _MediaPreviewState extends State<MediaPreview> {
  VideoPlayerController? _controller;

  bool showLoading = true;

  @override
  void initState() {
    super.initState();

    if (widget.mediaType == MediaType.video) {
      if (widget.file != null) {
        _controller = VideoPlayerController.file(widget.file!)
          ..initialize()
          ..setLooping(true)
          ..play();
      }

      if (widget.mediaUrl != null) {
        _controller = VideoPlayerController.network(widget.mediaUrl!)
          ..initialize()
          ..setLooping(true)
          ..play();
      }

      _controller!.addListener(
        () {
          if (_controller!.value.isPlaying) {
            setState(() {
              showLoading = false;
            });
          }

          if (_controller!.value.isInitialized) {
            setState(() {
              showLoading = false;
            });
          }

          if (_controller!.value.isBuffering) {
            setState(() {
              showLoading = true;
            });
          }
        },
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final image = widget.file != null
        ? Image.file(
            widget.file!,
            fit: BoxFit.fill,
          )
        : Image.network(
            widget.mediaUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;

              return Center(child: CircularProgressIndicator());
            },
          );

    /* if (widget.mediaType == MediaType.audio) {
      return Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: SoundPlayerUI.fromTrack(
              Track(
                trackPath:
                widget.file != null ? widget.file!.path : widget.mediaUrl,
                codec: Codec.aacADTS,
              ),
              showTitle: true,
              audioFocus: AudioFocus.requestFocusAndDuckOthers,
              backgroundColor: HelperColors.GREY_COLOR_3,
            ),
          ),
        ],
      );
    }*/

    return Stack(
      fit: StackFit.expand,
      children: [
        widget.mediaType == MediaType.image
            ? image
            : AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
        if (widget.mediaType == MediaType.video)
          showLoading
              ? Center(child: CircularProgressIndicator())
              : IconButton(
                  icon: Icon(
                    _controller!.value.isPlaying
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_filled,
                    size: 48,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (_controller!.value.isPlaying)
                      setState(() {
                        _controller!.pause();
                      });
                    else
                      setState(() {
                        _controller!.play();
                      });
                  },
                ),
        widget.withDeleteButton
            ? Positioned(
                bottom: 32,
                left: 0,
                right: 0,
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: 32,
                  ),
                  onPressed: widget.mediaType == MediaType.image
                      ? widget.onPressed
                      : () {
                          setState(() {
                            _controller!.pause();
                          });
                          widget.onPressed!();
                        },
                ),
              )
            : SizedBox.shrink(),
        Positioned(
          top: 32,
          left: 0,
          child: IconButton(
            icon: Icon(
              HelperIcons.ic_arrow_left,
              size: 48,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        )
      ],
    );
  }
}
