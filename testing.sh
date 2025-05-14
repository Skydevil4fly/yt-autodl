#!/bin/bash

# Function to check if Python3 is installed
check_python() {
  if ! command -v python3 &>/dev/null; then
    echo "⚠️ Python3 is not installed. Installing Python3..."
    sudo apt update
    sudo apt install -y python3 python3-pip
  else
    echo "✅ Python3 is already installed."
  fi
}

# Function to check if pip3 is installed
check_pip() {
  if ! command -v pip3 &>/dev/null; then
    echo "⚠️ Pip3 is not installed. Installing pip3..."
    sudo apt install -y python3-pip
  else
    echo "✅ Pip3 is already installed."
  fi
}

# Check if Python and pip are installed
check_python
check_pip

# Define the virtual environment directory
VENV_DIR="$(dirname "$0")/yt-env"

# Check if the virtual environment exists
if [ ! -d "$VENV_DIR" ]; then
  echo "🔧 Virtual environment not found. Creating a new one..."
  
  # Create the virtual environment
  python3 -m venv "$VENV_DIR"
  
  # Activate the virtual environment
  source "$VENV_DIR/bin/activate"
  
  # Install required dependencies in the virtual environment
  echo "🔧 Installing dependencies in the virtual environment..."
  pip install --upgrade pip
  pip install yt-dlp ffmpeg-python
else
  # If virtual environment exists, activate it
  echo "🔧 Activating existing virtual environment..."
  source "$VENV_DIR/bin/activate"
fi

clear

# ========== DISPLAY AUTHOR INFO ==========
echo "           Created By SKYDEVIL4FLY          "
echo "╔══════════════════════════════════════════╗"
echo "║        - YouTube Downloader Tool         ║"
echo "╠══════════════════════════════════════════╣"
echo "║  ⚠️  This tool is for personal us         ║"
echo "║  Do not reupload or distribute content   ║"
echo "║     that may violate copyright laws.     ║"
echo "╚══════════════════════════════════════════╝"
echo " Before you proceed place the script in the folder where you want to download"
sleep 3

# ========== ASK FOR URL ==========
read -p "📥 Enter YouTube URL: " URL
URL_LOWER=$(echo "$URL" | tr '[:upper:]' '[:lower:]')

# ========== DETECT TYPE ==========
IS_PLAYLIST=$(echo "$URL_LOWER" | grep -q 'list=' && echo "yes")
IS_CHANNEL=$(echo "$URL_LOWER" | grep -E -q '@|channel/' && echo "yes")
IS_VIDEO=$(echo "$URL_LOWER" | grep -q 'watch?v=' && echo "yes")

# ========== ASK FOR FORMAT ==========
ask_format() {
  echo ""
  echo "🎞️  Choose download format:"
  select FORMAT in "MP3 (Audio only)" "MP4 (Video)"; do
    case $REPLY in
      1) FORMAT_CHOICE="mp3"; break ;;
      2) FORMAT_CHOICE="mp4"; break ;;
      *) echo "Invalid option." ;;
    esac
  done
}

# ========== START BRANCHING ==========
if [[ "$IS_VIDEO" == "yes" && "$IS_PLAYLIST" != "yes" ]]; then
  echo "🎬 Detected: Single video."
  ask_format
  echo "▶️ Downloading single video as $FORMAT_CHOICE..."

  if [[ "$FORMAT_CHOICE" == "mp3" ]]; then
    yt-dlp "$URL" -x --audio-format mp3 --audio-quality 0 -o "%(title).200s.%(ext)s"
  else
    yt-dlp "$URL" -f best -o "%(title).200s.%(ext)s"
  fi

  exit 0
fi

# ========== FOR MULTIPLE VIDEO DOWNLOAD ==========
echo "📁 Detected: Playlist or Channel."

read -p "❓ Include YouTube Shorts? (y/n): " INCLUDE_SHORTS
SHORTS_FILTER="--match-filter \"!is_short\""
[[ "$INCLUDE_SHORTS" =~ ^[Yy]$ ]] && SHORTS_FILTER=""

read -p "✅ Whitelist keywords (separate by space, optional): " WHITELIST
read -p "⛔ Blacklist keywords (separate by space, optional): " BLACKLIST

# Build regex patterns
MATCH_TITLE=""
REJECT_TITLE=""
if [[ -n "$WHITELIST" ]]; then
  WL_PATTERN=$(echo "$WHITELIST" | sed 's/ /|/g')
  MATCH_TITLE="--match-title \"(?i)($WL_PATTERN)\""
fi

if [[ -n "$BLACKLIST" ]]; then
  BL_PATTERN=$(echo "$BLACKLIST" | sed 's/ /|/g')
  REJECT_TITLE="--reject-title \"(?i)($BL_PATTERN)\""
fi

ask_format
echo "📦 Downloading all matching videos as $FORMAT_CHOICE..."

# ========== FINAL yt-dlp COMMAND ==========
if [[ "$FORMAT_CHOICE" == "mp3" ]]; then
  yt-dlp "$URL" \
    --cookies-from-browser chrome \
    -x --audio-format mp3 --audio-quality 0 \
    --output "%(title).200s.%(ext)s" \
    $SHORTS_FILTER $MATCH_TITLE $REJECT_TITLE
else
  yt-dlp "$URL" \
    --cookies-from-browser chrome \
    -f best \
    --output "%(title).200s.%(ext)s" \
    $SHORTS_FILTER $MATCH_TITLE $REJECT_TITLE
fi

echo "✅ Done."
