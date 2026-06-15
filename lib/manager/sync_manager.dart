import 'package:emombti/domain/constants/status.dart';
import 'package:emombti/manager/connectivity_manager.dart';
import 'package:flutter/material.dart';

enum SyncType { localToRemote, remoteToLocal }

enum SyncStopReason { none, manual, networkIdle }

class SyncJob extends ChangeNotifier {
  final String id;
  final String? key;
  final SyncType type;
  final Future<void> Function() payload;

  SyncStatus _status;
  SyncStatus get status => _status;
  set status(SyncStatus value) {
    if (_status != value) {
      _status = value;
      notifyListeners();
    }
  }

  String? _error;
  String? get error => _error;
  set error(String? value) {
    if (_error != value) {
      _error = value;
      notifyListeners();
    }
  }

  DateTime createdAt;
  DateTime? startTime;
  DateTime? pendingTime;
  DateTime? completedTime;
  int? timeout = 300;
  int duration = 0;

  double _progress = 0;
  double get progress => _progress;
  set progress(double value) {
    _progress = value.clamp(0.0, 100.0);
    notifyListeners();
  }

  SyncJob({
    required this.id,
    this.key,
    required this.type,
    required this.payload,
    SyncStatus status = SyncStatus.none,
    this.timeout = 300,
  }) : _status = status,
       createdAt = DateTime.now();
}

class SyncManager extends ChangeNotifier {
  final ConnectivityManager cm;
  SyncManager({required this.cm}) {
    cm.addListener(_onConnectivityChanged);
  }

  final List<SyncJob> _jobs = [];
  List<SyncJob> get jobs => List.unmodifiable(_jobs);

  SyncJob? get activeJob => _jobs.cast<SyncJob?>().firstWhere(
    (job) => job?.status == SyncStatus.running,
    orElse: () => null,
  );

  bool _isProcessing = false;
  bool get isProcessing => _isProcessing;

  void _onConnectivityChanged() {
    if (cm.isOnline) {
      start();
    } else {
      stop(reason: SyncStopReason.networkIdle);
    }
  }

  Future<void> start() async {
    if (_isProcessing) return;
    if (!cm.isOnline) return;

    _isProcessing = true;
    notifyListeners();
    _processJobs();
  }

  Future<void> stop({SyncStopReason reason = SyncStopReason.none}) async {
    _isProcessing = false;
    notifyListeners();
  }

  Future<void> addSyncJob(SyncJob job, {bool unique = false}) async {
    if (unique && job.key != null) {
      final exists = _jobs.any((j) => j.key == job.key);
      if (exists) return;
    }

    job.pendingTime = DateTime.now();
    _jobs.add(job);
    notifyListeners();
    if (cm.isOnline) {
      start();
    }
  }

  Future<void> _processJobs() async {
    while (_isProcessing && cm.isOnline) {
      final nextJob = _jobs.cast<SyncJob?>().firstWhere(
        (j) => j?.status == SyncStatus.none || j?.status == SyncStatus.idle,
        orElse: () => null,
      );

      if (nextJob == null) {
        _isProcessing = false;
        notifyListeners();
        break;
      }

      await _handleJob(nextJob);

      if (nextJob.status == SyncStatus.success) {
        _jobs.remove(nextJob);
        notifyListeners();
      }
    }
  }

  Future<void> _handleJob(SyncJob job) async {
    job.status = SyncStatus.running;
    job.startTime = DateTime.now();
    notifyListeners();

    try {
      if (job.timeout != null && job.timeout! > 0) {
        await job.payload().timeout(Duration(seconds: job.timeout!));
      } else {
        await job.payload();
      }
      job.status = SyncStatus.success;
    } catch (e) {
      debugPrint('SyncJob ${job.id} failed: $e');
      job.status = SyncStatus.failure;
      job.error = e.toString();
    } finally {
      job.completedTime = DateTime.now();
      job.duration = job.completedTime!.difference(job.startTime!).inSeconds;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    cm.removeListener(_onConnectivityChanged);
    super.dispose();
  }
}
