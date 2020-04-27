# VSCode Assembly Debugging with UCDavis CSIF 

Debug your assembly code remotely on CSIF with VS Code on your local machine!

**NO** local Linux environment (such as WSL or VM) or PuTTY is needed! 

## Step 0: Get VS Code and SSH Extension Ready

- Download & Install [VS Code](https://code.visualstudio.com/) (if not already).
- Install VS Code Extension **Remote - SSH**

## Step 1: Set Up SSH Key Authentication and SSH Config (Optional)

### Windows 10

- Open **Windows PowerShell** (Keyboard Shortcut: **Win+X** -> Windows PowerShell)
- Run command `ssh-keygen` and press enter directly when you see any prompt(s)
  - This command generates a pair of public and private key used in SSH Key Authentication
- Run command `cat ~/.ssh/id_rsa.pub | ssh username@pcXX.cs.ucdavis.edu "cat >> ~/.ssh/authorized_keys"`
  - You need to replace `username` and `XX` in the command
  - This command uploads the public key you just generated to a CSIF computer
- Open **VS Code** and click the green button on the bottom-left corner
- Select `Remote-SSH: Open Configuration File...` and choose the first option prompted
- Replace the file content with the following and save it (of course, you need to replace `username` and `XX` too)
    ```
    Host csif
        HostName pcXX.cs.ucdavis.edu
        User username
        IdentityFile ~/.ssh/id_rsa
    ```
- Return to **Windows PowerShell** and run command `ssh csif` to test if everything is configured successfully
  - You can connect to CSIF in this way from now on!

### macOS

- Working on it

## Step 2: Create VS Code Tasks to Automate the Build Process of Assembly Code

- Workig on it
