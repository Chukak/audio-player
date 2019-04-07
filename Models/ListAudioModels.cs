using System;
using System.Collections.Generic;

namespace audio_player.Models
{
    public class ListAudioModels
    {
        private static List<AudioModel> audios = new List<AudioModel>();
        private bool isValid;

        static public int Count = audios.Count;

        static public bool AddAudioModel(AudioModel model)
        {
            return AddModel(ref model);
        }

        public ListAudioModels()
        {
            isValid = Count > 0;
        }

        public bool AddAudioModel(string path)
        {
            var model = new AudioModel(path);
            return AddModel(ref model);
        }

        public AudioModel At(int index)
        {
            checkIndex(index);
            return audios[index];
        }

        public List<AudioModel> AudioModels()
        {
            return audios;
        }

        static private bool AddModel(ref AudioModel model)
        {
            if (model.isValid()) {
                audios.Add(model);
                ++Count;
                return true;
            }
            return false;
        }

        private void checkIndex(int index)
        {
            if (index > audios.Count) {
                throw new Exception("Index more than number of videos in the list!");
            } else if (index < 0) {
                throw new Exception("Index less than zero!");
            }
        }
    }
}