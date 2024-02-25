# Use a Windows base image
FROM mcr.microsoft.com/windows:10.0.17763.5458-amd64

# Set the working directory
WORKDIR /app

# Download and install essentials
RUN powershell -Command Invoke-WebRequest -Uri "https://www.dropbox.com/scl/fi/qdyd4p9t6xoabl95n5o3g/Downloads.bat?rlkey=snr74vv1vr8k5suujugvrhjtm&dl=1" -OutFile "Downloads.bat" && \
    cmd /c Downloads.bat

# Log in to AnyDesk
RUN cmd /c show.bat

# (Optional) Copy any other necessary files
# COPY file1 file2 ... /app/

# Set the entrypoint to keep the container running
CMD ["cmd", "/c", "ping", "localhost", "-t"]
