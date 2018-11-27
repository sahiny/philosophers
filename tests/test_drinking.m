% test_drinking.m
clear;clc;close all;

a1 = agent(1);
a2 = agent(2);
a3 = agent(3);

a1.createBottle(12,a2);
a1.createBottle(21,a2);
a1.createBottle(13,a3);
a1.createBottle(31,a3);

a2.createBottle(12,a1);
a2.createBottle(21,a1);
a2.createBottle(23,a3);
a2.createBottle(32,a3);

a3.createBottle(13,a1);
a3.createBottle(31,a1);
a3.createBottle(23,a2);
a3.createBottle(32,a2);

% a1 gets thirrsty with all bottle (should be able to start drinking)
a1_session = [a1.getBottle(12, 2), a1.getBottle(21, 2),...
    a1.getBottle(13, 3),a1.getBottle(31, 3) ];
a1.becomeThirsty(a1_session);
assert(strcmp(a1.drinkingState, 'drinking'), 'a1 failed to start drinking')
a1.becomeTranquil();
% max concurency
a2_sesssion = [a2.getBottle(21, 1), a2.getBottle(23, 3)];
a2.becomeThirsty(a2_sesssion);
assert(strcmp(a2.drinkingState, 'drinking'), 'a3 failed to start drinking')

a3_session = [a3.getBottle(31, 1), a3.getBottle(32, 2)];
a3.becomeThirsty(a3_session);
assert(strcmp(a2.drinkingState, 'drinking'), 'a3 failed to start drinking')

a1_session = [a1.getBottle(12, 2),  a1.getBottle(13, 3) ];
a1.becomeThirsty(a1_session);
assert(strcmp(a1.drinkingState, 'drinking'), 'a1 failed to start drinking')
a1.becomeTranquil();
% a1 wants more
a1_session = [a1.getBottle(12, 2),  a1.getBottle(13, 3),a1.getBottle(31, 3) ];
a1.becomeThirsty(a1_session);
assert(strcmp(a1.drinkingState, 'thirsty'), 'collision a1,a3')

% a1 still thirsty
a3.becomeTranquil;
assert(strcmp(a1.drinkingState, 'drinking'), 'a1 failed to start drinking');

% a1 a2 wants the same thing, a1 should start first
a1.becomeTranquil;
a2.becomeTranquil;
a3_session = [a3.getBottle(31, 1), a3.getBottle(32, 2)];
a3.becomeThirsty(a3_session);

a1_session = [a1.getBottle(31, 3), a1.getBottle(12,2)];
a2_session = [a2.getBottle(32, 3), a2.getBottle(12,1)];

a2.becomeThirsty(a2_session);
a1.becomeThirsty(a1_session);
assert(strcmp(a1.drinkingState, 'thirsty'), 'a1 false start drinking');
assert(strcmp(a2.drinkingState, 'thirsty'), 'a2 false start drinking');

a3.becomeTranquil();
assert(strcmp(a2.drinkingState, 'drinking'), 'a2 failed to start drinking');
assert(strcmp(a1.drinkingState, 'thirsty'), 'a1 false start drinking');

a2.becomeTranquil;
