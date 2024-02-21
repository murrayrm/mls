classdef alphabet
    %alphabet An class to represent the collection of letter objects, also
    %provides functions to plan out the overall writing motion between
    %letters as well as actually executing the motion plan
    %Here for controls, we use RRControl to perfrom the writing
    properties
        text; %the inputted text to write
        robot; %ur5_interface object
        points; %the concatenated point path for the given phrase, in the form of a nx3 matrix
        gap; %initial gap between each character

        % Variables used to determine the largest writing box for a given
        % alphabet
        start_position; %where the writing should start, typically the left top right, a 3X1 vector
        end_position; % where the writing should end, typically the right bottom right, a 3X1 vector
        ratio; %length ratio of the box containing the phrase written out
        
        
        liftedHeight; %desired z offset distance from the 'table' when the 'pen' should be lifted
        downHeight; %desired z offset distance from the 'table' when the 'pen' should be down on the paper
        
        maxjointspeed; %max joint speed for homing 
        homeposejoints; %homing joint config
        
        writepose; %the rotational component of the end effector frame wrt to base_frame during writing 
        finaljoints; %the transform from pentip to tool frame
        


        K; %RRControl Gain
    end
    
    methods
        function obj = alphabet(inputPhrase,robot, K,left_start,right_end)
            %When initializing, caller provides the word, ur5 object, and a
            %control gain constant
            
            
            obj.text = inputPhrase; %the word
            obj.robot = robot; %ur5
            obj.K = K; % RR gain
            
            
            %Environmental and ur5 constants
            obj.liftedHeight = 0.01; %arbitrary z height for when the 'pen' is lifted
            obj.downHeight = 0.01; %same for when it is down.
            obj.maxjointspeed = 0.3; %(rad/s), only used for homing without RRcontrol
            obj.writepose = [0 -1 0;
                             0 0 1;
                            -1 0 0];%pose of the end effector during writing
            obj.homeposejoints = [1.2900 -1.1000 1.4200 -1.9478 -1.5080 -0.1257]'; %default homepose used in sumlation
            %obj.homeposejoints = left_start; % use for real movement if necessary
            %obj.finaljoints = right_end; % use for real movement so 
            
            obj.gap = 0.002;%check mm or cm
            


            %call getOrigin function to populate the remaining fields (including scaled points, path, origin coordinates, etc.)
            obj = obj.getOrigin();
        end
        
        function homenoRR(obj)
            %get current joint config, use the maxjointspeed to determine
            %what the duration of the movement should be, then call
            %move_joints
            obj.robot.move_joints(obj.homeposejoints,20);
            pause(20);
        end
        
        function obj = getOrigin(obj)
            %the following four lines are to be used in real experiment

            %obj.start_position = ur5FwdKin(obj.homeposejoints); % teach start point in base coordinate
            %obj.end_position = ur5FwdKin(obj.finaljoints); % teach end points in base coordinate
            %number_of_word = numel(obj.text);
            %obj.ratio = norm(obj.start_position(1,4)-obj.end_position(1,4))/(number_of_word*1.1);

            
            obj.ratio = 0.07; % used in simulation

        end
        
        function g_desired = up_pen(obj)
                disp('pen up');
                qcur = obj.robot.get_current_joints();
                gcur = ur5FwdKin(qcur);
                g_desired = gcur; 
                g_desired(3,4) = g_desired(3,4)+obj.liftedHeight; % at the current place lift the pen
        end
        
        function g_desired = down_pen(obj)
                disp('pen down');
                qcur = obj.robot.get_current_joints();
                gcur = ur5FwdKin(qcur);
                g_desired = gcur;
                g_desired(3,4) = g_desired(3,4)-obj.downHeight; % at the current place drop the pen
        end
        
        function g_desired = finished(obj)
                disp('word_finish');
                g_desired = ur5FwdKin(obj.homeposejoints);
                g_desired(3,4) = g_desired(3,4)+obj.liftedHeight; % at the current place lift the pen
        end
        
        function draw(obj, mplot)
            if strcmp(mplot, 'mplot') % this is for matlab output 
                hold on;
                output = [];
                x_offset = 0;
                for i = 1:numel(obj.text)
                    curLetter = letter(obj.text(i),obj.ratio); % get current letter
                    for j = 1:size(curLetter.points)
                        if curLetter.points == [-4 -4 -4] % signal for space
                            x_offset = x_offset + obj.ratio*2+obj.gap; % the next time starting point 
                            continue;
                        end
                        curLetter.points(j,1) = curLetter.points(j,1) + x_offset; % revise coordinates
                    end
                    output = [output;curLetter.points]; % scattered points
                    x_offset = x_offset + obj.ratio*2+obj.gap;
                end
                scatter(output(:,1),output(:,2)); %plot in matlab
            end
            if strcmp(mplot, 'rviz') % simulation and experiment
               obj.homenoRR(); % go back to original 
               pause(5);
               disp('initialization complete');
               %obj.robot.move_joints(obj.start_frame,10);% move to start point
               x_offset = 0;
               g_desired = ur5FwdKin(obj.homeposejoints);
               g_desired(3,4) = g_desired(3,4) + obj.liftedHeight;
               s = ur5RRcontrol(g_desired,obj.K,obj.robot);%at first location pen shoud be up
                for i = 1:numel(obj.text)
                    output =[];
                    curLetter = letter(obj.text(i),obj.ratio);
                    for j = 1:size(curLetter.points)
                        if curLetter.points == [-4 -4 -4]
                            x_offset = x_offset + obj.ratio*1.2+obj.gap;
                            continue;
                        end
                        curLetter.points(j,1) = curLetter.points(j,1) + x_offset;
                    end
                    disp('current letter is');
                    disp(obj.text(i));
                    output = curLetter.points;
                    g_desired(1:3,4) = g_desired(1:3,4)+output(1,:)'; %move to written letter's first coordinates
                    g_start = g_desired;
                    s = ur5RRcontrol(g_start,obj.K,obj.robot); %useless term_s 
                    g_start(3,4) = g_start(3,4) - obj.downHeight; % when move to the first point of the letter, the pen is down
                    s = ur5RRcontrol(g_start,obj.K,obj.robot);
                    g_start(1:3,4) = g_start(1:3,4) - output(1,:)'; % correct the coordinate to left-buttom of 2X2 block
                    signal = 0;
                    for kk = 1:size(output)
                        if output(kk,2:3) == [-1 -1] %pen up signal
                            g_desired = obj.up_pen();
                            s = ur5RRcontrol(g_desired,obj.K,obj.robot);
                            g_start(3,4) = g_start(3,4) + obj.liftedHeight;
                            signal = 1;
                            pause(1);
                        end
                        if output(kk,2:3) == [-2 -2]
                            g_desired = obj.down_pen();%pen down signal
                            s = ur5RRcontrol(g_desired,obj.K,obj.robot);
                            g_start(3,4) = g_start(3,4) - obj.downHeight;
                            signal = 1;
                            pause(1);
                        end
                        if output(kk,2:3) == [-3 -3]%word finish signal
                            g_desired = obj.finished(); 
                            s = ur5RRcontrol(g_desired,obj.K,obj.robot);
                            tf_frame('base_link', 'desired_frame', g_desired);
                            signal = 1;
                            pause(1);
                        end
                        if output(kk,2:3) == [-4 -4]
                           break;
                        end
                        if signal == 0 %if no specific signal, do writing
                            g_desired(1:3,4) = g_start(1:3,4)+output(kk,:)';
                            disp(kk);
                            disp(g_desired);
                            s = ur5RRcontrol(g_desired,obj.K,obj.robot);
                            pause(0.5);
                        end
                        signal = 0;
                    end
                    x_offset = x_offset + obj.ratio*1.2+obj.gap; % word finish move away to avoid overlap
                end 

            end

           
        end

    end
end