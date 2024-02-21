%% matlab test file
ur5 = ur5_interface();
K = 0.75; %RR_control gain
signal = 0;

%% initalization
% the start point should be at left_buttom 
while signal == 0
    prompt = "Is this the initial writing position? 1 or 0: ";
    X = input(prompt);
    if X == 1
        signal = 1;
        left_start = ur5.get_current_joints(); % get first written location
        disp('initial position recorded!');
    end
end
signal = 0;

% the end point should be at right_buttom 
while signal == 0
    prompt = "Is this the final writing position? 1 or 0: ";
    X = input(prompt);
    if X == 1
        signal = 1;
        right_end = ur5.get_current_joints(); % get final written location
        disp('final position recorded!');
    end
end


Word = alphabet('RDKDC',ur5,K,left_start,right_end); %any word is ok
Word.draw('mplot'); %used in simulation

