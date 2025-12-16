plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.baca_meter"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.baca_meter"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
//        release {
//            // TODO: Add your own signing config for the release build.
//            // Signing with the debug keys for now, so `flutter run --release` works.
//            signingConfig = signingConfigs.getByName("debug")
//        }
        getByName("debug") {
            signingConfig = signingConfigs.getByName("debug")

            isMinifyEnabled = false
            isShrinkResources = false
            isDebuggable = true
            isJniDebuggable = true
            isRenderscriptDebuggable = true
            isPseudoLocalesEnabled = true
        }

        getByName("release") {
            // sementara masih pakai debug keystore (boleh)
            signingConfig = signingConfigs.getByName("debug")

            isMinifyEnabled = true
            isShrinkResources = true

            isDebuggable = false
            isJniDebuggable = false
            isRenderscriptDebuggable = false
            isPseudoLocalesEnabled = false
            isZipAlignEnabled = true

            proguardFiles(
                getDefaultProguardFile("proguard-android.txt"),
                "proguard-rules.pro"
            )
        }
    }


    // ⬇️ TAMBAHKAN INI
    flavorDimensions += "environment"

    productFlavors {
        create("development") {
            dimension = "environment"
            applicationIdSuffix = ".dev"
            resValue("string", "app_name", "PDAM Bacameter Dev")
        }

        create("production") {
            dimension = "environment"
            resValue("string", "app_name", "PDAM Bacameter")
        }
    }
}

flutter {
    source = "../.."
}
