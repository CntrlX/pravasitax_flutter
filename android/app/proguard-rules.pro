# Add these rules at the top
-dontwarn javax.naming.**
-dontwarn org.ietf.jgss.**
-dontwarn org.apache.http.**
-dontwarn android.net.http.AndroidHttpClient
-dontwarn com.google.android.gms.**
-dontwarn com.google.api.client.http.**
-dontwarn javax.lang.model.**
-dontwarn javax.lang.model.element.**
-dontwarn javax.annotation.**
-dontwarn org.joda.convert.**
-dontwarn org.joda.time.**
-dontwarn com.google.auto.**
-dontwarn com.google.common.**
-dontwarn autovalue.shaded.**

# Keep javax.lang.model
-keep class javax.lang.model.** { *; }
-keep class javax.lang.model.element.** { *; }
-keep class javax.lang.model.type.** { *; }
-keep class javax.lang.model.util.** { *; }

# Keep Joda Time and Convert
-keep class org.joda.time.** { *; }
-keep class org.joda.convert.** { *; }

# Keep existing rules...
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Secure Storage
-keep class com.google.crypto.tink.** { *; }
-keep class javax.annotation.** { *; }
-keep class com.google.errorprone.** { *; }

# OkHttp
-keepattributes Signature
-keepattributes *Annotation*
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**

# Keep R8 rules
-keepattributes *Annotation*
-keepattributes Signature
-keepattributes SourceFile,LineNumberTable
-keep public class * extends java.lang.Exception

# Multidex
-keep class androidx.multidex.** { *; }

# Keep Annotations
-keep class * extends java.lang.annotation.Annotation { *; }
-keep interface * extends java.lang.annotation.Annotation { *; }

# Keep shaded classes
-keep class autovalue.shaded.** { *; }
-keep class com.google.common.** { *; }