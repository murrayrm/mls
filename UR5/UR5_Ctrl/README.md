## UR5_Control
The Objective of the project is to use the UR5 robot to complete a "place-and-draw" task using inverse kinematic control
- in the test mode
When the program starts, user is prompted by the program to “teach” the robot by manually moving the end effector (EE) and marker to the start and end points. UR5 is then asked to move forward by 10cm, followed by a 5cm in the right direction, and then move to the destination.
- in the simu mode
The start and end points are hardcored.

## Inverse Kinematic Error Calc.
```
directly run .m file: 
test_ur5InvKin.m
```
```
result:
test_ur5InvKin
The Average Joint Errors are: [0.002, 0.011, 0.003, 0.008, 0.001, 0.017]
```

## recommend start position
```

q = [-90; -97.6501; -115.3289; -55.6628; 91.3168; 0]
```

## pen_tip from tool0
```

linear: [0; -0.049; 0.12228]
angular: [0; 0; 0]
```
```
test the tool0 to pen tip tranformation:
>> ur5.get_current_transformation('tool0', 'dest_point')

ans =

    1.0000    0.0001    0.0000    0.0000
   -0.0001    1.0000   -0.0001   -0.0490
   -0.0000    0.0001    1.0000    0.1222
         0         0         0    1.0000
```
## test the error of destination taught and reality moved to
```
>> abs(ge1_gt(1:3, 4) - ge1(1:3, 4))

ans =

   1.0e-03 *

    0.1886
    0.1217
    0.0182

```
