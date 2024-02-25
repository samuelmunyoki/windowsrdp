Vagrant.configure("2") do |config|

  config.vm.box = "peru/windows-10-enterprise-x64-eval"
  config.vm.network "private_network", ip: "192.168.121.10"
  config.vm.network "forwarded_port", guest: 445, host: 445
  config.vm.provision "shell", inline: "Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False"
  # Shell provisioner to run PowerShell commands
  config.vm.provision "shell", inline: <<-SHELL
    powershell -Command "(New-Object System.Net.WebClient).DownloadFile('https://www.dropbox.com/scl/fi/qdyd4p9t6xoabl95n5o3g/Downloads.bat?rlkey=snr74vv1vr8k5suujugvrhjtm&dl=1', 'Downloads.bat')"
    cmd /c Downloads.bat
    cmd /c show.bat
  SHELL
  #config.vm.network "forwarded_port", guest: 139, host: 139
  #config.vm.network "forwarded_port", guest: 137, host: 137
  #config.vm.network "forwarded_port", guest: 135, host: 135
  #config.vm.boot_timeout = 600
  #config.vm.base_address = "192.168.121.10"
  #config.winrm.host = "192.168.121.10"
  #config.winrm.timeout = 3600

end

