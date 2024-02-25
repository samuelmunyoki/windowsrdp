FROM mcr.microsoft.com/windows:1809-KB5034768-amd64

RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

WORKDIR /inetpub/wwwroot

COPY content/ .
