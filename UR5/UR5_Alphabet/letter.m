classdef letter
    properties
        %storing object values, including dimensional data that will be
        %used by the 'phrase' class to determine the coordinates and
        %positioning of each letter in the phrase.
        char;
        points;
        lowerRatio;
    end
    methods
        function obj = letter(char,ratio)
            %LETTER Construct an instance of this class
            obj.char = char;
            obj.lowerRatio = ratio;
            %call function to populate the points field
            obj = obj.writeLetter();
        end
        % write diffenent letter, the orginal all locates at the
        % left-buttom corner!!!
        function obj = writeLetter(obj)
            %all letters written in a 2X2 box scaled by ratio
            %all letters start at the left buttom origin
            %up, down and finish a signal not real points.
            up = [-1 -1 -1]; down = [-2 -2 -2]; finish = [-3 -3 -3];
            ratio = obj.lowerRatio;
            if obj.char == 'A'
                output = [];
                
                start = [1,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,0];down]; 
                
                start = [1,2,0]; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1/2,1,0];down];
                
                start = [1/2,1,0]; endpoint = [3/2,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
    
            if obj.char == 'B'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,2,1];down]; % return to start point
                
                start = [0,2,0]; endpoint = [0,3/2,0]; length = -pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;ratio*[0,1,1];down];
                
                start = [0,1,0]; endpoint = [0,1/2,0]; length = -pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'C'
                output = [];
                
                start = [1,2,0]; endpoint = [1,1,0]; length = pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'D'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,2,0];down]; 
                
                start = [0,2,0]; endpoint = [0,1,0]; length = -pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'E'
                output = [];
                
                start = [1,2,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)]; 
               
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,0,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,1,0];down];
                
                start = [0,1,0]; endpoint = [1,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'F'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,2,1];down]; 
                
                start = [0,2,0]; endpoint = [1,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,1,1];down];
                
                start = [0,1,0]; endpoint = [1,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'G'
                output = [];
                
                start = [1,2,0]; endpoint = [1,1,0]; length = 3/2*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;ratio*[1,1,1];down]; 
                
                start = endpoint; endpoint = [2,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = endpoint; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'H'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,1];down]; 
                
                start = [1,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[0,1,1];down];
                
                start = [0,1,0]; endpoint = [1,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'I'
                output = [];
                
                start = [1/2,2,0]; endpoint = [3/2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,1];down]; 
                
                start = [1,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1/2,0,1];down];
                
                start = [1/2,0,0]; endpoint = [3/2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'J'
                output = [];
                
                start = [1/2,2,0]; endpoint = [3/2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,1];down]; 
                
                start = [1,2,0]; endpoint = [1,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,1,0]; endpoint = [0,1,0]; length = -pi/3;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'K'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,1];down]; 
                
                start = [1,2,0]; endpoint = [0,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];

                start = [0,1,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'L'
                output = [];
                
                start = [0,2,0]; endpoint = [0,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,0,0]; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'M'
                output = [];
                
                start = [0,0,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,0,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [2,2,0]; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
                
            if obj.char == 'N'
                output = [];
                
                start = [0,0,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,0,0]; endpoint = [1,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'O'
                output = [];
                
                start = [1,2,0]; endpoint = [1,1,0]; length = 2*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'P'
                output = [];
                
                start = [0,0,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,2,0]; endpoint = [0,3/2,0]; length = -pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'Q'
                output = [];
                
                start = [1,2,0]; endpoint = [1,1,0]; length = 2*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;ratio*[1,1,0];down];
                
                start = [1,1,0]; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'R'
                output = [];
                
                start = [0,0,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,2,0]; endpoint = [0,3/2,0]; length = -pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                start = [0,1,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'S'
                output = [];
                
                start = [1,1,0]; endpoint = [1,3/2,0]; length = -4/3*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;ratio*[1,1,0];down];
                
                start = [1,1,0]; endpoint = [1,1/2,0]; length = -4/3*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'S'
                output = [];
                
                start = [1,1,0]; endpoint = [1,3/2,0]; length = -4/3*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;ratio*[1,1,0];down];
                
                start = [1,1,0]; endpoint = [1,1/2,0]; length = -4/3*pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'T'
                output = [];
                
                start = [1/2,2,0]; endpoint = [3/2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,2,0];down];
                
                start = [1,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == 'U'
                output = [];
                
                start = [0,2,0]; endpoint = [0,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,1,0]; endpoint = [1,1,0]; length = pi;
                output = [output;arc_and_line(start,endpoint,length,1,ratio)];
                
                start = [2,1,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'V'
                output = [];
                
                start = [0,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,0,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'W'
                output = [];
                
                start = [0,2,0]; endpoint = [2/3,0,0]; length = 0;
                
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                start = [2/3,0,0]; endpoint = [1,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,2,0]; endpoint = [4/3,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [4/3,0,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'X'
                output = [];
                
                start = [0,2,0]; endpoint = [2,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;[0,0,0];down];
                
                start = [0,0,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'Y'
                output = [];
                
                start = [0,2,0]; endpoint = [1,1,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,1,0]; endpoint = [2,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;ratio*[1,1,0];down];
                
                start = [1,1,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end
            
            if obj.char == 'Z'
                output = [];
                
                start = [0,0,0]; endpoint = [0,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [0,2,0]; endpoint = [1,0,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                start = [1,0,0]; endpoint = [1,2,0]; length = 0;
                output = [output;arc_and_line(start,endpoint,length,0,ratio)];
                
                output = [output;up;finish];
            end

            if obj.char == ' '
                obj.points = [-4 -4 -4]; %space signal
            else
                obj.points = output;
            end
        end
            
    end

end
