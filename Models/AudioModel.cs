namespace audio_player.Models
{
    public class AudioModel
    {
        private string title;
        private string path;
        private bool valid;

        public AudioModel(string _title, string _path)
        {
            title = _title;
            path = _path;
            // todo
            valid = _title.Length > 0 && _path.Length > 0;
        }

        public string getPath() => path;
        public string getTitle() => title;
        public bool isValid() => valid;
    }
}