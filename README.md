# VSCode Assembly Debugging with UCDavis CSIF 

Debug your assembly code remotely on CSIF with VS Code on your local machine!

- **NO** local Linux environment (such as WSL or VM) or PuTTY is needed! 
- **NO** makefile is needed for building executables any more! 

## Step 0: Get VS Code and SSH Extension Ready

- Download & Install [VS Code](https://code.visualstudio.com/) (if not already).
- Install VS Code Extension **Remote - SSH**

## Step 1: Set Up SSH Key Authentication and SSH Config (Optional)

### Windows 10 (version 1803 or later)

- Open **Windows PowerShell** (Keyboard Shortcut: **Win+X** -> Windows PowerShell)
- Run command `ssh-keygen`
  - You don't need to (of course you can) change the default location or set a password for the key, so press enter directly when you see any prompts
  - This command generates a pair of public and private key used in SSH Key Authentication
- Run command `cat ~/.ssh/id_rsa.pub | ssh username@pcXX.cs.ucdavis.edu "cat >> ~/.ssh/authorized_keys"`
  - You need to replace `username` and `XX` in the command
  - This command uploads the public key you just generated to a CSIF computer
- Open **VS Code** and click the little green button in the bottom-left corner of the window
- Select `Remote-SSH: Open Configuration File...` and choose the first option prompted
- Replace the file content with the following and save it (of course, you need to replace `username` and `XX` too)
    ```
    Host csif
        HostName pcXX.cs.ucdavis.edu
        User username
        IdentityFile ~/.ssh/id_rsa
    ```
- Return to **Windows PowerShell** and run command `ssh csif` to connect to a CSIF computer passwordlessly
  - This command tests if everything is configured successfully
  - If you are still prompted for entering a password, your SSH Key Authentication is not set up correctly
  - You can connect to CSIF in this passwordless way on your computer from now on!

### macOS & Linux

- Open **Terminal**
- Run command `ssh-keygen`
  - You don't need to (of course you can) change the default location or set a password for the key, so press enter directly when you see any prompts
  - This command generates a pair of public and private key used in SSH Key Authentication
- Run command `ssh-copy-id username@pcXX.cs.ucdavis.edu`
  - You need to replace `username` and `XX` in the command
  - This command uploads the public key you just generated to a CSIF computer
- Open **VS Code** and click the little green button in the bottom-left corner of the window
- Select `Remote-SSH: Open Configuration File...` and choose the first option prompted
- Replace the file content with the following and save it (of course, you need to replace `username` and `XX` too)
    ```
    Host csif
        HostName pcXX.cs.ucdavis.edu
        User username
        IdentityFile ~/.ssh/id_rsa
    ```

## Step 2: Create VS Code Tasks to Automate the Build Process

- Workig on it
