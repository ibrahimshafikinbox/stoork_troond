import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:troond/views/chat/model/chat_message_model.dart';

class ChatVoiceManager {
  final VoidCallback onStateChanged;

  // Recording State
  bool isRecording = false;
  int recordingSeconds = 0;
  Timer? _recordTimer;

  // Playback State
  String? playingMessageId;
  bool isPlaying = false;
  double playbackProgress = 0.0;
  Timer? _playbackTimer;

  ChatVoiceManager({required this.onStateChanged});

  void startRecording() {
    isRecording = true;
    recordingSeconds = 0;
    onStateChanged();

    _recordTimer?.cancel();
    _recordTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      recordingSeconds++;
      onStateChanged();
    });
  }

  void cancelRecording() {
    _recordTimer?.cancel();
    isRecording = false;
    recordingSeconds = 0;
    onStateChanged();
  }

  int stopRecording() {
    _recordTimer?.cancel();
    final duration = recordingSeconds > 0 ? recordingSeconds : 1;
    isRecording = false;
    recordingSeconds = 0;
    onStateChanged();
    return duration;
  }

  void togglePlayVoice(ChatMessageModel message) {
    if (playingMessageId == message.id && isPlaying) {
      stopPlayback();
      return;
    }

    stopPlayback();
    playingMessageId = message.id;
    isPlaying = true;
    playbackProgress = 0.0;
    onStateChanged();

    final totalSeconds = (message.voiceDurationSeconds ?? 5).clamp(1, 120);
    const stepMs = 100;
    final totalSteps = (totalSeconds * 1000) ~/ stepMs;
    int currentStep = 0;

    _playbackTimer = Timer.periodic(const Duration(milliseconds: stepMs), (timer) {
      currentStep++;
      playbackProgress = (currentStep / totalSteps).clamp(0.0, 1.0);
      onStateChanged();

      if (currentStep >= totalSteps) {
        stopPlayback();
      }
    });
  }

  void stopPlayback() {
    _playbackTimer?.cancel();
    playingMessageId = null;
    isPlaying = false;
    playbackProgress = 0.0;
    onStateChanged();
  }

  void dispose() {
    _recordTimer?.cancel();
    _playbackTimer?.cancel();
  }
}
