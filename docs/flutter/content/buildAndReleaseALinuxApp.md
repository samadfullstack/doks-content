1.  [Deployment](https://docs.flutter.dev/deployment)
2.  [Linux](https://docs.flutter.dev/deployment/linux)

During a typical development cycle, you test an app using `flutter run` at the command line, or by using the **Run** and **Debug** options in your IDE. By default, Flutter builds a _debug_ version of your app.

When you’re ready to prepare a _release_ version of your app, for example to [publish to the Snap Store](https://snapcraft.io/store), this page can help.

## Prerequisites

To build and publish to the Snap Store, you need the following components:

-   [Ubuntu](https://ubuntu.com/download/desktop) OS, 18.04 LTS (or higher)
-   [Snapcraft](https://snapcraft.io/snapcraft) command line tool
-   [LXD container manager](https://linuxcontainers.org/lxd/downloads/)

## Set up the build environment

Use the following instructions to set up your build environment.

### Install snapcraft

At the command line, run the following:

```
<span>$</span><span> </span><span>sudo </span>snap <span>install </span>snapcraft <span>--classic</span>
```

### Install LXD

To install LXD, use the following command:

LXD is required during the snap build process. Once installed, LXD needs to be configured for use. The default answers are suitable for most use cases.

```
<span>$</span><span> </span><span>sudo </span>lxd init
<span>Would you like to use LXD clustering? (yes/no) [default=no]:
Do you want to configure a new storage pool? (yes/no) [default=yes]:
Name of the new storage pool [default=default]:
Name of the storage backend to use (btrfs, dir, lvm, zfs, ceph) [default=zfs]:
Create a new ZFS pool? (yes/no) [default=yes]:
Would you like to use an existing empty disk or partition? (yes/no) [default=no]:
Size in GB of the new loop device (1GB minimum) [default=5GB]:
Would you like to connect to a MAAS server? (yes/no) [default=no]:
Would you like to create a new local network bridge? (yes/no) [default=yes]:
What should the new bridge be called? [default=lxdbr0]:
What IPv4 address should be used? (CIDR subnet notation, "auto" or "none") [default=auto]:
What IPv6 address should be used? (CIDR subnet notation, "auto" or "none") [default=auto]:
Would you like LXD to be available over the network? (yes/no) [default=no]:
Would you like stale cached images to be updated automatically? (yes/no) [default=yes]
Would you like a YAML "lxd init" preseed to be printed? (yes/no) [default=no]:
</span>
```

On the first run, LXD might not be able to connect to its socket:

```
<span>An error occurred when trying to communicate with the 'LXD'
provider: cannot connect to the LXD socket
('/var/snap/lxd/common/lxd/unix.socket').
</span>
```

This means you need to add your user name to the LXD (lxd) group, so log out of your session and then log back in:

```
<span>$</span><span> </span><span>sudo </span>usermod <span>-a</span> <span>-G</span> lxd &lt;your username&gt;
```

## Overview of snapcraft

The `snapcraft` tool builds snaps based on the instructions listed in a `snapcraft.yaml` file. To get a basic understanding of snapcraft and its core concepts, take a look at the [Snap documentation](https://snapcraft.io/docs) and the [Introduction to snapcraft](https://snapcraft.io/blog/introduction-to-snapcraft). Additional links and information are listed at the bottom of this page.

## Flutter snapcraft.yaml example

Place the YAML file in your Flutter project under `<project root>/snap/snapcraft.yaml`. (And remember that YAML files are sensitive to white space!) For example:

```
<span>name</span><span>:</span> <span>super-cool-app</span>
<span>version</span><span>:</span> <span>0.1.0</span>
<span>summary</span><span>:</span> <span>Super Cool App</span>
<span>description</span><span>:</span> <span>Super Cool App that does everything!</span>

<span>confinement</span><span>:</span> <span>strict</span>
<span>base</span><span>:</span> <span>core22</span>
<span>grade</span><span>:</span> <span>stable</span>

<span>slots</span><span>:</span>
  <span>dbus-super-cool-app</span><span>:</span> <span># adjust accordingly to your app name</span>
    <span>interface</span><span>:</span> <span>dbus</span>
    <span>bus</span><span>:</span> <span>session</span>
    <span>name</span><span>:</span> <span>org.bar.super_cool_app</span> <span># adjust accordingly to your app name and</span>
    
<span>apps</span><span>:</span>
  <span>super-cool-app</span><span>:</span>
    <span>command</span><span>:</span> <span>super_cool_app</span>
    <span>extensions</span><span>:</span> <span>[</span><span>gnome</span><span>]</span> <span># gnome includes the libraries required by flutter</span>
    <span>plugs</span><span>:</span>
    <span>-</span> <span>network</span>
    <span>slots</span><span>:</span>
      <span>-</span> <span>dbus-super-cool-app</span>
<span>parts</span><span>:</span>
  <span>super-cool-app</span><span>:</span>
    <span>source</span><span>:</span> <span>.</span>
    <span>plugin</span><span>:</span> <span>flutter</span>
    <span>flutter-target</span><span>:</span> <span>lib/main.dart</span> <span># The main entry-point file of the application</span>
```

The following sections explain the various pieces of the YAML file.

### Metadata

This section of the `snapcraft.yaml` file defines and describes the application. The snap version is derived (adopted) from the build section.

```
<span>name</span><span>:</span> <span>super-cool-app</span>
<span>version</span><span>:</span> <span>0.1.0</span>
<span>summary</span><span>:</span> <span>Super Cool App</span>
<span>description</span><span>:</span> <span>Super Cool App that does everything!</span>
```

### Grade, confinement, and base

This section defines how the snap is built.

```
<span>confinement</span><span>:</span> <span>strict</span>
<span>base</span><span>:</span> <span>core18</span>
<span>grade</span><span>:</span> <span>stable</span>
```

**Grade**

Specifies the quality of the snap; this is relevant for the publication step later.

**Confinement**

Specifies what level of system resource access the snap will have once installed on the end-user system. Strict confinement limits the application access to specific resources (defined by plugs in the `app` section).

**Base**

Snaps are designed to be self-contained applications, and therefore, they require their own private core root filesystem known as `base`. The `base` keyword specifies the version used to provide the minimal set of common libraries, and mounted as the root filesystem for the application at runtime.

### Apps

This section defines the application(s) that exist inside the snap. There can be one or more applications per snap. This example has a single application—super\_cool\_app.

```
<span>apps</span><span>:</span>
  <span>super-cool-app</span><span>:</span>
    <span>command</span><span>:</span> <span>super_cool_app</span>
    <span>extensions</span><span>:</span> <span>[</span><span>gnome</span><span>]</span>
```

**Command**

Points to the binary, relative to the snap’s root, and runs when the snap is invoked.

**Extensions**

A list of one or more extensions. Snapcraft extensions are reusable components that can expose sets of libraries and tools to a snap at build and runtime, without the developer needing to have specific knowledge of included frameworks. The `gnome` extension exposes the GTK 3 libraries to the Flutter snap. This ensures a smaller footprint and better integration with the system.

**Plugs**

A list of one or more plugs for system interfaces. These are required to provide necessary functionality when snaps are strictly confined. This Flutter snap needs access to the network.

**DBus interface**

The [DBus interface](https://snapcraft.io/docs/dbus-interface) provides a way for snaps to communicate over DBus. The snap providing the DBus service declares a slot with the well-known DBus name and which bus it uses. Snaps wanting to communicate with the providing snap’s service declare a plug for the providing snap. Note that a snap declaration is needed for your snap to be delivered via the snap store and claim this well-known DBus name (simply upload the snap to the store and request a manual review and a reviewer will take a look).

When a providing snap is installed, snapd will generate security policy that will allow it to listen on the well-known DBus name on the specified bus. If the system bus is specified, snapd will also generate DBus bus policy that allows ‘root’ to own the name and any user to communicate with the service. Non-snap processes are allowed to communicate with the providing snap following traditional permissions checks. Other (consuming) snaps might only communicate with the providing snap by connecting the snaps’ interface.

```
dbus-super-cool-app: # adjust accordingly to your app name
  interface: dbus
  bus: session
  name: dev.site.super_cool_app 
```

### Parts

This section defines the sources required to assemble the snap.

Parts can be downloaded and built automatically using plugins. Similar to extensions, snapcraft can use various plugins (like Python, C, Java, Ruby, etc) to assist in the building process. Snapcraft also has some special plugins.

**nil** plugin

Performs no action and the actual build process is handled using a manual override.

**flutter** plugin

Provides the necessary Flutter SDK tools so you can use it without having to manually download and set up the build tools.

```
<span>parts</span><span>:</span>
  <span>super-cool-app</span><span>:</span>
    <span>source</span><span>:</span> <span>.</span>
    <span>plugin</span><span>:</span> <span>flutter</span>
    <span>flutter-target</span><span>:</span> <span>lib/main.dart</span> <span># The main entry-point file of the application</span>
```

## Desktop file and icon

Desktop entry files are used to add an application to the desktop menu. These files specify the name and icon of your application, the categories it belongs to, related search keywords and more. These files have the extension .desktop and follow the XDG Desktop Entry Specification version 1.1.

### Flutter super-cool-app.desktop example

Place the .desktop file in your Flutter project under `<project root>/snap/gui/super-cool-app.desktop`.

**Notice**: icon and .desktop file name must be the same as your app name in yaml file!

For example:

```desktop
[Desktop Entry] Name=Super Cool App Comment=Super Cool App that does everything Exec=super-cool-app Icon=${SNAP}/meta/gui/super-cool-app.png # replace name to your app name Terminal=false Type=Application Categories=Education; #adjust accordingly your snap category
```

Place your icon with .png extension in your Flutter project under `<project root>/snap/gui/super-cool-app.png`.

## Build the snap

Once the `snapcraft.yaml` file is complete, run `snapcraft` as follows from the root directory of the project.

To use the Multipass VM backend:

To use the LXD container backend:

## Test the snap

Once the snap is built, you’ll have a `<name>.snap` file in your root project directory.

$ sudo snap install ./super-cool-app\_0.1.0\_amd64.snap –dangerous

## Publish

You can now publish the snap. The process consists of the following:

1.  Create a developer account at [snapcraft.io](https://snapcraft.io/), if you haven’t already done so.
2.  Register the app’s name. Registration can be done either using the Snap Store Web UI portal, or from the command line, as follows:
    
    ```
    <span>$</span><span> </span>snapcraft login
    <span>$</span><span> </span>snapcraft register
    ```
    
3.  Release the app. After reading the next section to learn about selecting a Snap Store channel, push the snap to the store:
    
    ```
    <span>$</span><span> </span>snapcraft upload <span>--release</span><span>=</span>&lt;channel&gt; &lt;file&gt;.snap
    ```
    

### Snap Store channels

The Snap Store uses channels to differentiate among different versions of snaps.

The `snapcraft upload` command uploads the snap file to the store. However, before you run this command, you need to learn about the different release channels. Each channel consists of three components:

**Track**

All snaps must have a default track called latest. This is the implied track unless specified otherwise.

**Risk**

Defines the readiness of the application. The risk levels used in the snap store are: `stable`, `candidate`, `beta`, and `edge`.

**Branch**

Allows creation of short-lived snap sequences to test bug-fixes.

### Snap Store automatic review

The Snap Store runs several automated checks against your snap. There might also be a manual review, depending on how the snap was built, and if there are any specific security concerns. If the checks pass without errors, the snap becomes available in the store.

## Additional resources

You can learn more from the following links on the [snapcraft.io](https://snapcraft.io/) site:

-   [Channels](https://docs.snapcraft.io/channels)
-   [Environment variables](https://snapcraft.io/docs/environment-variables)
-   [Interface management](https://snapcraft.io/docs/interface-management)
-   [Parts environment variables](https://snapcraft.io/docs/parts-environment-variables)
-   [Releasing to the Snap Store](https://snapcraft.io/docs/releasing-to-the-snap-store)
-   [Snapcraft extensions](https://snapcraft.io/docs/snapcraft-extensions)
-   [Supported plugins](https://snapcraft.io/docs/supported-plugins)