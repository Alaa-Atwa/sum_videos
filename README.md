# 🎬 Video Duration Summator

Need to know how long that entire course folder really is? Want to estimate your weekend binge time? This tiny but mighty Bash script scans a directory full of videos and calculates the **total viewing duration** with precision.

Powered by `exiftool`, it supports multiple video formats and handles nested folders too.

---

## ✨ Features

✅ Calculates the **total duration** of all videos  
✅ Works **recursively** through subfolders  
✅ Supports common video formats (MP4, MKV, AVI, MOV, and more)  
✅ Clean and friendly output (HH:MM:SS)  
✅ Linux-friendly and portable (Docker support included!)  

---

## 🚀 Usage

### Prerequisites

Install `exiftool` if you don’t already have it:
```bash
sudo apt install exiftool
````

or

```bash
sudo apk add exiftool
```

### Run the script

```bash
./sum_videos.sh /path/to/videos
```

If no directory is provided, it defaults to the current folder:

```bash
./sum_videos.sh
```

---

## 🐳 Run with Docker (optional)

No dependencies? No problem.

### Build the image

```bash
docker build -t video-duration-sum .
```

### Run against your current directory of videos

```bash
docker run --rm -v "$(pwd)":/data video-duration-sum
```

---

## 🔧 Supported Video Formats

* `.mp4`
* `.mkv`
* `.avi`
* `.mov`
* `.webm`
* `.m4v`
* `.flv`

You can easily extend the list inside the script.

---

## 📝 Example Output

```
Total: 12 hours, 43 minutes, 19 seconds
```

That’s how long your course binge will be. Choose snacks wisely.

---

## 🧠 How It Works

The script uses:

* `exiftool` to extract each video’s duration in numeric seconds
* `awk` to sum and convert to readable time

No complex parsing. No broken math. Just accurate results.

---

## ❤️ Contributions

Suggestions, improvements, and PRs are always welcome.

---

