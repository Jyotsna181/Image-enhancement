function varargout = MainPage(varargin)
% MAINPAGE MATLAB code for MainPage.fig
%      MAINPAGE, by itself, creates a new MAINPAGE or raises the existing
%      singleton*.
%
%      H = MAINPAGE returns the handle to a new MAINPAGE or the handle to
%      the existing singleton*.
%
%      MAINPAGE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPAGE.M with the given input arguments.
%
%      MAINPAGE('Property','Value',...) creates a new MAINPAGE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MainPage_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MainPage_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MainPage

% Last Modified by GUIDE v2.5 06-Apr-2019 00:36:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MainPage_OpeningFcn, ...
                   'gui_OutputFcn',  @MainPage_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before MainPage is made visible.
function MainPage_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MainPage (see VARARGIN)

% Choose default command line output for MainPage
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MainPage wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MainPage_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnBrowse.
function btnBrowse_Callback(hObject, eventdata, handles)
clc
[filename, pathname] = uigetfile({'*.*';'*.bmp';'*.jpg';'*.gif'}, 'Browse an Input Image File');
I = imread([pathname,filename]);
I = imresize(I,[256,256]);
I2 = imresize(I,[300,400]);
axes(handles.axes1);
imshow(I2);title('\color{white}Input Image');

guidata(hObject,handles);
% hObject    handle to btnBrowse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in whitebal.
function whitebal_Callback(hObject, eventdata, handles)
im=im2double(getimage(handles.axes1));
handles.im=im;
firstInput = whiteBalance( im );
axes(handles.axes2);
imshow(firstInput);title('\color{white}First Input');
handles.firstinput=firstInput;
guidata(hObject, handles);

% hObject    handle to whitebal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in EnhContrast.
function EnhContrast_Callback(hObject, eventdata, handles)
im=im2double(getimage(handles.axes1));
secondInput = enhanceContrast( im );
axes(handles.axes3);
imshow(secondInput);title('\color{white}Second Input');
handles.secondinput=secondInput;
guidata(hObject, handles);
% hObject    handle to EnhContrast (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
firstInput=handles.firstinput;
luminanceWeightmap1 = luminanceWeightmap(firstInput);
figure;subplot(1,3,1);imshow(luminanceWeightmap1);title('luminanceWeightmap');
chromaticWeightmap1 = chromaticWeightmap(firstInput);
subplot(1,3,2);imshow(chromaticWeightmap1);title('chromaticWeightmap');
saliencyWeightmap1 = saliencyWeightmap(firstInput);
subplot(1,3,3);imshow(saliencyWeightmap1);title('saliencyWeightmap');
resultedWeightmap1 = luminanceWeightmap1 .* chromaticWeightmap1 .* saliencyWeightmap1 ;
handles.resultedWeightmap1=resultedWeightmap1;
guidata(hObject, handles);
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
secondInput=handles.secondinput;
luminanceWeightmap2 = luminanceWeightmap(secondInput);
figure;subplot(1,3,1);imshow(luminanceWeightmap2);title('luminanceWeightmap');
chromaticWeightmap2 = chromaticWeightmap(secondInput);
subplot(1,3,2);imshow(chromaticWeightmap2);title('chromaticWeightmap');
saliencyWeightmap2 = saliencyWeightmap(secondInput);
subplot(1,3,3);imshow(saliencyWeightmap2);title('saliencyWeightmap');
%Resultant Weight map of the second input
resultedWeightmap2 = luminanceWeightmap2 .* chromaticWeightmap2 .* saliencyWeightmap2 ;
handles.resultedWeightmap2=resultedWeightmap2;
guidata(hObject, handles);
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in normalize.
function normalize_Callback(hObject, eventdata, handles)

normaizedWeightmap1 = handles.resultedWeightmap1 ./ (handles.resultedWeightmap1 + handles.resultedWeightmap2);
normaizedWeightmap2 = handles.resultedWeightmap2 ./ (handles.resultedWeightmap1 + handles.resultedWeightmap2);

figure;subplot(1,2,1);imshow(normaizedWeightmap1);title('normaizedWeightmap1');
subplot(1,2,2);imshow(normaizedWeightmap2);title('normaizedWeightmap2');
handles.normaizedWeightmap1=normaizedWeightmap1;
handles.normaizedWeightmap2=normaizedWeightmap2;
guidata(hObject, handles);
% hObject    handle to normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)

%Generating Gaussian Pyramid for normalized weight maps
gaussianPyramid1 = genPyr(handles.normaizedWeightmap1,'gauss',5);
gaussianPyramid2 = genPyr(handles.normaizedWeightmap2,'gauss',5);
%figure;subplot(1,2,1);imshow(gaussianPyramid1);title('gaussianPyramid1');
%subplot(1,2,2);imshow(gaussianPyramid2);title('gaussianPyramid2');
helpdlg('Done');
handles.gaussianPyramid1=gaussianPyramid1;
handles.gaussianPyramid2=gaussianPyramid2;
guidata(hObject, handles);
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
im=handles.im;
firstInput=handles.firstinput;
secondInput=handles.secondinput;
for i = 1 : 5
    tempImg = [];
    for j = 1 : size(im,3)
        laplacianPyramid1 = genPyr(firstInput(:,:,j),'laplace',5); %Generating Laplacian Pyramid for derrived inputs
        laplacianPyramid2 = genPyr(secondInput(:,:,j),'laplace',5);
        rowSize = min([size(laplacianPyramid1{i},1),size(laplacianPyramid2{i},1),size(handles.gaussianPyramid1{i},1),size(handles.gaussianPyramid2{i},1)]);
        columnSize = min([size(laplacianPyramid1{i},2),size(laplacianPyramid2{i},2),size(handles.gaussianPyramid1{i},2),size(handles.gaussianPyramid2{i},2)]);
        tempImg(:,:,j) = laplacianPyramid1{i}(1:rowSize , 1:columnSize) .* handles.gaussianPyramid1{i}(1:rowSize, 1:columnSize) + laplacianPyramid2{i}(1:rowSize, 1:columnSize) .* handles.gaussianPyramid2{i}(1:rowSize, 1:columnSize);
    end
    fusedPyramid1{i} = tempImg;
end

enhancedImage = pyrReconstruct(fusedPyramid1);
figure
imshow(enhancedImage);
title('Final Output');
axes(handles.axes5);
imshow(enhancedImage);title('Final Outpt');


% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
