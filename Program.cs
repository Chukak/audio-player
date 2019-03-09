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
                qmlEngine.Load(Path.Combine(qmlFilesPath, "Main.qml"));
                return true;
            }
            return false;
        }

        // only for debug
        static void TempInitAudioModels()
        {
            Models.ListAudioModels.AddAudioModel(new Models.AudioModel("Die hard 1", "/home/elliot/Загрузки/Крепкий орешек 1 - Die Hard 1 (1988) BDRip 10802p.mkv"));
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
