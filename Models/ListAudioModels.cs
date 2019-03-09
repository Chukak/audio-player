using System;
using System.Collections.Generic;

namespace audio_player.Models
{
    public class ListAudioModels
    {
        private static List<AudioModel> audios = new List<AudioModel>();
        private bool isValid;

        static public bool AddAudioModel(AudioModel model)
        {
            if (model.isValid()) {
                audios.Add(model);
                return true;
            }
            return false;
        }

        public ListAudioModels()
        {
           isValid = audios.Count > 0;
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