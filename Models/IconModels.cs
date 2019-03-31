using System.IO;

namespace audio_player.Models
{
    public class IconModel
    {
        private static readonly string iconsPath = Path.Combine(Directory.GetCurrentDirectory(), "icons");

        private static readonly string playButtonIconName = "play-button.png";
        private static readonly string playButtonHoverIconName = "play-button-hover.png";
        private static readonly string pauseButtonIconName = "pause-button.png";
        private static readonly string pauseButtonHoverIconName = "pause-button-hover.png";
        private static readonly string stopButtonIconName = "stop-button.png";
        private static readonly string stopButtonHoverIconName = "stop-button-hover.png";
        private static readonly string soundButtonIconName = "sound-button.png";
        private static readonly string soundButtonHoverIconName = "sound-button-hover.png";
        private static readonly string mutedSoundButtonIconName = "muted-sound-button.png";
        private static readonly string mutedSoundButtonHoverIconName = "muted-sound-button-hover.png";
        private static readonly string addTrackButtonIconName = "add-track-button.png";
        private static readonly string addTrackButtonHoverIconName = "add-track-button-hover.png";
 
        private  readonly string playButton = Path.Combine(iconsPath, playButtonIconName);
        private  readonly string playButtonHover = Path.Combine(iconsPath, playButtonHoverIconName);
        private  readonly string pauseButton = Path.Combine(iconsPath, pauseButtonIconName);
        private  readonly string pauseButtonHover = Path.Combine(iconsPath, pauseButtonHoverIconName);
        private  readonly string stopButton = Path.Combine(iconsPath, stopButtonIconName);
        private  readonly string stopButtonHover = Path.Combine(iconsPath, stopButtonHoverIconName);
        private  readonly string soundButton = Path.Combine(iconsPath, soundButtonIconName);
        private  readonly string soundButtonHover = Path.Combine(iconsPath, soundButtonHoverIconName);
        private  readonly string mutedSoundButton = Path.Combine(iconsPath, mutedSoundButtonIconName);
        private  readonly string mutedSoundButtonHover = Path.Combine(iconsPath, mutedSoundButtonHoverIconName);
        private  readonly string addTrackButton = Path.Combine(iconsPath, addTrackButtonIconName);
        private  readonly string addTrackButtonHover = Path.Combine(iconsPath, addTrackButtonHoverIconName);

        public string playButtonIcon() => playButton;
        public string playButtonHoverIcon() => playButtonHover;
        public string pauseButtonIcon() => pauseButton;
        public string pauseButtonHoverIcon() => pauseButtonHover;
        public string stopButtonIcon() => stopButton;
        public string stopButtonHoverIcon() => stopButtonHover;
        public string soundButtonIcon() => soundButton;
        public string soundButtonHoverIcon() => soundButtonHover;
        public string mutedSoundButtonIcon() => mutedSoundButton;
        public string mutedSoundButtonHoverIcon() => mutedSoundButtonHover;
        public string addTrackButtonIcon() => addTrackButton;
        public string addTrackButtonHoverIcon() => addTrackButtonHover;
        

    }
}