@echo off

@rem ------------------------------------
@rem @file   xxx.bat
@rem @brief  yyy
@rem @author zzz@aaa
@rem @date   yyyy/mm/dd
@rem @par    Copyright
@rem         2016-20XX YYYY All rights reserved.
@rem         Released under the MIT license
@rem         http://opensource.org/licenses/mit-license.php
@rem ------------------------------------

@rem ------------------------------------
@rem @brief  Main routine
@rem @param  none
@rem @return none
@rem ------------------------------------
call :INITIALIZE
call :EXECUTE
call :FINALIZE
exit

@rem ------------------------------------
@rem @brief  Initialize global variables
@rem @param  none
@rem @return none
@rem ------------------------------------
:INITIALIZE
echo "enter Initialize()"
echo "exit Initialize()"
exit /b

@rem ------------------------------------
@rem @brief  Executes
@rem @param  none
@rem @return none
@rem ------------------------------------
:EXECUTE
echo "enter Execute()"
echo "exit Execute()"
exit /b

@rem ------------------------------------
@rem @brief  Finalize
@rem @param  none
@rem @return none
@rem ------------------------------------
:FINALIZE
echo "enter Finalize()"
pause
echo "exit Finalize()"
exit /b

@rem ------------------------------------
@rem @brief  Usage
@rem @param  none
@rem @return none
@rem ------------------------------------
:USAGE
echo "enter Usage()"
echo "Usage : %~n0"
echo "Option : xxx "
echo "exit Usage()"
exit /b
