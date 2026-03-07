import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velozaje/core/utils/app_colors.dart';

class CameraToFaceRecognized extends StatefulWidget {
  static late List<CameraDescription> cameras;

  const CameraToFaceRecognized({super.key});

  @override
  State<CameraToFaceRecognized> createState() => _CameraToFaceRecognizedState();
}

class _CameraToFaceRecognizedState extends State<CameraToFaceRecognized> {
  late CameraController _cameraController;
  late Future<void> _initializeCameraFuture;
  int _cameraIndex = 0;
  late FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();
    _faceDetector = FaceDetector(
      options: FaceDetectorOptions(performanceMode: FaceDetectorMode.accurate),
    );
    _initCamera();
  }

  void _initCamera() {
    if (CameraToFaceRecognized.cameras.isNotEmpty) {
      _cameraController = CameraController(
        CameraToFaceRecognized.cameras[_cameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
      );
      _initializeCameraFuture = _cameraController.initialize();
      setState(() {});
    }
  }

  Future<void> _takePicture() async {
    await _initializeCameraFuture;

    try {
      final XFile picture = await _cameraController.takePicture();
      await _processImage(File(picture.path));
    } catch (e) {
      print("Error taking picture: $e");
    }
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    await _processImage(File(image.path));
  }

  Future<void> _processImage(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final faces = await _faceDetector.processImage(inputImage);

    if (faces.isEmpty) {
      _showDialog("No face detected!");
      return;
    }

    final screenSize = MediaQuery.of(context).size;
    final isInside = _isFaceInsideCircle(faces.first, screenSize);

    _showDialog(
      isInside ? "Face is inside the guide!" : "Face is outside the guide!",
    );
  }

  bool _isFaceInsideCircle(Face face, Size screenSize) {
    final circleCenter = Offset(screenSize.width / 2, screenSize.height / 2);
    final circleRadius = 350 / 2; // same as FaceGuidePainter width / 2

    final faceCenter = Offset(
      (face.boundingBox.left + face.boundingBox.right) / 2,
      (face.boundingBox.top + face.boundingBox.bottom) / 2,
    );

    final distance = (faceCenter - circleCenter).distance;
    return distance <= circleRadius;
  }

  void _switchCamera() {
    _cameraIndex = (_cameraIndex + 1) % CameraToFaceRecognized.cameras.length;
    _cameraController.dispose();
    _initCamera();
    setState(() {});
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _cameraController.dispose();
    _faceDetector.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: _initializeCameraFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController);
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),

          /// 🔥 FACE GUIDE OVERLAY
          Center(
            child: CustomPaint(
              size: Size(
                MediaQuery.of(context).size.width,
                MediaQuery.of(context).size.height,
              ),
              painter: FaceGuidePainter(),
            ),
          ),

          Positioned(
            top: 50.h,
            left: 16.w,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          Positioned(
            bottom: 40.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _iconButton(Icons.cameraswitch, _switchCamera),
                _captureButton(_takePicture),
                _iconButton(Icons.photo_library, _pickImageFromGallery),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: CircleAvatar(
        radius: 22.r,
        backgroundColor: Colors.black.withOpacity(0.45),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }

  Widget _captureButton(VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 70.w,
        height: 70.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: Center(
          child: Container(
            width: 50.w,
            height: 50.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class FaceGuidePainter extends CustomPainter {
  final bool isFaceInside; // true if face is inside the guide

  FaceGuidePainter({this.isFaceInside = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    // Full screen overlay
    final overlayPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // Oval (matches _isFaceInsideCircle logic)
    final ovalWidth = 350.0;
    final ovalHeight = 450.0;
    final ovalRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: ovalWidth,
      height: ovalHeight,
    );

    // Make the oval transparent
    final transparentPath = Path()..addOval(ovalRect);
    final finalPath = Path.combine(
      PathOperation.difference,
      overlayPath,
      transparentPath,
    );
    canvas.drawPath(finalPath, paint);

    // White (or green if face inside) border
    canvas.drawOval(
      ovalRect,
      Paint()
        ..color = isFaceInside ? Colors.green : Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3,
    );
  }

  @override
  bool shouldRepaint(covariant FaceGuidePainter oldDelegate) {
    // repaint only if the inside state changed
    return oldDelegate.isFaceInside != isFaceInside;
  }
}
