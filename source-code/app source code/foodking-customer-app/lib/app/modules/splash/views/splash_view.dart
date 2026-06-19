import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:video_player/video_player.dart';

import '../../../../util/constant.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final box = GetStorage();
  final splashController = Get.find<SplashController>();
  VideoPlayerController? _videoController;
  Timer? _logoTimer;
  Timer? _imageLoadTimer;
  bool _showLogo = false;
  bool _videoReady = false;
  bool _showIntroImage = false;
  bool _introImageLoaded = false;
  String? _introImageUrl;
  bool _transitionStarted = false;
  bool _firstFrameDeferred = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.deferFirstFrame();
    _firstFrameDeferred = true;
    _playIntro();
  }

  Future<void> _playIntro() async {
    await splashController.getConfiguration();
    final mediaUrl = splashController.configData.appIntroMediaUrl?.trim();
    final mediaType = splashController.configData.appIntroMediaType
        ?.trim()
        .toLowerCase();

    if ((mediaUrl ?? '').isNotEmpty && mediaType == 'image') {
      _showNetworkImage(mediaUrl!);
      return;
    }

    final controller = (mediaUrl ?? '').isNotEmpty && mediaType == 'video'
        ? VideoPlayerController.networkUrl(Uri.parse(mediaUrl!))
        : VideoPlayerController.asset('assets/animation/kahumbointro.mp4');
    _videoController = controller;

    try {
      await controller.initialize();
      await controller.setLooping(false);
      await controller.setPlaybackSpeed(1.5);
      controller.addListener(_handleVideoProgress);
      if (!mounted) return;
      await controller.play();
      setState(() => _videoReady = true);
      _allowFirstFrame();
    } catch (_) {
      _allowFirstFrame();
      _showFullLogo();
    }
  }

  void _showNetworkImage(String url) {
    if (!mounted) return;

    _introImageUrl = url;
    _introImageLoaded = false;
    setState(() => _showIntroImage = true);
    _allowFirstFrame();
    _imageLoadTimer = Timer(const Duration(seconds: 10), _showFullLogo);
  }

  void _handleIntroImageLoaded() {
    if (_introImageLoaded || _transitionStarted || !mounted) return;

    _introImageLoaded = true;
    _imageLoadTimer?.cancel();
    _logoTimer?.cancel();
    _logoTimer = Timer(const Duration(milliseconds: 3000), _showFullLogo);
  }

  void _allowFirstFrame() {
    if (!_firstFrameDeferred) return;
    _firstFrameDeferred = false;
    WidgetsBinding.instance.allowFirstFrame();
  }

  void _handleVideoProgress() {
    final controller = _videoController;
    if (controller == null ||
        !controller.value.isInitialized ||
        _transitionStarted) {
      return;
    }

    final duration = controller.value.duration;
    final position = controller.value.position;
    if (duration != Duration.zero &&
        position >= duration - const Duration(milliseconds: 120)) {
      _showFullLogo();
    }
  }

  void _showFullLogo() {
    if (_transitionStarted || !mounted) return;
    _transitionStarted = true;
    _videoController?.pause();

    setState(() => _showLogo = true);
    _logoTimer = Timer(const Duration(milliseconds: 1500), () {
      if (mounted) {
        Get.offAll(() => const DashboardView());
      }
    });
  }

  @override
  void dispose() {
    _logoTimer?.cancel();
    _imageLoadTimer?.cancel();
    _allowFirstFrame();
    _videoController?.removeListener(_handleVideoProgress);
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/doodle.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 520),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: _showLogo
              ? const _FullLogoSplash()
              : _showIntroImage
              ? _IntroImage(
                  imageUrl: _introImageUrl,
                  onLoaded: _handleIntroImageLoaded,
                  onError: _showFullLogo,
                )
              : _IntroVideo(_videoController, _videoReady),
        ),
      ),
    );
  }
}

class _IntroImage extends StatefulWidget {
  const _IntroImage({
    required this.imageUrl,
    required this.onLoaded,
    required this.onError,
  });

  final String? imageUrl;
  final VoidCallback onLoaded;
  final VoidCallback onError;

  @override
  State<_IntroImage> createState() => _IntroImageState();
}

class _IntroImageState extends State<_IntroImage> {
  bool _notifiedLoaded = false;

  void _notifyLoaded() {
    if (_notifiedLoaded) return;
    _notifiedLoaded = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onLoaded();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.imageUrl;
    if (url == null || url.isEmpty) {
      return const SizedBox.expand(key: ValueKey('intro-image-empty'));
    }

    return SafeArea(
      key: const ValueKey('intro-image'),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.network(
              url,
              fit: BoxFit.contain,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                if (wasSynchronouslyLoaded || frame != null) {
                  _notifyLoaded();
                  return child;
                }

                return const SizedBox.expand();
              },
              errorBuilder: (context, error, stackTrace) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    widget.onError();
                  }
                });
                return const SizedBox.expand();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _IntroVideo extends StatelessWidget {
  const _IntroVideo(this.controller, this.videoReady);

  final VideoPlayerController? controller;
  final bool videoReady;

  @override
  Widget build(BuildContext context) {
    final video = controller;
    if (!videoReady || video == null || !video.value.isInitialized) {
      return const SizedBox.expand(key: ValueKey('intro-loading'));
    }

    return SafeArea(
      key: const ValueKey('intro-video'),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxVideoWidth = constraints.maxWidth * 0.86;
          final videoBoxHeight = constraints.maxHeight * 0.58;
          final videoBoxWidth = videoBoxHeight * video.value.aspectRatio;
          final fittedVideoWidth = videoBoxWidth > maxVideoWidth
              ? maxVideoWidth
              : videoBoxWidth;

          return Align(
            alignment: const Alignment(0, -0.18),
            child: Container(
              width: fittedVideoWidth,
              height: videoBoxHeight,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: VideoPlayer(video),
            ),
          );
        },
      ),
    );
  }
}

class _FullLogoSplash extends StatelessWidget {
  const _FullLogoSplash();

  @override
  Widget build(BuildContext context) {
    return Center(
      key: const ValueKey('full-logo'),
      child: Image.asset(Images.logo, height: 72.h, fit: BoxFit.contain),
    );
  }
}
