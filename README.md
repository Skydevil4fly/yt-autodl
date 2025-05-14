# yt-autodl

This Bash script automates YouTube downloads using `yt-dlp` and `ffmpeg-python`. It sets up a virtual environment, checks/installs dependencies, and offers an interactive interface to download single videos, playlists, or channels in MP3/MP4 formats with support for filters, Shorts, and keyword matching.

---

## 📦 Features

- ✅ Automatic Python & pip check and install  
- 🧪 Creates and manages a Python virtual environment  
- 🔄 Interactive CLI for:  
  - Single video downloads  
  - Playlist and channel downloads  
  - MP3 (audio-only) or MP4 (video) output  
- 🎯 Filter downloads using:  
  - Whitelist and blacklist keywords  
  - Option to exclude or include YouTube Shorts  
- 💾 Clean, safe filename formatting (`%(title).200s.%(ext)s`)  
- 🛠 Uses `yt-dlp` with optional browser-based cookies (e.g., Chrome)  

---

## 🚀 Usage

1. **Place the script** in the directory where you want the videos to be downloaded.  
2. **Make it executable** (only once):  
   ```bash
   chmod +x testing.sh
   ```
3. **Run the script**:  
   ```bash
   ./testing.sh
   ```

Follow the prompts to enter a YouTube URL, choose format, and optionally filter content by keywords.

---

## 📌 Requirements

The script automatically installs these if not already present:

- Python 3
- pip3
- [yt-dlp](https://github.com/yt-dlp/yt-dlp)
- [ffmpeg-python](https://github.com/kkroening/ffmpeg-python)
- `ffmpeg` (must be installed on your system)

> 💡 Ensure `ffmpeg` is installed on your system (used by `ffmpeg-python`).

---

## ⚠️ Disclaimer

This tool is intended for **personal and educational use only**.  
Do **not use it to download copyrighted content**  
or violate YouTube’s [Terms of Service](https://www.youtube.com/t/terms).  
Use responsibly and respect content ownership.

---

## 📝 License

This project is licensed under the **MIT License**.

```
Copyright (C) 2025 SKYDEVIL4FLY

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

You should have received a copy of the MIT License  
along with this program. If not, see <https://opensource.org/licenses/MIT>.

```

---

## 👤 Author

**SKYDEVIL4FLY**  
Feel free to fork, contribute, or suggest improvements. Pull requests are welcome!

