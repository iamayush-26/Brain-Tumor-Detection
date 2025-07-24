function varargout = Brain_Tumor_Detector(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Brain_Tumor_Detector_OpeningFcn, ...
                   'gui_OutputFcn',  @Brain_Tumor_Detector_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Brain_Tumor_Detector_OpeningFcn(hObject, ~, handles, varargin)
handles.output = hObject;
set(hObject, 'Color', [0.9 0.95 1]);
guidata(hObject, handles);

function varargout = Brain_Tumor_Detector_OutputFcn(~, ~, handles)
varargout{1} = handles.output;

function select_mage_Callback(~, ~, handles)
global img1 img2
[path, nofile] = imgetfile();
if nofile
    msgbox(sprintf('Image not found!'), 'Error', 'Warning');
    return
end
img1 = im2double(imread(path));
img2 = img1;
axes(handles.axes1);
imshow(img1);
title('\fontsize{20}\color[rgb]{1,0,1} MRI Image');

function meadian_filtering_Callback(hObject, eventdata, handles)
global img1
axes(handles.axes2)
if size(img1,3) == 3
    img1 = rgb2gray(img1);
end
K = medfilt2(img1, [3 3]);
imshow(K);
title('\fontsize{20}\color[rgb]{1,0,1} Median Filtered');

function edge_detection_Callback(hObject, ~, handles)
global img1
axes(handles.axes3);
if size(img1,3) == 3
    grayImage = rgb2gray(img1);
else
    grayImage = img1;
end
K = medfilt2(grayImage);
C = double(K);
B = zeros(size(C));
for i = 1:size(C,1)-2
    for j = 1:size(C,2)-2
        Gx = ((2*C(i+2,j+1) + C(i+2,j) + C(i+2,j+2)) - (2*C(i,j+1) + C(i,j) + C(i,j+2)));
        Gy = ((2*C(i+1,j+2) + C(i,j+2) + C(i+2,j+2)) - (2*C(i+1,j) + C(i,j) + C(i+2,j)));
        B(i,j) = sqrt(Gx.^2 + Gy.^2);
    end
end
imshow(B, []);
title('\fontsize{20}\color[rgb]{1,0,1} Edge Detection');

function tumor_detection_Callback(hObject, eventdata, handles)
global img1
axes(handles.axes4);
if size(img1, 3) == 3
    grayImage = rgb2gray(img1);
else
    grayImage = img1;
end
filteredImage = medfilt2(grayImage, [3 3]);
bw = imbinarize(filteredImage, 'adaptive');
bw = imfill(bw, 'holes');
bw = bwareaopen(bw, 500);
mask = bw;
skullRemoved = filteredImage;
skullRemoved(~mask) = 0;
bwTumor = imbinarize(skullRemoved, 0.65);
bwTumor = imopen(bwTumor, strel('disk', 2));
bwTumor = imclose(bwTumor, strel('disk', 4));
bwTumor = imfill(bwTumor, 'holes');
bwTumor = bwareaopen(bwTumor, 100);
label = bwlabel(bwTumor);
stats = regionprops(label, 'Area', 'Solidity');
density = [stats.Solidity];
area = [stats.Area];
min_area_threshold = 200;
min_solidity_threshold = 0.7;
valid_tumors = find(area > min_area_threshold & density > min_solidity_threshold);
if ~isempty(valid_tumors)
    [~, idx] = max(area(valid_tumors));
    tumor_label = valid_tumors(idx);
    tumor = ismember(label, tumor_label);
    tumor = imdilate(tumor, strel('disk', 3));
    imshow(filteredImage);
    hold on;
    Bound = bwboundaries(tumor, 'noholes');
    for i = 1:length(Bound)
        plot(Bound{i}(:,2), Bound{i}(:,1), 'y', 'LineWidth', 2);
    end
    title('\fontsize{18}\color[rgb]{1,0,1} Tumor Detected!');
    hold off;
else
    imshow(filteredImage);
    title('\fontsize{18}\color[rgb]{0,1,0} No Tumor Detected');
end
