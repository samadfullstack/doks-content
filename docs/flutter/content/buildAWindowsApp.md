1.  [Platform integration](https://docs.flutter.dev/platform-integration)
2.  [Windows](https://docs.flutter.dev/platform-integration/windows)
3.  [Windows development](https://docs.flutter.dev/platform-integration/windows/building)

This page discusses considerations unique to building Windows apps with Flutter, including shell integration and distribution of Windows apps through the Microsoft Store on Windows.

## Integrating with Windows

The Windows programming interface combines traditional Win32 APIs, COM interfaces and more modern Windows Runtime libraries. As all these provide a C-based ABI, you can call into the services provided by the operating system using Dart’s Foreign Function Interface library (`dart:ffi`). FFI is designed to enable Dart programs to efficiently call into C libraries. It provides Flutter apps with the ability to allocate native memory with `malloc` or `calloc`, support for pointers, structs and callbacks, and ABI types like `long` and `size_t`.

For more information about calling C libraries from Flutter, see [C interop using `dart:ffi`](https://dart.dev/guides/libraries/c-interop).

In practice, while it is relatively straightforward to call basic Win32 APIs from Dart in this way, it is easier to use a wrapper library that abstracts the intricacies of the COM programming model. The [win32 package](https://pub.dev/packages/win32) provides a library for accessing thousands of common Windows APIs, using metadata provided by Microsoft for consistency and correctness. The package also includes examples of a variety of common use cases, such as WMI, disk management, shell integration, and system dialogs.

A number of other packages build on this foundation, providing idiomatic Dart access for the [Windows registry](https://pub.dev/packages/win32_registry), [gamepad support](https://pub.dev/packages/win32_gamepad), [biometric storage](https://pub.dev/packages/biometric_storage), [taskbar integration](https://pub.dev//packages/windows_taskbar), and [serial port access](https://pub.dev/packages/serial_port_win32), to name a few.

More generally, many other [packages support Windows](https://pub.dev/packages?q=platform%3Awindows), including common packages such as [`url_launcher`](https://pub.dev/packages/url_launcher), [`shared_preferences`](https://pub.dev/packages/shared_preferences), [`file_selector`](https://pub.dev/packages/file_selector), and [`path_provider`](https://pub.dev/packages/path_provider).

## Supporting Windows UI guidelines

While you can use any visual style or theme you choose, including Material, some app authors might wish to build an app that matches the conventions of Microsoft’s [Fluent design system](https://docs.microsoft.com/en-us/windows/apps/design/). The [fluent\_ui](https://pub.dev/packages/fluent_ui) package, a [Flutter Favorite](https://docs.flutter.dev/packages-and-plugins/favorites), provides support for visuals and common controls that are commonly found in modern Windows apps, including navigation views, content dialogs, flyouts, date pickers, and tree view widgets.

In addition, Microsoft offers [fluentui\_system\_icons](https://pub.dev/packages/fluentui_system_icons), a package that provides easy access to thousands of Fluent icons for use in your Flutter app.

Lastly, the [bitsdojo\_window](https://pub.dev/packages/bitsdojo_window) package provides support for “owner draw” title bars, allowing you to replace the standard Windows title bar with a custom one that matches the rest of your app.

## Customizing the Windows host application

When you create a Windows app, Flutter generates a small C++ application that hosts Flutter. This “runner app” is responsible for creating and sizing a traditional Win32 window, initializing the Flutter engine and any native plugins, and running the Windows message loop (passing relevant messages on to Flutter for further processing).

You can, of course, make changes to this code to suit your needs, including modifying the app name and icon, and setting the window’s initial size and location. The relevant code is in main.cpp, where you will find code similar to the following:

```
<span>Win32Window</span><span>::</span><span>Point</span> <span>origin</span><span>(</span><span>10</span><span>,</span> <span>10</span><span>);</span>
<span>Win32Window</span><span>::</span><span>Size</span> <span>size</span><span>(</span><span>1280</span><span>,</span> <span>720</span><span>);</span>
<span>if</span> <span>(</span><span>!</span><span>window</span><span>.</span><span>CreateAndShow</span><span>(</span><span>L"myapp"</span><span>,</span> <span>origin</span><span>,</span> <span>size</span><span>))</span>
<span>{</span>
    <span>return</span> <span>EXIT_FAILURE</span><span>;</span>
<span>}</span>
```

Replace `myapp` with the title you would like displayed in the Windows caption bar, as well as optionally adjusting the dimensions for size and the window coordinates.

To change the Windows application icon, replace the `app_icon.ico` file in the `windows\runner\resources` directory with an icon of your preference.

The generated Windows executable filename can be changed by editing the `BINARY_NAME` variable in `windows/CMakeLists.txt`:

```
<span>cmake_minimum_required</span><span>(</span>VERSION 3.14<span>)</span>
<span>project</span><span>(</span>windows_desktop_app LANGUAGES CXX<span>)</span>

<span># The name of the executable created for the application.</span>
<span># Change this to change the on-disk name of your application.</span>
<span>set</span><span>(</span>BINARY_NAME <span>"YourNewApp"</span><span>)</span>

<span>cmake_policy</span><span>(</span>SET CMP0063 NEW<span>)</span>
```

When you run `flutter build windows`, the executable file generated in the `build\windows\runner\Release` directory will match the newly given name.

Finally, further properties for the app executable itself can be found in the `Runner.rc` file in the `windows\runner` directory. Here you can change the copyright information and application version that is embedded in the Windows app, which is displayed in the Windows Explorer properties dialog box. To change the version number, edit the `VERSION_AS_NUMBER` and `VERSION_AS_STRING` properties; other information can be edited in the `StringFileInfo` block.

## Compiling with Visual Studio

For most apps, it’s sufficient to allow Flutter to handle the compilation process using the `flutter run` and `flutter build` commands. If you are making significant changes to the runner app or integrating Flutter into an existing app, you might want to load or compile the Flutter app in Visual Studio itself.

Follow these steps:

1.  Run `flutter build windows` to create the `build\` directory.
    
2.  Open the Visual Studio solution file for the Windows runner, which can now be found in the `build\windows` directory, named according to the parent Flutter app.
    
3.  In Solution Explorer, you will see a number of projects. Right-click the one that has the same name as the Flutter app, and choose **Set as Startup Project**.
    
4.  To generate the necessary dependencies, run **Build** > **Build Solution**
    
    You can also press/ Ctrl + Shift + B.
    
    To run the Windows app from Visual Studio, go to **Debug** > **Start Debugging**.
    
    You can also press F5.
    
5.  Use the toolbar to switch between Debug and Release configurations as appropriate.
    

## Distributing Windows apps

There are various approaches you can use for distributing your Windows application. Here are some options:

-   Use tooling to construct an MSIX installer (described in the next section) for your application and distribute it through the Microsoft Windows App Store. You don’t need to manually create a signing certificate for this option as it is handled for you.
-   Construct an MSIX installer and distribute it through your own website. For this option, you need to to give your application a digital signature in the form of a `.pfx` certificate.
-   Collect all of the necessary pieces and build your own zip file.

### MSIX packaging

[MSIX](https://docs.microsoft.com/en-us/windows/msix/overview), the new Windows application package format, provides a modern packaging format and installer. This format can either be used to ship applications to the Microsoft Store on Windows, or you can distribute app installers directly.

The easiest way to create an MSIX distribution for a Flutter project is to use the [`msix` pub package](https://pub.dev/packages/msix). For an example of using the `msix` package from a Flutter desktop app, see the [Desktop Photo Search](https://github.com/flutter/samples/tree/main/desktop_photo_search) sample.

#### Create a self-signed .pfx certificate for local testing

For private deployment and testing with the help of the MSIX installer, you need to give your application a digital signature in the form of a `.pfx` certificate.

For deployment through the Windows Store, generating a `.pfx` certificate is not required. The Windows Store handles creation and management of certificates for applications distributed through its store.

Distributing your application by self hosting it on a website requires a certificate signed by a Certificate Authority known to Windows.

Use the following instructions to generate a self-signed `.pfx` certificate.

1.  If you haven’t already, download the [OpenSSL](https://slproweb.com/products/Win32OpenSSL.html) toolkit to generate your certificates.
2.  Go to where you installed OpenSSL, for example, `C:\Program Files\OpenSSL-Win64\bin`.
3.  Set an environment variable so that you can access `OpenSSL` from anywhere:  
    `"C:\Program Files\OpenSSL-Win64\bin"`
4.  Generate a private key as follows:  
    `openssl genrsa -out mykeyname.key 2048`
5.  Generate a certificate signing request (CSR) file using the private key:  
    `openssl req -new -key mykeyname.key -out mycsrname.csr`
6.  Generate the signed certificate (CRT) file using the private key and CSR file:  
    `openssl x509 -in mycsrname.csr -out mycrtname.crt -req -signkey mykeyname.key -days 10000`
7.  Generate the `.pfx` file using the private key and CRT file:  
    `openssl pkcs12 -export -out CERTIFICATE.pfx -inkey mykeyname.key -in mycrtname.crt`
8.  Install the `.pfx` certificate first on the local machine in `Certificate store` as `Trusted Root Certification Authorities` before installing the app.

### Building your own zip file for Windows

The Flutter executable, `.exe`, can be found in your project under `build\windows\runner\<build mode>\`. In addition to that executable, you need the following:

-   From the same directory:
    -   all the `.dll` files
    -   the `data` directory
-   The Visual C++ redistributables. You can use any of the methods shown in the [deployment example walkthroughs](https://docs.microsoft.com/en-us/cpp/windows/deployment-examples) on the Microsoft site to ensure that end users have the C++ redistributables. If you use the `application-local` option, you need to copy:
    
    -   `msvcp140.dll`
    -   `vcruntime140.dll`
    -   `vcruntime140_1.dll`
    
    Place the DLL files in the directory next to the executable and the other DLLs, and bundle them together in a zip file. The resulting structure looks something like this:
    
    ```
    Release
    │   flutter_windows.dll
    │   msvcp140.dll
    │   my_app.exe
    │   vcruntime140.dll
    │   vcruntime140_1.dll
    │
    └───data
    │   │   app.so
    │   │   icudtl.dat
    
    ...
    ```
    

At this point if desired it would be relatively simple to add this folder to a Windows installer such as Inno Setup, WiX, etc.