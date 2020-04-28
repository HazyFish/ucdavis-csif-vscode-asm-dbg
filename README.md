# VSCode Remote Assembly Debugging on UCDavis CSIF Computers

Debug your assembly code remotely on CSIF with VS Code on your local machine!

- **NO** local Linux environment (such as WSL or VM) or PuTTY is needed! 
- **NO** makefile is needed for building executables any more! 

## Step 0: Get VS Code and SSH Extension Ready

- Download & Install [VS Code](https://code.visualstudio.com/) (if not already).
- Install VS Code Extension **Remote - SSH**

## Step 1: Set Up Passwordless Login to CSIF (Optional)

In this step, you will setup passwordless login to CSIF using SSH Key Authentication and SSH Config. 

Jump to: [Windows 10 (version 1803 or later)](#windows-10-version-1803-or-later) | [Windows (earlier versions)](#windows-earlier-versions) | [macOS & Linux](#macos--linux)

### Windows 10 (version 1803 or later)

- Open **Windows PowerShell** (Keyboard Shortcut: **Win+X** -> Windows PowerShell)
- Run command `ssh-keygen`
  - You don't need to (of course you can) change the default location or set a password for the key, so press enter directly when you see any prompts
  - This command generates a pair of public and private key used in SSH Key Authentication
- Run command `cat ~/.ssh/id_rsa.pub | ssh username@pcXX.cs.ucdavis.edu "cat >> ~/.ssh/authorized_keys"`
  - You need to replace `username` and `XX` in the command
  - This command uploads the public key you just generated to a CSIF computer
- Open **VS Code** and click the little green button in the bottom-left corner of the window
- Select **Remote-SSH: Open Configuration File...** and choose the first option prompted
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
  
### Windows (earlier versions)

- If you are using Windows 10 version 1709 (Fall Creators Update), follow [How to Enable and Use Windows 10’s New Built-in SSH Commands](https://www.howtogeek.com/336775/how-to-enable-and-use-windows-10s-built-in-ssh-commands/) and then follow the instructions in [the previous section](#windows-10-version-1803-or-later)
- If you are using an even older version of Windows, figure out how to run SSH commands by yourself and then follow the instructions in [the previous section](#windows-10-version-1803-or-later)

### macOS & Linux

- Open **Terminal**
- Run command `ssh-keygen`
  - You don't need to (of course you can) change the default location or set a password for the key, so press enter directly when you see any prompts
  - This command generates a pair of public and private key used in SSH Key Authentication
- Run command `ssh-copy-id username@pcXX.cs.ucdavis.edu`
  - You need to replace `username` and `XX` in the command
  - This command uploads the public key you just generated to a CSIF computer
- Open **VS Code** and click the little green button in the bottom-left corner of the window
- Select **Remote-SSH: Open Configuration File...** and choose the first option prompted
- Replace the file content with the following and save it (of course, you need to replace `username` and `XX` too)
    ```
    Host csif
        HostName pcXX.cs.ucdavis.edu
        User username
        IdentityFile ~/.ssh/id_rsa
    ```
- Return to **Terminal** and run command `ssh csif` to connect to a CSIF computer passwordlessly
  - This command tests if everything is configured successfully
  - If you are still prompted for entering a password, your SSH Key Authentication is not set up correctly
  - You can connect to CSIF in this passwordless way on your computer from now on!

## Step 2: Setup VS Code Server

- Open **VS Code**
- Click the little green button in the bottom-left corner of the window
- Select **Remote-SSH: Connect to Host...**
- Select **csif** if you followed [Step 1](#step-1-set-up-passwordless-login-to-csif-optional)
  - If not, enter `username@pcXX.cs.ucdavis.edu` (of course, you need to replace `username` and `XX`) and press **enter**
- Wait for VS Code to install VS Code Server on CSIF automatically
  - VS Code Server will be installed in `/home/username/.vscode-server` so other users don't have access to it
  - Retry if you get any error

## Step 3: Configure Tasks in VS Code

- Connect to CSIF in **VS Code** (if not already)
- Open an integrated terminal inside **VS Code** (Terminal Menu -> New Terminal)
  - You should notice that this terminal is already connected to the CSIF
- Create a directory for assembly code files, like `mkdir asm-repo`
- Open the directory in **VS Code**, like `code ./asm-repo`
  - A new window should be opened
- Create an assembly code file inside the folder with some code for testing, like `hello.asm`
  ```
  .global _start

  .data
  a:
      .long 16

  .text
  _start:
      movl a, %eax
      addl $4, %eax
  
  done:
      nop

  ```
- TO BE CONTINUED
  

## Step 4: Connect gdb with the Graphic Debug Interface in VS Code

- Connect to CSIF in **VS Code** if not already
- Install VS Code Extension **C/C++** by **Microsoft**
  - This will install the extension on VS Code Server on CSIF instead of your local machine
  - There is no assembly debugger available, but we will later modify the config of the **C/C++** extension to make it work with assembly
- TO BE CONTINUED

