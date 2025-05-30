function varargout = samviq_gui(varargin)
% MODIFED on 5/25/2025 by Nima: 
% 1 ref, 4 stimuli

%SAMVIQ_GUI M-file for samviq_gui.fig
%      SAMVIQ_GUI, by itself, creates a new SAMVIQ_GUI or raises the existing
%      singleton*. 
%
%      H = SAMVIQ_GUI returns the handle to a new SAMVIQ_GUI or the handle to
%      the existing singleton*.
%
%      SAMVIQ_GUI('Property','Value',...) creates a new SAMVIQ_GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to samviq_gui_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      SAMVIQ_GUI('CALLBACK') and SAMVIQ_GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in SAMVIQ_GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help samviq_gui

% Last Modified by GUIDE v2.5 14-Nov-2014 18:24:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @samviq_gui_OpeningFcn, ...
                   'gui_OutputFcn',  @samviq_gui_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before samviq_gui is made visible.
function samviq_gui_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for samviq_gui
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

init_gui_logic (hObject, handles);  % Our own function to set-up the experiment

% UIWAIT makes samviq_gui wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = samviq_gui_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function score_slider_Callback(hObject, eventdata, handles)
% hObject    handle to score_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

current_score           = round      (get(hObject, 'Value'));
selected_video          = get        (handles.selected_video, 'String');
video_mapping           = getappdata (handles.video_selection_group, 'video_mapping');
video_index             = getappdata (handles.video_selection_group, 'video_index');
all_scores              = getappdata (handles.video_selection_group, 'all_scores');
all_scores (video_mapping(video_index)) = current_score;
setappdata (handles.video_selection_group, 'all_scores', all_scores);
if numel (find (all_scores<0))==0
    setappdata (handles.video_selection_group, 'scene_done',1);
    set (handles.nextbutton, 'Enable', 'on');
    h = msgbox({'You have now scored all images.' ''...
        'Please ensure that you are happy with the relative ranking'...
        'of each image. You can continue to adjust the scores if'...
        'necessary before proceeding to the next scene' ''...
        'To continue to the next scene, please press the Next button'});
end

set(handles.score_textbox,'String',num2str(current_score));

%%% MODIFIED HERE %%%
switch lower(selected_video)
    % case {'reference'}
    %     set(handles.score_reference,'String',num2str(current_score));
    case {'a'}
        set(handles.scoreA,'String',num2str(current_score));
    case {'b'}
        set(handles.scoreB,'String',num2str(current_score));
    case {'c'}
        set(handles.scoreC,'String',num2str(current_score));
    case {'d'}
        set(handles.scoreD,'String',num2str(current_score));
    % case {'e'}
    %     set(handles.scoreE,'String',num2str(current_score));
    % case {'f'}
    %     set(handles.scoreF,'String',num2str(current_score));
    % case {'g'}
    %     set(handles.scoreG,'String',num2str(current_score));
    % case {'h'}
    %     set(handles.scoreH,'String',num2str(current_score));
    % case {'i'}
    %     set(handles.scoreI,'String',num2str(current_score));
%     case {'j'}
%         set(handles.scoreJ,'String',num2str(current_score));
%     case {'k'}
%         set(handles.scoreK,'String',num2str(current_score));
%     case {'l'}
%         set(handles.scoreL,'String',num2str(current_score));
%     case {'m'}
%         set(handles.scoreM,'String',num2str(current_score));
%     case {'n'}
%         set(handles.scoreN,'String',num2str(current_score));
%     case {'o'}
%         set(handles.scoreO,'String',num2str(current_score));
%     case {'p'}
%         set(handles.scoreP,'String',num2str(current_score));
    otherwise
        disp('This experiment is flawed');
end

% --- Executes during object creation, after setting all properties.
function score_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over score_slider.
function score_slider_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to score_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in nextbutton.
function nextbutton_Callback(hObject, eventdata, handles)
% hObject    handle to nextbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Save the scores to file (Do we want to do this more often, rather than just at the end?)
scenes_present       = getappdata (handles.video_selection_group, 'scenes_present');
scene_mapping        = getappdata (handles.video_selection_group, 'scene_mapping');
current_scene        = getappdata (handles.video_selection_group, 'current_scene');
video_mapping        = getappdata (handles.video_selection_group, 'video_mapping');
video_list           = getappdata (handles.video_selection_group, 'video_list');

scores.movie_name    = video_list(1).movie_name;
scores.movie_path    = video_list(1).movie_path;
scores.all_scores   = getappdata (handles.video_selection_group, 'all_scores');
scores.video_mapping = getappdata (handles.video_selection_group, 'video_mapping');
scores.observer      = getappdata (handles.video_selection_group, 'observer');
scores.age           = getappdata (handles.video_selection_group, 'age');
scores.gender        = getappdata (handles.video_selection_group, 'gender');
scores.start_time    = getappdata (handles.video_selection_group, 'start_time');
scores.end_time      = clock;
scores.observer
scores.scene_index = current_scene;

%%% MODIFIED HERE %%%

[SUCCESS,MESSAGE,MESSAGEID] = mkdir(strcat('HDR_results\',scores.observer{1}));
scores_filename      = strcat('HDR_results\',scores.observer,'\',scores.movie_name,'.mat');

save (scores_filename{1}, 'scores');

% Close all current movies
% movie_list           = getappdata(handles.video_selection_group,'movie_list');
% samviq_close_videos (movie_list);

%%% MODIFIED HERE %%%
%%% STIMULI NUMBER MODIFY %%%
video_mapping = randperm (4);
all_scores    = zeros (4,1) - 1;
scene_done    = 0;
setappdata (handles.video_selection_group, 'video_mapping', video_mapping);
setappdata (handles.video_selection_group, 'all_scores', all_scores);
setappdata (handles.video_selection_group, 'scene_done', scene_done);


% Prepare next scene
trial_win            = getappdata (handles.video_selection_group, 'trial_win');
current_scene        = current_scene + 1;

%%% MODIFIED HERE %%%
%%% MODIY NUMBER OF STIMULI %%%
scenes_present  = [1, 2]; 
num_scenes      = 2;

if (current_scene > num_scenes)
    h = msgbox({'Experiment is finished. Thank you for your Participation!'});
    Screen ('CloseAll');
    sca;
    close(handles.figure1)
else

video_list           = samviq_prepare_videos (trial_win, scenes_present(scene_mapping(current_scene)), video_mapping);

setappdata (handles.video_selection_group, 'current_scene', current_scene);
setappdata (handles.video_selection_group, 'video_list',    video_list);
setappdata (handles.video_selection_group, 'start_time',    clock);


% Reset user interface
set(handles.selected_video,'String', 'Reference');
set(handles.selected_video_2,'String', 'Reference');

%%% MODIFIED HERE %%%

handles.video_selection_group.SelectedObject = handles.button_reference;
set(handles.scoreA, 'String', '*');
set(handles.scoreB, 'String', '*');
set(handles.scoreC, 'String', '*');
set(handles.scoreD, 'String', '*');
% set(handles.scoreE, 'String', '*');
% set(handles.scoreF, 'String', '*');
% set(handles.scoreG, 'String', '*');
% set(handles.scoreH, 'String', '*');
% set(handles.scoreI, 'String', '*');
% set(handles.scoreJ, 'String', '*');
% set(handles.scoreK, 'String', '*');
% set(handles.scoreL, 'String', '*');
% set(handles.scoreM, 'String', '*');
% set(handles.scoreN, 'String', '*');
% set(handles.scoreO, 'String', '*');
% set(handles.scoreP, 'String', '*');
set(handles.score_reference, 'String', '*');
set (handles.score_slider,'Enable', 'off');
set(handles.scene_textbox,'String', video_list(1).movie_name);
% No advancing to the next scene until everything is scored!
set (handles.nextbutton,'Enable','off');


%%% MODIFY HERE ?
gray_break = imread('break_gray.bmp');
trial_win     = getappdata (handles.video_selection_group, 'trial_win');
Texture = Screen('MakeTexture',trial_win,gray_break);% read in the image
Screen('DrawTexture',trial_win, Texture);% Draw the image to the screen'win'
Screen('Flip',trial_win);% present to the screen
end



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over nextbutton.
function nextbutton_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to nextbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function scene_textbox_Callback(hObject, eventdata, handles)
% hObject    handle to scene_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scene_textbox as text
%        str2double(get(hObject,'String')) returns contents of scene_textbox as a double


% --- Executes during object creation, after setting all properties.
function scene_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scene_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function observer_textbox_Callback(hObject, eventdata, handles)
% hObject    handle to observer_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of observer_textbox as text
%        str2double(get(hObject,'String')) returns contents of observer_textbox as a double


% --- Executes during object creation, after setting all properties.
function observer_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to observer_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function score_textbox_Callback(hObject, eventdata, handles)
% hObject    handle to score_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of score_textbox as text
%        str2double(get(hObject,'String')) returns contents of score_textbox as a double


% --- Executes during object creation, after setting all properties.
function score_textbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score_textbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function selected_video_Callback(hObject, eventdata, handles)
% hObject    handle to selected_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selected_video as text
%        str2double(get(hObject,'String')) returns contents of selected_video as a double


% --- Executes during object creation, after setting all properties.
function selected_video_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selected_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function selected_video_2_Callback(hObject, eventdata, handles)
% hObject    handle to selected_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of selected_video as text
%        str2double(get(hObject,'String')) returns contents of selected_video as a double


% --- Executes during object creation, after setting all properties.
function selected_video_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to selected_video (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%% MODIFY HERE ? PROBABLY NOT BEING CALLED BECAUSE IT IS FOR VIDEO
% --- Executes on button press in play_button.
function play_button_Callback(hObject, eventdata, handles)
% hObject    handle to play_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

video_mapping = getappdata (handles.video_selection_group, 'video_mapping');
video_index   = getappdata (handles.video_selection_group, 'video_index');
video_list    = getappdata (handles.video_selection_group, 'video_list');

button_state = get(hObject,'Value');
if (button_state == get(hObject,'Max'))
    set(hObject,'String','Stop');

    trial_win     = getappdata (handles.video_selection_group, 'trial_win');
    movie_path    = video_list(video_mapping(video_index)).movie_path
%     [movie, movieduration, fps, imgw, imgh] = Screen('OpenMovie', trial_win, movie_path, [], [], [], [], []);
%     Screen ('PlayMovie', movie, 1, 1, 1.0);


    img = imread(movie_path);
    gray_break = imread('C:\My data\CIC2015\HDR color apearance\SAMVIQ_iTMO_CAM\SAMVIQ\stimuli\main_experiment\break_gray.bmp');
    
    movie_playing = 1;
    setappdata (handles.video_selection_group, 'movie_playing', movie_playing);
    set (handles.score_slider, 'Enable', 'off');
    set (handles.radiobuttonA, 'Enable', 'off');
    set (handles.radiobuttonB, 'Enable', 'off');
    set (handles.radiobuttonC, 'Enable', 'off');
    set (handles.radiobuttonD, 'Enable', 'off');
    set (handles.radiobuttonE, 'Enable', 'off');
    set (handles.radiobuttonF, 'Enable', 'off');
    set (handles.radiobuttonG, 'Enable', 'off');
    set (handles.radiobuttonH, 'Enable', 'off');
    set (handles.radiobuttonI, 'Enable', 'off');
%     set (handles.radiobuttonJ, 'Enable', 'off');
%     set (handles.radiobuttonK, 'Enable', 'off');
%     set (handles.radiobuttonL, 'Enable', 'off');
%     set (handles.radiobuttonM, 'Enable', 'off');
%     set (handles.radiobuttonN, 'Enable', 'off');
%     set (handles.radiobuttonO, 'Enable', 'off');
%     set (handles.radiobuttonP, 'Enable', 'off');
    set (handles.button_reference, 'Enable', 'off');
    guidata (hObject, handles);
    drawnow;
    
%     while movie_playing

%         frame = Screen('GetMovieImage', trial_win, movie);
%         if (frame <= 0)
%             break;
%         end
%         Screen('DrawTexture', trial_win, frame);
%         Screen('Flip', trial_win);
%         Screen('Close', frame);
    trial_win     = getappdata (handles.video_selection_group, 'trial_win');
    Texture = Screen('MakeTexture',trial_win,gray_break);% read in the image
    Screen('DrawTexture',trial_win, Texture);% Draw the image to the screen'win'
    Screen('Flip',trial_win);% present to the screen
    WaitSecs(1);

    Texture = Screen('MakeTexture',trial_win, img);% read in the image
    Screen('DrawTexture',trial_win, Texture);% Draw the image to the screen'win'
    Screen('Flip',trial_win);% pr

%     movie_playing = getappdata (handles.video_selection_group, 'movie_playing');
%     end

%     Screen ('PlayMovie', movie, 0);
%     Screen ('CloseMovie', movie);
    set(hObject,'String','Play');
    set (handles.score_slider, 'Enable', 'on');
    set (handles.radiobuttonA, 'Enable', 'on');
    set (handles.radiobuttonB, 'Enable', 'on');
    set (handles.radiobuttonC, 'Enable', 'on');
    set (handles.radiobuttonD, 'Enable', 'on');
    % set (handles.radiobuttonE, 'Enable', 'on');
    % set (handles.radiobuttonF, 'Enable', 'on');
    % set (handles.radiobuttonG, 'Enable', 'on');
    % set (handles.radiobuttonH, 'Enable', 'on');
    % set (handles.radiobuttonI, 'Enable', 'on');
%     set (handles.radiobuttonJ, 'Enable', 'on');
%     set (handles.radiobuttonK, 'Enable', 'on');
%     set (handles.radiobuttonL, 'Enable', 'on');
%     set (handles.radiobuttonM, 'Enable', 'on');
%     set (handles.radiobuttonN, 'Enable', 'on');
%     set (handles.radiobuttonO, 'Enable', 'on');
%     set (handles.radiobuttonP, 'Enable', 'on');
    % set (handles.button_reference, 'Enable', 'on');
    scene_done = getappdata (handles.video_selection_group, 'scene_done');
    if scene_done
        set (handles.nextbutton, 'Enable', 'on');
    end
    guidata (hObject, handles);

elseif (button_state == get(hObject,'Min'))

    movie_playing = 0;
    setappdata (handles.video_selection_group, 'movie_playing', movie_playing);

end

function scoreA_Callback(hObject, eventdata, handles)
% hObject    handle to scoreA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreA as text
%        str2double(get(hObject,'String')) returns contents of scoreA as a double


% --- Executes during object creation, after setting all properties.
function scoreA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function score_reference_Callback(hObject, eventdata, handles)
% hObject    handle to score_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of score_reference as text
%        str2double(get(hObject,'String')) returns contents of score_reference as a double


% --- Executes during object creation, after setting all properties.
function score_reference_CreateFcn(hObject, eventdata, handles)
% hObject    handle to score_reference (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreB_Callback(hObject, eventdata, handles)
% hObject    handle to scoreB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreB as text
%        str2double(get(hObject,'String')) returns contents of scoreB as a double


% --- Executes during object creation, after setting all properties.
function scoreB_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreB (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreC_Callback(hObject, eventdata, handles)
% hObject    handle to scoreC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreC as text
%        str2double(get(hObject,'String')) returns contents of scoreC as a double


% --- Executes during object creation, after setting all properties.
function scoreC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreD_Callback(hObject, eventdata, handles)
% hObject    handle to scoreD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreD as text
%        str2double(get(hObject,'String')) returns contents of scoreD as a double


% --- Executes during object creation, after setting all properties.
function scoreD_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreE_Callback(hObject, eventdata, handles)
% hObject    handle to scoreE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreE as text
%        str2double(get(hObject,'String')) returns contents of scoreE as a double


% --- Executes during object creation, after setting all properties.
function scoreE_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreE (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreF_Callback(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function scoreF_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreG_Callback(hObject, eventdata, handles)
% hObject    handle to scoreG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreG as text
%        str2double(get(hObject,'String')) returns contents of scoreG as a double


% --- Executes during object creation, after setting all properties.
function scoreG_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreH_Callback(hObject, eventdata, handles)
% hObject    handle to scoreH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreH as text
%        str2double(get(hObject,'String')) returns contents of scoreH as a double


% --- Executes during object creation, after setting all properties.
function scoreH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreI_Callback(hObject, eventdata, handles)
% hObject    handle to scoreI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreI as text
%        str2double(get(hObject,'String')) returns contents of scoreI as a double


% --- Executes during object creation, after setting all properties.
function scoreI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function scoreJ_Callback(hObject, eventdata, handles)
% hObject    handle to scoreJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreJ as text
%        str2double(get(hObject,'String')) returns contents of scoreJ as a double


% --- Executes during object creation, after setting all properties.
function scoreJ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreJ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreK_Callback(hObject, eventdata, handles)
% hObject    handle to scoreK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreK as text
%        str2double(get(hObject,'String')) returns contents of scoreK as a double


% --- Executes during object creation, after setting all properties.
function scoreK_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreK (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreL_Callback(hObject, eventdata, handles)
% hObject    handle to scoreL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreL as text
%        str2double(get(hObject,'String')) returns contents of scoreL as a double


% --- Executes during object creation, after setting all properties.
function scoreL_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreL (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreM_Callback(hObject, eventdata, handles)
% hObject    handle to scoreM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreM as text
%        str2double(get(hObject,'String')) returns contents of scoreM as a double


% --- Executes during object creation, after setting all properties.
function scoreM_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreN_Callback(hObject, eventdata, handles)
% hObject    handle to scoreN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreN as text
%        str2double(get(hObject,'String')) returns contents of scoreN as a double


% --- Executes during object creation, after setting all properties.
function scoreN_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreO_Callback(hObject, eventdata, handles)
% hObject    handle to scoreO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreO as text
%        str2double(get(hObject,'String')) returns contents of scoreO as a double


% --- Executes during object creation, after setting all properties.
function scoreO_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreO (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function scoreP_Callback(hObject, eventdata, handles)
% hObject    handle to scoreP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of scoreP as text
%        str2double(get(hObject,'String')) returns contents of scoreP as a double


% --- Executes during object creation, after setting all properties.
function scoreP_CreateFcn(hObject, eventdata, handles)
% hObject    handle to scoreP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%%% IMPORTANT TO DISPLAY IMAGES %%%
%%% MODIFIED HERE %%%

% --- Executes when selected object is changed in video_selection_group.
function video_selection_group_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in video_selection_group 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)

switch get(eventdata.NewValue,'Tag') % Get Tag of selected object.
    case 'button_reference'
        video_index = 5;
        set(handles.selected_video,'String','Reference');
        set(handles.selected_video_2,'String','Reference');
        setappdata(handles.video_selection_group,'video_index',video_index);
        display_img(hObject, eventdata, handles)
        set (handles.score_slider,'Enable', 'off');
    case 'radiobuttonA'
        video_index = 1;
        set(handles.selected_video,'String','A');
        set(handles.selected_video_2,'String','A');
        setappdata(handles.video_selection_group,'video_index',video_index);
        movie_list = getappdata(handles.video_selection_group,'movie_list');
        display_img(hObject, eventdata, handles)
        set (handles.score_slider,'Enable', 'on');
    case 'radiobuttonB'
        video_index = 2;
        set(handles.selected_video,'String','B');
        set(handles.selected_video_2,'String','B');
        setappdata(handles.video_selection_group,'video_index',video_index);
        movie_list = getappdata(handles.video_selection_group,'movie_list');
        display_img(hObject, eventdata, handles)
        set (handles.score_slider,'Enable', 'on');
    case 'radiobuttonC'
        video_index = 3;
        set(handles.selected_video,'String','C');
        set(handles.selected_video_2,'String','C');
        setappdata(handles.video_selection_group,'video_index',video_index);
        movie_list = getappdata(handles.video_selection_group,'movie_list');
        display_img(hObject, eventdata, handles)
        set (handles.score_slider,'Enable', 'on');
    case 'radiobuttonD'
        video_index = 4;
        set(handles.selected_video,'String','D');
        set(handles.selected_video_2,'String','D');
        setappdata(handles.video_selection_group,'video_index',video_index);
        movie_list = getappdata(handles.video_selection_group,'movie_list');
        display_img(hObject, eventdata, handles)
        set (handles.score_slider,'Enable', 'on');
    % case 'radiobuttonE'
    %     video_index = 5;
    %     set(handles.selected_video,'String','E');
    %     set(handles.selected_video_2,'String','E');
    %     setappdata(handles.video_selection_group,'video_index',video_index);
    %     movie_list = getappdata(handles.video_selection_group,'movie_list');
    %     display_img(hObject, eventdata, handles)
    %     set (handles.score_slider,'Enable', 'on');
    % case 'radiobuttonF'
    %     video_index = 6;
    %     set(handles.selected_video,'String','F');
    %     set(handles.selected_video_2,'String','F');
    %     setappdata(handles.video_selection_group,'video_index',video_index);
    %     movie_list = getappdata(handles.video_selection_group,'movie_list');
    %     display_img(hObject, eventdata, handles)
    %     set (handles.score_slider,'Enable', 'on');
    % case 'radiobuttonG'
    %     video_index = 7;
    %     set(handles.selected_video,'String','G');
    %     set(handles.selected_video_2,'String','G');
    %     setappdata(handles.video_selection_group,'video_index',video_index);
    %     movie_list = getappdata(handles.video_selection_group,'movie_list');
    %     display_img(hObject, eventdata, handles)
    %     set (handles.score_slider,'Enable', 'on');
    % case 'radiobuttonH'
    %     video_index = 8;
    %     set(handles.selected_video,'String','H');
    %     set(handles.selected_video_2,'String','H');
    %     setappdata(handles.video_selection_group,'video_index',video_index);
    %     movie_list = getappdata(handles.video_selection_group,'movie_list');
    %     display_img(hObject, eventdata, handles)
    %     set (handles.score_slider,'Enable', 'on');
    % case 'radiobuttonI'
    %     video_index = 9;
    %     set(handles.selected_video,'String','I');
    %     set(handles.selected_video_2,'String','I');
    %     setappdata(handles.video_selection_group,'video_index',video_index);
    %     movie_list = getappdata(handles.video_selection_group,'movie_list');
    %     display_img(hObject, eventdata, handles)
    %     set (handles.score_slider,'Enable', 'on');
%     case 'radiobuttonJ'
%         video_index = 10;
%         set(handles.selected_video,'String','J');
%         set(handles.selected_video_2,'String','J');
%     case 'radiobuttonK'
%         video_index = 11;
%         set(handles.selected_video,'String','K');
%         set(handles.selected_video_2,'String','K');
%     case 'radiobuttonL'
%         video_index = 12;
%         set(handles.selected_video,'String','L');
%         set(handles.selected_video_2,'String','L');
%     case 'radiobuttonM'
%         video_index = 13;
%         set(handles.selected_video,'String','M');
%         set(handles.selected_video_2,'String','M');
%     case 'radiobuttonN'
%         video_index = 14;
%         set(handles.selected_video,'String','N');
%         set(handles.selected_video_2,'String','N');
%     case 'radiobuttonO'
%         video_index = 15;
%         set(handles.selected_video,'String','O');
%         set(handles.selected_video_2,'String','O');
%     case 'radiobuttonP'
%         video_index = 16;
%         set(handles.selected_video,'String','P');
%         set(handles.selected_video_2,'String','P');
    otherwise
        video_index = 5;
        set(handles.selected_video,'String','Reference');
        set(handles.selected_video_2,'String','Reference');
end

% setappdata(handles.video_selection_group,'video_index',video_index);
% movie_list = getappdata(handles.video_selection_group,'movie_list');

%%% MODIFIED HERE %%%

%
% Our own GUI and Psychtoolbox initialisation
%
function init_gui_logic (hObject, handles)

% Indicate here which scenes we're using. See samviq_prepare_videos.m for
% information as to which scenes these are, and where they are located on
% disk. Also set the number of scenes to match scenes_present.

%%% MODIFIED HERE %%%
%%% MODIFY NUMBER OF SCENES %%%
scenes_present  = [1, 2]; 
num_scenes      = 2;

num_stimuli     = 4;

video_mapping = randperm (num_stimuli);
all_scores    = zeros (num_stimuli,1) - 1;
scene_done    = 0;

setappdata (handles.video_selection_group, 'video_mapping', video_mapping);
setappdata (handles.video_selection_group, 'all_scores', all_scores);
setappdata (handles.video_selection_group, 'scene_done', scene_done);

%%% MODIFIED HERE %%%

% Assume that video number 16 is the reference video. To be checked!!!
ref_video = num_stimuli;
setappdata (handles.video_selection_group, 'video_index', ref_video);

% No advancing to the next scene until everything is scored!
set (handles.nextbutton,'Enable','off');
set (handles.play_button,'visible','off');

set (handles.scoreE,'visible','off');
set (handles.scoreF,'visible','off');
set (handles.scoreG,'visible','off');
set (handles.scoreH,'visible','off');
set (handles.scoreI,'visible','off');

set (handles.scoreJ,'visible','off');
set (handles.scoreK,'visible','off');
set (handles.scoreL,'visible','off');
set (handles.scoreM,'visible','off');
set (handles.scoreN,'visible','off');
set (handles.scoreO,'visible','off');
set (handles.scoreP,'visible','off');

set (handles.score_reference,'visible','off');

set (handles.radiobuttonE, 'visible', 'off');
set (handles.radiobuttonF, 'visible', 'off');
set (handles.radiobuttonG, 'visible', 'off');
set (handles.radiobuttonH, 'visible', 'off');
set (handles.radiobuttonI, 'visible', 'off');

set (handles.radiobuttonJ, 'visible', 'off');
set (handles.radiobuttonK, 'visible', 'off');
set (handles.radiobuttonL, 'visible', 'off');
set (handles.radiobuttonM, 'visible', 'off');
set (handles.radiobuttonN, 'visible', 'off');
set (handles.radiobuttonO, 'visible', 'off');
set (handles.radiobuttonP, 'visible', 'off');
% set (handles.score_slider, 'visible', 'off');
% set (handles.selected_video_2, 'visible', 'off');
set (handles.score_slider,'Enable', 'off');
% Video / psychtoolbox setup
trial_win     = samviq_video_setup ();
setappdata (handles.video_selection_group, 'trial_win', trial_win);

% Randomize the order of the scenes, then pick the first
scene_mapping = randperm (num_scenes);
current_scene = 1;
video_list    = samviq_prepare_videos (trial_win, scenes_present(scene_mapping(current_scene)), video_mapping);
set (handles.scene_textbox, 'String', video_list(1).movie_name);
setappdata (handles.video_selection_group, 'scenes_present', scenes_present);
setappdata (handles.video_selection_group, ['scene_ma' ...
    'pping'], scene_mapping);
setappdata (handles.video_selection_group, 'current_scene', current_scene);
setappdata (handles.video_selection_group, 'video_list',    video_list);

% Some statistics from the participant
prompt = {'Enter your name:','Enter your age:' 'Enter your gender:'};
answer = inputdlg(prompt,'Observer information',[1 50]);
setappdata (handles.video_selection_group, 'observer', answer(1));
setappdata (handles.video_selection_group, 'age', answer(2));
setappdata (handles.video_selection_group, 'gender', answer(3));
setappdata (handles.video_selection_group, 'start_time', clock);
set (handles.observer_textbox, 'String', answer(1));


