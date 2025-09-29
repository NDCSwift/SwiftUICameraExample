import SwiftUI
import CoreLocation
import CoreMotion

struct ContentView: View {
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @StateObject private var locationManager = LocationManager()
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Display the captured image
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                }
                
                // Camera Button
                Button("Open Camera") {
                    showImagePicker = true
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $selectedImage)
                }
                
                // Display Location
                if let location = locationManager.userLocation {
                    Text("Latitude: \(location.latitude), Longitude: \(location.longitude)")
                        .padding()
                } else {
                    Text("Fetching location...")
                }
                
                // Display Motion Data
                VStack {
                    Text("X: \(motionManager.acceleration.x)")
                    Text("Y: \(motionManager.acceleration.y)")
                    Text("Z: \(motionManager.acceleration.z)")
                }
                .padding()

            }
            .navigationTitle("Device Features")
            .padding()
        }
    }
}

// UIImagePickerController setup for camera
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            parent.image = info[.originalImage] as? UIImage
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    @Published var userLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        userLocation = location.coordinate
    }
}

// Motion Manager
class MotionManager: ObservableObject {
    private let manager = CMMotionManager()
    @Published var acceleration: CMAcceleration = .init()

    init() {
        manager.startAccelerometerUpdates(to: .main) { data, error in
            if let data = data {
                self.acceleration = data.acceleration
            }
        }
    }
}

#Preview {
    ContentView()
}
