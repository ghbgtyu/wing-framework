@echo off
echo ����ѡ��dev china tw dama korea thai indone test Turkey us viet brz france germany viet2 spa zhanshen
set /p var=������: 
echo �������Ϊ%var%   
cmd /k mvn  clean package -Dmaven.test.skip=true -P%var%
pause