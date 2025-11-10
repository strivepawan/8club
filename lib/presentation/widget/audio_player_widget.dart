import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String filePath;
  final VoidCallback onDelete;

  const AudioPlayerWidget({
    super.key,
    required this.filePath,
    required this.onDelete,
  });

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setFilePath(widget.filePath);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.audiotrack, color: Colors.blue),
      title: const Text('Audio Answer'),
      subtitle: StreamBuilder<PlayerState>(
        stream: _audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final processingState = snapshot.data?.processingState;
          if (processingState == ProcessingState.loading ||
              processingState == ProcessingState.buffering) {
            return const Text('Loading...');
          }
          return const Text('Ready to play');
        },
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(_audioPlayer.playing ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              if (_audioPlayer.playing) {
                _audioPlayer.pause();
              } else {
                _audioPlayer.seek(Duration.zero);
                _audioPlayer.play();
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: widget.onDelete,
          ),
        ],
      ),
    );
  }
}