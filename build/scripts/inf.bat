@rem
@rem Copyright 2015 the original author or authors.
@rem
@rem Licensed under the Apache License, Version 2.0 (the "License");
@rem you may not use this file except in compliance with the License.
@rem You may obtain a copy of the License at
@rem
@rem      https://www.apache.org/licenses/LICENSE-2.0
@rem
@rem Unless required by applicable law or agreed to in writing, software
@rem distributed under the License is distributed on an "AS IS" BASIS,
@rem WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
@rem See the License for the specific language governing permissions and
@rem limitations under the License.
@rem

@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  inf startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Resolve any "." and ".." in APP_HOME to make it shorter.
for %%i in ("%APP_HOME%") do set APP_HOME=%%~fi

@rem Add default JVM options here. You can also use JAVA_OPTS and INF_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto execute

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto execute

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\inf-0.0.1-SNAPSHOT-plain.jar;%APP_HOME%\lib\aws-ai-0.12.0.jar;%APP_HOME%\lib\pytorch-engine-0.12.0.jar;%APP_HOME%\lib\api-0.12.0.jar;%APP_HOME%\lib\spring-boot-starter-web-2.5.3.jar;%APP_HOME%\lib\spring-boot-starter-log4j2-2.5.3.jar;%APP_HOME%\lib\aws-java-sdk-s3-1.12.15.jar;%APP_HOME%\lib\pytorch-native-cpu-precxx11-1.8.1-linux-x86_64.jar;%APP_HOME%\lib\log4j-slf4j-impl-2.13.3.jar;%APP_HOME%\lib\s3-2.15.79.jar;%APP_HOME%\lib\sagemaker-2.15.79.jar;%APP_HOME%\lib\sagemakerruntime-2.15.79.jar;%APP_HOME%\lib\iam-2.15.79.jar;%APP_HOME%\lib\sts-2.15.79.jar;%APP_HOME%\lib\spring-boot-starter-json-2.5.3.jar;%APP_HOME%\lib\spring-boot-starter-2.5.3.jar;%APP_HOME%\lib\spring-boot-starter-tomcat-2.5.3.jar;%APP_HOME%\lib\spring-webmvc-5.3.9.jar;%APP_HOME%\lib\spring-web-5.3.9.jar;%APP_HOME%\lib\log4j-core-2.14.1.jar;%APP_HOME%\lib\log4j-jul-2.14.1.jar;%APP_HOME%\lib\jul-to-slf4j-1.7.32.jar;%APP_HOME%\lib\aws-java-sdk-kms-1.12.15.jar;%APP_HOME%\lib\aws-java-sdk-core-1.12.15.jar;%APP_HOME%\lib\jmespath-java-1.12.15.jar;%APP_HOME%\lib\aws-xml-protocol-2.15.79.jar;%APP_HOME%\lib\aws-json-protocol-2.15.79.jar;%APP_HOME%\lib\aws-query-protocol-2.15.79.jar;%APP_HOME%\lib\protocol-core-2.15.79.jar;%APP_HOME%\lib\aws-core-2.15.79.jar;%APP_HOME%\lib\auth-2.15.79.jar;%APP_HOME%\lib\regions-2.15.79.jar;%APP_HOME%\lib\sdk-core-2.15.79.jar;%APP_HOME%\lib\arns-2.15.79.jar;%APP_HOME%\lib\profiles-2.15.79.jar;%APP_HOME%\lib\apache-client-2.15.79.jar;%APP_HOME%\lib\netty-nio-client-2.15.79.jar;%APP_HOME%\lib\http-client-spi-2.15.79.jar;%APP_HOME%\lib\metrics-spi-2.15.79.jar;%APP_HOME%\lib\utils-2.15.79.jar;%APP_HOME%\lib\slf4j-api-1.7.32.jar;%APP_HOME%\lib\log4j-api-2.14.1.jar;%APP_HOME%\lib\gson-2.8.7.jar;%APP_HOME%\lib\jna-5.8.0.jar;%APP_HOME%\lib\commons-compress-1.20.jar;%APP_HOME%\lib\annotations-2.15.79.jar;%APP_HOME%\lib\spring-boot-autoconfigure-2.5.3.jar;%APP_HOME%\lib\spring-boot-2.5.3.jar;%APP_HOME%\lib\jakarta.annotation-api-1.3.5.jar;%APP_HOME%\lib\spring-context-5.3.9.jar;%APP_HOME%\lib\spring-aop-5.3.9.jar;%APP_HOME%\lib\spring-beans-5.3.9.jar;%APP_HOME%\lib\spring-expression-5.3.9.jar;%APP_HOME%\lib\spring-core-5.3.9.jar;%APP_HOME%\lib\snakeyaml-1.28.jar;%APP_HOME%\lib\jackson-datatype-jsr310-2.12.4.jar;%APP_HOME%\lib\jackson-module-parameter-names-2.12.4.jar;%APP_HOME%\lib\jackson-dataformat-cbor-2.12.4.jar;%APP_HOME%\lib\jackson-core-2.12.4.jar;%APP_HOME%\lib\jackson-annotations-2.12.4.jar;%APP_HOME%\lib\jackson-datatype-jdk8-2.12.4.jar;%APP_HOME%\lib\jackson-databind-2.12.4.jar;%APP_HOME%\lib\tomcat-embed-websocket-9.0.50.jar;%APP_HOME%\lib\tomcat-embed-core-9.0.50.jar;%APP_HOME%\lib\tomcat-embed-el-9.0.50.jar;%APP_HOME%\lib\httpclient-4.5.13.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\commons-codec-1.15.jar;%APP_HOME%\lib\ion-java-1.0.2.jar;%APP_HOME%\lib\joda-time-2.8.1.jar;%APP_HOME%\lib\netty-reactive-streams-http-2.0.4.jar;%APP_HOME%\lib\netty-reactive-streams-2.0.4.jar;%APP_HOME%\lib\reactive-streams-1.0.3.jar;%APP_HOME%\lib\eventstream-1.0.1.jar;%APP_HOME%\lib\httpcore-4.4.14.jar;%APP_HOME%\lib\netty-codec-http2-4.1.66.Final.jar;%APP_HOME%\lib\netty-codec-http-4.1.66.Final.jar;%APP_HOME%\lib\netty-handler-4.1.66.Final.jar;%APP_HOME%\lib\netty-codec-4.1.66.Final.jar;%APP_HOME%\lib\netty-transport-native-epoll-4.1.66.Final-linux-x86_64.jar;%APP_HOME%\lib\netty-transport-native-unix-common-4.1.66.Final.jar;%APP_HOME%\lib\netty-transport-4.1.66.Final.jar;%APP_HOME%\lib\netty-buffer-4.1.66.Final.jar;%APP_HOME%\lib\netty-resolver-4.1.66.Final.jar;%APP_HOME%\lib\netty-common-4.1.66.Final.jar;%APP_HOME%\lib\spring-jcl-5.3.9.jar


@rem Execute inf
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %INF_OPTS%  -classpath "%CLASSPATH%"  %*

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable INF_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%INF_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
