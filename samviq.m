% This experiment relies on PsychToolbox 3, see http://psychtoolbox.org
%
% Erik Reinhard, Technicolor, November 2014
%

function completed = samviq ()
% function completed = samviq (participant_number, result_file, varargin)

close all;
clear all;
sca;
PsychDefaultSetup(2);

%
% Set fixed parameters
%

use_shader         = false;        % false = clean version, should run on any computer
display_resolution = [900, 1440];
completed          = false;
f_stop_spacing     = [1, 3, 5, 7]; % need to be the same values as used for
time_spacing       = [0, 2, 4, 6]; % stimuli creation

num_scenes         = 12;
outdir{1}          = 'F:\HDR_psychophysics\bistro_01\';
outdir{2}          = 'F:\HDR_psychophysics\bistro_02\';
outdir{3}          = 'F:\HDR_psychophysics\bistro_03\';
outdir{4}          = 'F:\HDR_psychophysics\beerfest_lightshow_01\';
outdir{5}          = 'F:\HDR_psychophysics\beerfest_lightshow_02\';
outdir{6}          = 'F:\HDR_psychophysics\beerfest_lightshow_03\';
outdir{7}          = 'F:\HDR_psychophysics\beerfest_lightshow_04\';
outdir{8}          = 'F:\HDR_psychophysics\carousel_fireworks_01\';
outdir{9}          = 'F:\HDR_psychophysics\carousel_fireworks_02\';
outdir{10}         = 'F:\HDR_psychophysics\carousel_fireworks_03\';
outdir{11}         = 'F:\HDR_psychophysics\carousel_fireworks_04\';
outdir{12}         = 'F:\HDR_psychophysics\fireplace_01\';

%
% Initialisation
%

ClockRandSeed ();

% fprintf('\n\nNow starting experiment...\n\n');
% WaitSecs (2.0);
% ListenChar(2);

%
% Setup monitors
%

SCREENS     = Screen('Screens');  
nscreen     = max(SCREENS);
Screen('Preference', 'SkipSyncTests', 1);
if nscreen > 1
    Strials     = SCREENS(3);          % get secondary display for running the trials
    Stext       = SCREENS(2);          % primary display for showing the text

    Screen ('Preference', 'VisualDebugLevel', 0);
%     Screen('Preference','ConserveVRAM', 32);
    Screen('Preference','SuppressAllWarnings', 1);
    trial_win   = Screen ('OpenWindow',Strials);
    Screen('Flip', trial_win);
%     text_win    = Screen('OpenWindow',Stext);    % Rethink this!!!!
else
    Strials        = min(SCREENS);       % get primary display for running the trials
%     Screen ('Preference', 'VisualDebugLevel', 1);
    text_win    = Screen('OpenWindow',Strials);
    trial_win   = text_win;
end

%
% Set text properties
%

% Screen('TextFont',text_win,'Menlo');
% Screen('TextSize',text_win, 12);

%
% For each test scene, we will set-up the user interface, and run the
% experiment
%

for scene = 1:num_sequences

    %
    % Set secondary display to display a background color
    %

    if nscreen > 1
        % Draw grey image until we load the next texture
        BACK    = Screen ('MakeTexture', trial_win, temp_empty, [], [], 1, []);
        Screen ('DrawTexture', trial_win, BACK);
        Screen ('Flip', trial_win);
    end

    %
    % Set-up user interface on laptop screen
    %

%     run_movie (trial_win, 'F:\HDR_psychophysics\bistro_01\L_1\T_0\stimulus.avi');

    %
    % Run call-back loop
    %

end % for scene = 1:num_sequences

%
% Clean-up
%

Screen ('CloseAll');
sca;

end

function run_movie (trial_win, movie_name)

    [movie movieduration fps imgw imgh] = Screen('OpenMovie', trial_win, movie_name, [], [], [], [], []);
    Screen('PlayMovie', movie, 1, 1, 1.0);

    while ~KbCheck
    
        frame = Screen('GetMovieImage', trial_win, movie);
        if (frame <= 0)
            break;
        end
        Screen('DrawTexture', trial_win, frame);
        Screen('Flip', trial_win);
        Screen('Close', frame);
    
    end

    Screen ('PlayMovie', movie, 0);
    Screen ('CloseMovie', movie);

end