using System;
using System.IO;
using Qml.Net;

namespace audio_player
{
    class Program
    {
        private static QGuiApplication app;
        private static QQmlApplicationEngine qmlEngine;
        private static string qmlFilesPath;

        private static bool Init(ref string[] args)
        {
            qmlFilesPath = Path.Combine(Directory.GetCurrentDirectory(), "qml");
            if (qmlFilesPath.Length > 0) {
                app = new QGuiApplication(args);
                qmlEngine = new QQmlApplicationEngine();
                Qml.Net.Qml.RegisterType<Models.AudioModel>("AudioModel", 0, 1);
                Qml.Net.Qml.RegisterType<Models.ListAudioModels>("ListAudioModels", 0, 1);
                Qml.Net.Qml.RegisterType<Models.IconModel>("IconModel", 0, 1);
                qmlEngine.Load(Path.Combine(qmlFilesPath, "Main.qml"));
                return true;
            }
            return false;
        }

        // only for debug
        static void TempInitAudioModels()
        {
            string homePath;
            if (Environment.OSVersion.Platform == PlatformID.Unix || Environment.OSVersion.Platform == PlatformID.MacOSX) {
                homePath = Environment.GetEnvironmentVariable("HOME");
            } else {
                homePath = Environment.ExpandEnvironmentVariables("%HOMEDRIVE%%HOMEPATH%");
            }
            // only example
            Models.ListAudioModels.AddAudioModel(new Models.AudioModel(String.Format("{0}/sound/3. Aliotta Haynes Jeremiah - Lake Shore Drive.mp3", homePath)));
        }

        static int Main(string[] args)
        {
            // only for debug
            TempInitAudioModels();
            if (Init(ref args)) {
                return app.Exec();
            }
            return 1;
        }
    }
}
