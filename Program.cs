using System;
using System.IO;
using Qml.Net;

namespace audio_player
{
    struct Resources
    {
        public static readonly string imagesDirectory = Path.Combine(Directory.GetCurrentDirectory(), ".images");
    }

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

        private static void initResources()
        {
            clearResources();
            Directory.CreateDirectory(Resources.imagesDirectory);
        }

        private static void clearResources()
        {
            if (Directory.Exists(Resources.imagesDirectory)) {
                Directory.Delete(Resources.imagesDirectory, true);
            }
        }

        static int Main(string[] args)
        {
            initResources();
            if (Init(ref args)) {
                return app.Exec();
            }
            clearResources();
            return 1;
        }
    }
}
