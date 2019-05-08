using System;
using System.IO;
using System.Collections.Generic;
using System.Drawing;
using System.Drawing.Imaging;
using TagLib;

namespace audio_player.Models
{
    public class AudioModel
    {
        private string name;
        private string path;
        private string duration;
        private string singer;
        private string album;
        private string year = "----";
        private string image;
        private bool valid = true;
        private readonly List<Exception> exceptions = new List<Exception>
        {
            new TagLib.UnsupportedFormatException(), 
            new NullReferenceException(),
            new DirectoryNotFoundException()
        };

        public AudioModel(string _path)
        {
            try {
                var tgFile = TagLib.File.Create(_path);
                if (tgFile is null) { 
                    throw new NullReferenceException();
                }
                path = _path;
                setName(ref tgFile);
                setDuration(ref tgFile);
                setSinger(ref tgFile);
                setAlbum(ref tgFile);
                setYear(ref tgFile);
                setImage(ref tgFile);
            } catch (Exception e) {
                if (exceptions.Contains(e)) {
                    valid = false;
                } else {
                    throw e;
                }
            }
        }

        public string getPath() => path;
        public string getSongName() => name;
        public string getDuration() => duration;
        public string getSingerName() => singer;
        public string getAlbum() => album;
        public string getYear() => year;
        public string getImage() => image;
        public bool isValid() => valid;
        public bool hasYear() => year != "----";
        public bool hasImage() => !string.IsNullOrEmpty(image) && !string.IsNullOrWhiteSpace(image);

        private void setName(ref TagLib.File tgFile)
        {
            if (!string.IsNullOrEmpty(tgFile.Tag.Title)) {
                name = tgFile.Tag.Title;
            } else {
                name = Path.GetFileName(path);
            }
        }
        private void setDuration(ref TagLib.File tgFile)
        {
            int hours = tgFile.Properties.Duration.Hours;
            int minutes = tgFile.Properties.Duration.Minutes;
            int seconds = tgFile.Properties.Duration.Seconds;

            if (hours > 100) {
                hours = 99;
            }

            duration = (hours < 10 ? hours.ToString().PadLeft(2, '0') : hours.ToString()) 
                        + ":" + 
                        (minutes < 10 ? minutes.ToString().PadLeft(2, '0') : minutes.ToString()) 
                        + ":" + 
                        (seconds < 10 ? seconds.ToString().PadLeft(2, '0') : seconds.ToString());
        }
        private void setAlbum(ref TagLib.File tgFile)
        {
            album = (!string.IsNullOrEmpty(tgFile.Tag.Album) ? tgFile.Tag.Album : "Unknown"); 
        }
        private void setSinger(ref TagLib.File tgFile)
        {
            if (tgFile.Tag.Performers.Length > 0) {
                foreach(string performer in tgFile.Tag.Performers) {
                    singer += performer + ",";
                }
                singer = singer.Remove(singer.Length - 1);
            } else {
                singer = "Unknown";
            }
        }
        private void setYear(ref TagLib.File tgFile)
        {
            if (tgFile.Tag.Year > 1900 && tgFile.Tag.Year <= DateTime.Now.Year) {
                year = tgFile.Tag.Year.ToString();
            }
        }
        private void setImage(ref TagLib.File tgFile)
        {
            if (tgFile.Tag.Pictures.Length > 0) {
                image = Path.Combine(Resources.imagesDirectory, name);
                var pixmap = Image.FromStream(new MemoryStream(tgFile.Tag.Pictures[0].Data.Data));
                pixmap.Save(image, ImageFormat.Png);
            }
        }
    }
}