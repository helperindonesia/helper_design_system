import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';
import 'package:video_player/video_player.dart';

class MediaThumbnail extends StatefulWidget {
  final File? file;
  final VoidCallback? onPressed;
  final MediaType mediaType;
  final String? mediaUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry margin;
  final bool isWithIcon;
  final VoidCallback? onIconPressed;

  const MediaThumbnail({
    Key? key,
    this.file,
    this.onPressed,
    this.mediaType = MediaType.image,
    this.mediaUrl,
    this.width,
    this.height,
    this.borderRadius,
    required this.margin,
    this.isWithIcon = false,
    this.onIconPressed,
  }) : super(key: key);

  @override
  _MediaThumbnailState createState() => _MediaThumbnailState();
}

class _MediaThumbnailState extends State<MediaThumbnail> {
  VideoPlayerController? _controller;
  bool _showLoading = true;

  @override
  void initState() {
    super.initState();
    if (widget.mediaType == MediaType.video) {
      if (widget.file != null) {
        _controller = VideoPlayerController.file(widget.file!)..initialize();
      }

      if (widget.mediaUrl != null) {
        _controller = VideoPlayerController.network(widget.mediaUrl!)
          ..initialize();
      }

      _controller!.addListener(() {
        if (_controller!.value.isInitialized) {
          setState(() {
            _showLoading = false;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var image = widget.file != null
        ? Image.file(
            widget.file!,
            fit: BoxFit.cover,
          )
        : Image.network(
            widget.mediaUrl!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;

              return Center(child: CircularProgressIndicator());
            },
          );

    Widget _buildWidget() {
      switch (widget.mediaType) {
        case MediaType.image:
          return image;
        case MediaType.video:
          return _showLoading
              ? Center(child: CircularProgressIndicator())
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    VideoPlayer(_controller!),
                    Opacity(
                      opacity: 0.7,
                      child: Icon(
                        Icons.play_circle_fill,
                        color: HelperColors.white,
                        size: 40.0,
                      ),
                    )
                  ],
                );
        default:
          return Container();
      }
    }

    return !widget.isWithIcon
        ? InkWell(
            onTap: widget.onPressed,
            child: Container(
              margin: widget.margin,
              width: widget.width ?? 76.0,
              height: widget.height ?? 76.0,
              child: ClipRRect(
                  borderRadius:
                      widget.borderRadius ?? BorderRadius.circular(12),
                  child: _buildWidget()),
            ),
          )
        : Container(
            margin: widget.margin,
            width: widget.width ?? 80.0,
            height: widget.height ?? 82.0,
            color: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: widget.onPressed,
                    child: Container(
                      height: 76.0,
                      width: 76.0,
                      child: ClipRRect(
                        borderRadius:
                            widget.borderRadius ?? BorderRadius.circular(12.0),
                        child: _buildWidget(),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: widget.onIconPressed,
                    child: Container(
                      height: 20.0,
                      width: 20.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: HelperColors.white,
                      ),
                      child: Icon(
                        Icons.remove_circle_rounded,
                        size: 20,
                        color: HelperColors.black3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
