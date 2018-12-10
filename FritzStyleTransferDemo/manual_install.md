Instructions for using Fritz SDK Frameworks not using Cocoapods

### Variant 1: Clone swift-framework repo, link to that location

1. Clone the swift-framework repo, this will download all Fritz SDK Frameworks.

   ```
   git clone git@github.com:fritzlabs/swift-framework.git
   ```

2. Add the path to `swift-framework/Frameworks` folder in Build Settings -> Framework Search Paths

3. Under General -> Linked Frameworks and Libraries add necessary frameworks from `swift-framework/Frameworks`.

   For Style transfer, you will need the following frameworks:
   ```
   Fritz.framework
   FritzCore.framework
   FritzManagedModel.framework
   FritzVision.framework
   FritzVisionStyleModel.framework
   FritzVisionStyleModelBase.framework
   FritzVisionStyleModelPaintings.framework
   CoreMLHelpers.framework
   ```

4. Add these frameworks to Embedded binaries.

   Adding the frameworks to Embedded Binaries will copy the frameworks during build.
   When you add these frameworks, Xcode will duplicate the framewors in Linked Frameworks and Libraries. You can remove the duplicates.

5. Build your app! Now the demo app should build properly.

   Note that the frameworks are "fat" libraries and include builds for different architectures. When submitting the app to the App Store, you will most likely get a warning `"Too many symbol files" when submitting to App Store.`.  I believe to resolve this, you can add a script found under the  "One More Thing" section from this https://instabug.com/blog/ios-binary-framework/ article.  This will strip down the framework to only copy the appropriate architecture on app build. Cocoapods does this automatically.
