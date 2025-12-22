# 🧠 Brain Tumor Detection using MRI (MATLAB)

🚀 A MATLAB-based project to detect brain tumors from MRI images using classic image processing and segmentation techniques. The goal is to automate the identification of abnormal tumor regions.

---

## 📁 Project Structure

📂 Project Structure

Brain_Tumor_Detection/ <br>
├── sample_mri_images    <br>
├── detect_tumor.m         <br>
├── preprocess_image.m      <br>
├── segment_tumor.m         <br>
└── README.md       <br>

---

## ✨ Features

✅ Image enhancement and preprocessing  
✅ Skull stripping (optional)  
✅ Tumor segmentation using thresholding or region-growing  
✅ Visual output comparing original vs segmented tumor

---

## 🛠️ Requirements

- MATLAB (R2018 or above recommended) 🧪  
- Image Processing Toolbox 📦

---

## ▶️ How to Run

1. Open `detect_tumor.m` in MATLAB 🧑‍💻  
2. Provide the MRI image path or hardcode it inside the script 🗂️  
3. Click **Run** ▶️  
4. Output will display segmented tumor region 📊

---

## 🖼️ Sample Output

<img width="2222" height="852" alt="image" src="https://github.com/user-attachments/assets/e95c6e39-bb07-48c4-881d-738475b9e460" />


---

## 📌 Note

⚠️ This project is for **academic and research purposes only**.  
It is **not intended for real-world medical diagnosis** or clinical usage.

---

## ⚙️ Working Process

This project uses MATLAB GUI to detect brain tumors from MRI images in a step-by-step visual manner. Here's how it works:

---

### 🖼️ 1. Load MRI Image
- Click on the **"Select Image"** button
- Choose a brain MRI image (`.jpg`, `.png`, etc.)
- The image will be displayed in the first panel

---

### 🧹 2. Median Filtering
- Click **"Median Filtering"**
- Removes noise and smoothens the image using a 3x3 median filter
- Grayscale conversion is automatically handled

---

### ✂️ 3. Edge Detection
- Click **"Edge Detection"**
- Uses custom Sobel-based gradient operations (`Gx` and `Gy`) to highlight edges
- Shows outlines of structures within the brain

---

### 🧠 4. Tumor Detection
- Click **"Tumor Detection"**
- Steps involved:
  - Image is converted to binary using **adaptive thresholding**
  - Morphological operations (fill holes, open, close)
  - Skull region is removed by masking
  - Tumor region is extracted using:
    - **Area > 200 pixels**
    - **Solidity > 0.7**
  - Largest valid region is selected and its boundary is shown in **yellow**
- Displays **“Tumor Detected!”** or **“No Tumor Detected”** accordingly

---

### 💡 Key Techniques Used

| Technique | Description |
|----------|-------------|
| `medfilt2` | Removes noise (Median Filter) |
| `imbinarize` | Adaptive image thresholding |
| `regionprops` | Extracts region area & solidity |
| `bwlabel` | Labels connected tumor regions |
| `bwboundaries` | Draws boundary of detected tumor |

---

### 🧪 GUI Overview

- **axes1** → Original MRI Image  
- **axes2** → Median Filtered Image  
- **axes3** → Edge Detection Output  
- **axes4** → Final Tumor Detection Result

---

