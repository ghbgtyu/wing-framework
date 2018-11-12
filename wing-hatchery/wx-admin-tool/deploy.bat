@echo off
echo 输入选项dev china tw dama korea thai indone test Turkey us viet brz france germany viet2 spa zhanshen
set /p var=请输入: 
echo 您输入的为%var%   
cmd /k mvn  clean package -Dmaven.test.skip=true -P%var%
pause