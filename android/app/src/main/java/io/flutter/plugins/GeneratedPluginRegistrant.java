package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.connectivity.ConnectivityPlugin;
import com.befovy.fijkplayer.FijkPlugin;
import com.example.flutterimagecompress.FlutterImageCompressPlugin;
import io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin;
import com.fuyumi.flutterstatusbarcolor.flutterstatusbarcolor.FlutterStatusbarcolorPlugin;
import top.kikt.flutter_image_editor.FlutterImageEditorPlugin;
import io.flutter.plugins.imagepicker.ImagePickerPlugin;
import com.vitanov.multiimagepicker.MultiImagePickerPlugin;
import com.github.sososdk.orientation.OrientationPlugin;
import sk.fourq.otaupdate.OtaUpdatePlugin;
import io.flutter.plugins.packageinfo.PackageInfoPlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    ConnectivityPlugin.registerWith(registry.registrarFor("io.flutter.plugins.connectivity.ConnectivityPlugin"));
    FijkPlugin.registerWith(registry.registrarFor("com.befovy.fijkplayer.FijkPlugin"));
    FlutterImageCompressPlugin.registerWith(registry.registrarFor("com.example.flutterimagecompress.FlutterImageCompressPlugin"));
    FlutterAndroidLifecyclePlugin.registerWith(registry.registrarFor("io.flutter.plugins.flutter_plugin_android_lifecycle.FlutterAndroidLifecyclePlugin"));
    FlutterStatusbarcolorPlugin.registerWith(registry.registrarFor("com.fuyumi.flutterstatusbarcolor.flutterstatusbarcolor.FlutterStatusbarcolorPlugin"));
    FlutterImageEditorPlugin.registerWith(registry.registrarFor("top.kikt.flutter_image_editor.FlutterImageEditorPlugin"));
    ImagePickerPlugin.registerWith(registry.registrarFor("io.flutter.plugins.imagepicker.ImagePickerPlugin"));
    MultiImagePickerPlugin.registerWith(registry.registrarFor("com.vitanov.multiimagepicker.MultiImagePickerPlugin"));
    OrientationPlugin.registerWith(registry.registrarFor("com.github.sososdk.orientation.OrientationPlugin"));
    OtaUpdatePlugin.registerWith(registry.registrarFor("sk.fourq.otaupdate.OtaUpdatePlugin"));
    PackageInfoPlugin.registerWith(registry.registrarFor("io.flutter.plugins.packageinfo.PackageInfoPlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
