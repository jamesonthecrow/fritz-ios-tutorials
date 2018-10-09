import UIKit
import AVFoundation
import Fritz

class ViewController: UIViewController {

    var cameraView: UIImageView!

    private lazy var cameraSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "com.fritzdemo.imagesegmentation.session")
    private let captureQueue = DispatchQueue(label: "com.fritzdemo.imagesegmentation.capture", qos: DispatchQoS.userInitiated)

    override func viewDidLoad() {
        super.viewDidLoad()

        cameraView = UIImageView(frame: view.bounds)
        cameraView.contentMode = .scaleAspectFill
        view.addSubview(cameraView)

        // Setup camera
        guard let device = AVCaptureDevice.default(for: .video), let input = try? AVCaptureDeviceInput(device: device) else { return }

        let output = AVCaptureVideoDataOutput()

        // Configure pixelBuffer format for use in model
        output.videoSettings = [kCVPixelBufferPixelFormatTypeKey as String: kCVPixelFormatType_32BGRA as UInt32]
        output.alwaysDiscardsLateVideoFrames = true
        output.setSampleBufferDelegate(self, queue: captureQueue)

        sessionQueue.async {
            self.cameraSession.beginConfiguration()
            self.cameraSession.addInput(input)
            self.cameraSession.addOutput(output)
            self.cameraSession.commitConfiguration()

            // Change orientation so all images are properly oriented for portrait orientation.
            output.connection(with: .video)?.videoOrientation = .portrait
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        sessionQueue.async {
            self.cameraSession.startRunning()
        }
    }
}

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {

        DispatchQueue.main.async {
            guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }

            // By importing Fritz, you are able to access a helper extension on UIImage that makes it
            // easy to create a UIImage from a CVPixelBuffer.
            self.cameraView.image = UIImage(pixelBuffer: imageBuffer)
        }
    }
}
