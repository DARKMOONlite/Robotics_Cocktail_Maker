
function varargout = untitledGUI(varargin)
% UNTITLEDGUI MATLAB code for untitledGUI.fig
%      UNTITLEDGUI, by itself, creates a new UNTITLEDGUI or raises the existing
%      singleton*.
%
%      H = UNTITLEDGUI returns the handle to a new UNTITLEDGUI or the handle to
%      the existing singleton*.
%
%      UNTITLEDGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in UNTITLEDGUI.M with the given input arguments.
%
%      UNTITLEDGUI('Property','Value',...) creates a new UNTITLEDGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before untitledGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to untitledGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% Edit the above text to modify the response to help untitledGUI
% Last Modified by GUIDE v2.5 12-May-2022 21:56:57
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @untitledGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @untitledGUI_OutputFcn, ...
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
% --- Executes just before untitledGUI is made visible.
function untitledGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to untitledGUI (see VARARGIN)
% Choose default command line output for untitledGUI
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% This sets up the initial plot - only do when we are invisible
% so window can get raised using untitledGUI.
if strcmp(get(hObject,'Visible'),'off')
    plot(rand(5));
end
% UIWAIT makes untitledGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);
% --- Outputs from this function are returned to the command line.
function varargout = untitledGUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
cla
axes(handles.axes1); 

%environment/base

base = transl(0,0,0);

Environment class 
environment = Environment(base);
 
[PuttingSimulatedObjectsIntoTheEnvironment] = environment.build(base);

% Create drinks 

objects = Create_Drinks();

%Load ur10e 
ur10e = UR10e()

% Load gripper
gripper = Gripper()

% move gripper to end-effector 
gripper.move_gripper(ur10e.model.fkine(ur10e.currentJoints))

% assign ur10e variables for data access
model = ur10e.model;
Estop = ur10e.Estop;

%assigned variables attached to data for 'handles' structure access
data = guidata(hObject);
data.gripper = gripper;
data.model = model;
data.Estop = Estop;
data.ur10e = ur10e;
data.objects = objects;

guidata(hObject,data);


set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.pushbutton8,'Enable','off')
set(handles.pushbutton4,'Enable','off')
set(handles.pushbutton5,'Enable','off')
set(handles.pushbutton6,'Enable','off')
set(handles.pushbutton7,'Enable','off')
set(handles.pushbutton9,'Enable','on')
set(handles.pushbutton10,'Enable','off')
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axes(handles.axes1);
% cla;
% 
% popup_sel_index = get(handles.popupmenu1, 'Value');
% switch popup_sel_index
%     case 1
%         plot(rand(5));
%     case 2
%         plot(sin(1:0.01:25.99));
%     case 3
%         bar(1:.5:10);
%     case 4
%         plot(membrane);
%     case 5
%         surf(peaks);
% end
% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end
% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)
% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end
delete(handles.figure1)
% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end
set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});
% --- Executes on button press in plusX_pushbutton.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(1,4) = tr(1,4) + 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 


function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(1,4) = tr(1,4) - 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 



% --- Executes on button press in pushbutton4. (E-stop)
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton2,'Enable','off')
set(handles.pushbutton3,'Enable','off')
set(handles.pushbutton8,'Enable','off')
set(handles.pushbutton5,'Enable','off')
set(handles.pushbutton6,'Enable','off')
set(handles.pushbutton7,'Enable','off')


handles.Estop = 1;
display(handles.Estop);


% --- Executes on button press in pushbutton5. (+y)
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(2,4) = tr(2,4) + 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 

% --- Executes on button press in pushbutton6. (-y)
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(2,4) = tr(2,4) - 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 

% --- Executes on button press in pushbutton7. (+z)
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(3,4) = tr(3,4) + 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 

% --- Executes on button press in pushbutton8. (-z)
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
q = handles.model.getpos; 
tr = handles.model.fkine(q); 
tr(3,4) = tr(3,4) - 0.01; 
newQ = handles.model.ikcon(tr,q); 
handles.model.animate(newQ); 



% --- Executes on button press in pushbutton9. (Start button)
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.pushbutton2,'Enable','on')
set(handles.pushbutton3,'Enable','on')
set(handles.pushbutton4,'Enable','on')
set(handles.pushbutton8,'Enable','on')
set(handles.pushbutton5,'Enable','on')
set(handles.pushbutton6,'Enable','on')
set(handles.pushbutton7,'Enable','on')
set(handles.pushbutton10,'Enable','on')

% --- Executes on button press in pushbutton10. (make gin and tonic)
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 0 - Not used
% 1 =   Vodka
% 2 =   Rum
% 3 =   Tonic Water
% 4 =   Gin
% 5 =   Dispense Ice
% 6 =   Dispense Lime
% 7 =   Dispense Sugar
% 8 - Not used
% 9 - Not used
% 
% a =   Pick glass up - Needed before adding dispenser ingredients otherwise
%       things will teleport 
% b =   Return glass if last ingredient was from dispenser - Also needed if
%       need to add drinks to glass after adding dispenser ingredients
% c =   Return arm to idle if last igredient was drink

handles.ur10e.makeDrink("a56b34c", handles.objects, handles.gripper);
%handles.gripper.move_gripper(handles.model.fkine(handles.model.currentJoints));
