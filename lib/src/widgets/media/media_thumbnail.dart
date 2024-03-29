import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helper_design/helper_design.dart';
import 'package:video_player/video_player.dart';

class MediaThumbnail extends StatefulWidget {
  const MediaThumbnail({
    Key? key,
    this.file,
    this.onPressed,
    this.mediaType = MediaType.image,
    this.mediaUrl,
    this.width = 98,
    this.height = 98,
    this.borderRadius,
    this.margin = const EdgeInsets.only(right: 10),
    this.isWithIcon = false,
    this.onIconPressed,
    this.iconSize = 20,
  }) : super(key: key);

  final File? file;
  final VoidCallback? onPressed;
  final MediaType mediaType;
  final String? mediaUrl;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool isWithIcon;
  final VoidCallback? onIconPressed;
  final double? iconSize;

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
              width: widget.width,
              height: widget.height,
              child: ClipRRect(
                borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
                child: _buildWidget(),
              ),
            ),
          )
        : Container(
            margin: widget.margin,
            width: widget.width! + 6,
            height: widget.height! + 6,
            color: Colors.transparent,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: InkWell(
                    onTap: widget.onPressed,
                    child: Container(
                      width: widget.width,
                      height: widget.height,
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
                      height: widget.iconSize,
                      width: widget.iconSize,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50.0),
                        color: HelperColors.white,
                      ),
                      child: Icon(
                        Icons.remove_circle_rounded,
                        size: widget.iconSize,
                        color: HelperColors.black8,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
