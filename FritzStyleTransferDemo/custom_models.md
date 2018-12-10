Custom Style Models

### Instructions for using custom style models with Fritz.

1. Drag your `.mlmodel` file into the XCode project. We suggest keeping everything organized with a `Models` folder.

2. Conform your model to a Fritz Protocol with an extension. See the `Models/Models+Fritz.swift` file for details.

    E.g.:
    ```
    extension customStyleModel1280x720: SwiftIdentifiedModel {
        static let modelIdentifier = "abc-123"
        static let packagedModelVersion = 1
    }
    ```

    To enable model analytics and release management, upload the same `.mlmodel` to your app in [Fritz](https://app.fritz.ai) and change the `modelIdentifier` above.

3. Create a new `FritzVisionStyleModel` with a custom model:

    ```
    lazy var styleModel = FritzVisionStyleModel(model: customStyleModel1280x720().fritz())
    ```

    Note the `.fritz()` call after the model is instantiated.

### Changing camera resolution

To change the resolution of the video input and output, you can choose a different `AVCaptureSession` preset. If your model expects 720p (1280x720) resolution, update the following line:
```
session.sessionPreset = AVCaptureSession.Preset.vga640x480
```
to
```
session.sessionPreset = AVCaptureSession.Preset.hd1280x720
```
