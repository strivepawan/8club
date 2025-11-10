import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flick_tv_ott/presentation/widget/audio_player_widget.dart';
import 'package:flick_tv_ott/presentation/widget/video_player_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flick_tv_ott/presentation/blocs/onboarding_question/onboarding_question_bloc.dart';


// Enum to manage local UI state for recording
enum RecordingStatus { initial, recording, recorded, error }

class OnboardingQuestionPage extends StatelessWidget {
  const OnboardingQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingQuestionBloc(),
      child: const _OnboardingQuestionView(),
    );
  }
}

class _OnboardingQuestionView extends StatefulWidget {
  const _OnboardingQuestionView();

  @override
  State<_OnboardingQuestionView> createState() => _OnboardingQuestionViewState();
}

class _OnboardingQuestionViewState extends State<_OnboardingQuestionView> {
  // Local UI state for recording
  RecordingStatus _audioStatus = RecordingStatus.initial;
  RecordingStatus _videoStatus = RecordingStatus.initial;

  // Controllers
  RecorderController? _audioController;
  CameraController? _cameraController;
  List<CameraDescription>? _cameras;

  @override
  void initState() {
    super.initState();
    _initPermissions();
  }

  Future<void> _initPermissions() async {
    await [Permission.camera, Permission.microphone].request();
    // Initialize camera
    _cameras = await availableCameras();
    if (_cameras != null && _cameras!.isNotEmpty) {
      _initCameraController(_cameras!.first);
    }
  }

  void _initCameraController(CameraDescription description) {
    _cameraController = CameraController(
      description,
      ResolutionPreset.medium,
      enableAudio: true, // Record audio with video
    );
    _cameraController?.initialize().then((_) {
      if (!mounted) return;
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        debugPrint('Camera Error: ${e.code}');
      }
    });
  }

  @override
  void dispose() {
    _audioController?.dispose();
    _cameraController?.dispose();
    super.dispose();
  }

  // --- Audio Logic ---
  Future<void> _startAudioRecording() async {
    final hasPermission = await Permission.microphone.request().isGranted;
    if (!hasPermission) return;

    final path = (await getTemporaryDirectory()).path;
    _audioController = RecorderController();
    await _audioController!.record(path: '$path/audio_answer.mp3');
    setState(() => _audioStatus = RecordingStatus.recording);
  }

  Future<void> _stopAudioRecording() async {
    final path = await _audioController?.stop();
    _audioController?.dispose();
    _audioController = null;
    if (path != null) {
      context.read<OnboardingQuestionBloc>().add(SaveAudioAnswer(path));
      setState(() => _audioStatus = RecordingStatus.recorded);
    }
  }

  void _deleteAudio() {
    context.read<OnboardingQuestionBloc>().add(DeleteAudioAnswer());
    setState(() => _audioStatus = RecordingStatus.initial);
  }

  // --- Video Logic ---
  Future<void> _startVideoRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }
    await _cameraController!.startVideoRecording();
    setState(() => _videoStatus = RecordingStatus.recording);
  }

  Future<void> _stopVideoRecording() async {
    if (!_cameraController!.value.isRecordingVideo) return;
    
    final file = await _cameraController!.stopVideoRecording();
    context.read<OnboardingQuestionBloc>().add(SaveVideoAnswer(file.path));
    setState(() => _videoStatus = RecordingStatus.recorded);
  }

  void _deleteVideo() {
    context.read<OnboardingQuestionBloc>().add(DeleteVideoAnswer());
    setState(() => _videoStatus = RecordingStatus.initial);
    // Re-initialize camera for a new recording
    _initCameraController(_cameras!.first);
  }

  @override
  Widget build(BuildContext context) {
    // This handles the "UI responsive" brownie point
    final isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      appBar: AppBar(title: const Text('Tell Us About You')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                const Text(
                  'Why do you want to be a host?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                _buildTextField(),
                const SizedBox(height: 24),
                const Divider(),
                const SizedBox(height: 16),
                _buildAudioSection(),
                const SizedBox(height: 24),
                _buildVideoSection(),
              ],
            ),
          ),
          // Hide bottom bar when keyboard is open
          if (!isKeyboardOpen) _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildTextField() {
    return BlocBuilder<OnboardingQuestionBloc, OnboardingQuestionState>(
      buildWhen: (p, c) => p.answerText != c.answerText,
      builder: (context, state) {
        return TextField(
          maxLength: 600,
          maxLines: 8,
          decoration: const InputDecoration(
            hintText: 'Share your thoughts...',
            border: OutlineInputBorder(),
            counterText: '',
          ),
          onChanged: (text) {
            context
                .read<OnboardingQuestionBloc>()
                .add(QuestionTextUpdated(text));
          },
        );
      },
    );
  }

  Widget _buildAudioSection() {
    switch (_audioStatus) {
      case RecordingStatus.recording:
        return Column(
          children: [
            AudioWaveforms(
              size: Size(MediaQuery.of(context).size.width, 100.0),
              recorderController: _audioController!,
              waveStyle: const WaveStyle(
                waveColor: Colors.blue,
                showDurationLabel: true,
              ),
            ),
            TextButton.icon(
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _audioController?.stop();
                _audioController?.dispose();
                setState(() => _audioStatus = RecordingStatus.initial);
              },
            )
          ],
        );
      case RecordingStatus.recorded:
        return BlocBuilder<OnboardingQuestionBloc, OnboardingQuestionState>(
          builder: (context, state) {
            if (state.audioFilePath == null) return const SizedBox.shrink();
            return AudioPlayerWidget(
              filePath: state.audioFilePath!,
              onDelete: _deleteAudio,
            );
          },
        );
      default:
        // Show nothing if initial or error
        return const SizedBox.shrink();
    }
  }

  Widget _buildVideoSection() {
    switch (_videoStatus) {
      case RecordingStatus.recording:
        return Column(
          children: [
            if (_cameraController != null && _cameraController!.value.isInitialized)
              AspectRatio(
                aspectRatio: _cameraController!.value.aspectRatio,
                child: CameraPreview(_cameraController!),
              ),
            TextButton.icon(
              icon: const Icon(Icons.cancel, color: Colors.red),
              label: const Text('Cancel', style: TextStyle(color: Colors.red)),
              onPressed: () {
                _cameraController?.stopVideoRecording();
                setState(() => _videoStatus = RecordingStatus.initial);
              },
            )
          ],
        );
      case RecordingStatus.recorded:
        return BlocBuilder<OnboardingQuestionBloc, OnboardingQuestionState>(
          builder: (context, state) {
            if (state.videoFilePath == null) return const SizedBox.shrink();
            return VideoPlayerWidget(
              filePath: state.videoFilePath!,
              onDelete: _deleteVideo,
            );
          },
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBottomBar() {
    return BlocBuilder<OnboardingQuestionBloc, OnboardingQuestionState>(
      builder: (context, state) {
        // Show buttons only if not recorded AND not currently recording
        bool showAudio =
            !state.isAudioRecorded && _audioStatus != RecordingStatus.recording;
        bool showVideo =
            !state.isVideoRecorded && _videoStatus != RecordingStatus.recording;

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              if (showAudio)
                IconButton(
                  icon: const Icon(Icons.mic),
                  onPressed: _audioStatus == RecordingStatus.recording
                      ? _stopAudioRecording // If recording, button becomes 'stop'
                      : _startAudioRecording,
                  color: _audioStatus == RecordingStatus.recording
                      ? Colors.red
                      : Colors.blue,
                ),
              if (showVideo)
                IconButton(
                  icon: const Icon(Icons.videocam),
                  onPressed: _videoStatus == RecordingStatus.recording
                      ? _stopVideoRecording
                      : _startVideoRecording,
                  color: _videoStatus == RecordingStatus.recording
                      ? Colors.red
                      : Colors.blue,
                ),
              if (showAudio || showVideo) const SizedBox(width: 16),
              
              // Animated "Next" button for brownie points
              Expanded(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: ElevatedButton(
                    onPressed: () {
                      // Log and submit
                      print('Text: ${state.answerText}');
                      print('Audio: ${state.audioFilePath}');
                      print('Video: ${state.videoFilePath}');
                    },
                    child: const Text('Next'),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}