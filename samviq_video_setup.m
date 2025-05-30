function trial_win = samviq_video_setup()

    PsychDefaultSetup(2);
    ClockRandSeed();

    % Get available screens
    SCREENS = Screen('Screens');
    nscreen = length(SCREENS);  % Number of screens

    % Set Psychtoolbox preferences
    Screen('Preference', 'SkipSyncTests', 1);
    Screen('Preference', 'VisualDebugLevel', 0);
    Screen('Preference', 'ConserveVRAM', 32);
    Screen('Preference', 'SuppressAllWarnings', 1);

    % Define windowed mode rectangle [left, top, right, bottom]
    % Example: 800x600 window, positioned 100 pixels from top-left
    windowRect = [100, 100, 900, 700];  % [left, top, right, bottom]

    if nscreen > 1
        % Primary screen (index 0) for GUI, secondary screen (index 1) for trials
        Stext = min(SCREENS);  % Primary screen (index 0)
        Strials = SCREENS(2);  % Secondary screen (index 1)

        PsychImaging('PrepareConfiguration');
        PsychImaging('AddTask', 'General', 'EnableHDR', 'Nits', 'HDR10');
        trial_win = PsychImaging('OpenWindow', Strials);
        Screen('Flip', trial_win);
    else
        % Single screen: Use the only available screen for both GUI and trials
        Stext = min(SCREENS);
        Strials = Stext;
        trial_win = Screen('OpenWindow', Strials, [], windowRect);
        Screen('Flip', trial_win);
        warning('Only one screen detected. GUI and images will appear on the same screen.');
    end

    % Return the trial window
end