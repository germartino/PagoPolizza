import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:PagoPolizza/main.dart';
import 'detail_screen.dart';
import 'package:ionicons/ionicons.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late final CameraController _controller;

  // Initializes camera controller to preview on screen
  void _initializeCamera() async {
    final CameraController cameraController = CameraController(
      cameras[0],
      ResolutionPreset.high,
    );
    _controller = cameraController;

    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  // Takes picture with the selected device camera, and
  // returns the image path
  Future<String?> _takePicture() async {
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    String? imagePath;

    if (_controller.value.isTakingPicture) {
      print("Processing is progress ...");
      return null;
    }

    try {
      // Turning off the camera flash
      _controller.setFlashMode(FlashMode.off);
      // Returns the image in cross-platform file abstraction
      final XFile file = await _controller.takePicture();
      // Retrieving the path
      imagePath = file.path;
    } on CameraException catch (e) {
      print("Camera Exception: $e");
      return null;
    }

    return imagePath;
  }

  @override
  void initState() {
    _initializeCamera();
    super.initState();
  }

  @override
  void dispose() {
    // dispose the camera controller when navigated
    // to a different page
    _controller.dispose();
    super.dispose();
  }

/*  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OCR Text Recognition'),
      ),
      body: _controller.value.isInitialized
          ? Stack(
        children: <Widget>[
          CameraPreview(_controller),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton.icon(
                icon: Icon(Icons.camera),
                label: Text("Click"),
                onPressed: () async {
                  // If the returned path is not null navigate
                  // to the DetailScreen
                  await _takePicture().then((String? path) {
                    if (path != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(
                            imagePath: path,
                          ),
                        ),
                      );
                    } else {
                      print('Image path not found!');
                    }
                  });
                },
              ),
            ),
          )
        ],
      )
          : Container(
        color: Colors.black,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: null,
        appBar: null,
        body: _controller.value.isInitialized
            ? Stack(
                children: <Widget>[
                  CameraPreview(_controller),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                                MediaQuery.of(context).size.width * 0.25,
                                MediaQuery.of(context).size.height * 0.06),
                            alignment: Alignment.center,
                            primary: const Color(0xffdf752c),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23))),
                        icon: const Icon(Icons.camera),
                        label: const Text("Camera"),
                        onPressed: () async {
                          // If the returned path is not null navigate
                          // to the DetailScreen
                          await _takePicture().then((String? path) {
                            if (path != null) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    imagePath: path,
                                  ),
                                ),
                              );
                            } else {
                              print('Image path not found!');
                            }
                          });
                        },
                      ),
                    ),
                  )
                ],
              )
            : SafeArea(
                child: Column(children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.08,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(26.0),
                    ),
                    color: Color(0xffdf752c),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.002,
                            left: MediaQuery.of(context).size.width * 0.05,
                            right: MediaQuery.of(context).size.width * 0.07,
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(Ionicons.chevron_back_outline,
                                  color: Color(0xffffffff), size: 25)),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              scale: 5,
                              alignment: Alignment.centerLeft,
                              image:
                                  AssetImage('assets/pagopolizza_bianco.png'),
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ])));
  }
}
