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
- Select **csif** if you followed [Step 1: Set Up Passwordless Login to CSIF (Optional)
](#step-1-set-up-passwordless-login-to-csif-optional)
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
- Create an assembly code file inside the folder with some code for testing, like `hello.s`
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
- Go to **Terminal Menu -> Configure Tasks... -> Create tasks.json file from template -> Others**
- Replace the content of `tasks.json` with the following and save it
  ```
  {
    // Made by HazyFish
    "version": "2.0.0",
    "tasks": [
        {
            "label": "assemble",
            "type": "shell",
            "command": "as",
            "args": [
                "${fileBasename}",
                "-o",
                "${fileBasenameNoExtension}.o",
                "--gstabs",
                "--32"
            ]
        },
        {
            "label": "link",
            "dependsOn": [
                "assemble"
            ],
            "type": "shell",
            "command": "ld",
            "args": [
                "${fileBasenameNoExtension}.o",
                "-o",
                "${fileBasenameNoExtension}.out",
                "-melf_i386"
            ],
            "problemMatcher": [],
            "group": {
                "kind": "build",
                "isDefault": true
            }
        },
        {
            "label": "debug",
            "dependsOn": [
                "link"
            ],
            "type": "shell",
            "command": "gdb",
            "args": [
                "${fileBasenameNoExtension}.out"
            ],
            "problemMatcher": []
        },
        {
            "label": "clean",
            "type": "shell",
            "command": "rm",
            "args": [
                "-f",
                "*.o",
                "*.out"
            ],
            "problemMatcher": []
        }
    ]
  }
  ```
- Open the test assembly code file like `hello.s`
- Go to **Terminal -> Run Build Task...** to build the executable from the currently opened file
  - You should be able to see the output of assembler and linker in the integrated terminal
  - The executable, like `hello.out`, is built
- Go to **Terminal -> Run Task... -> debug** to debug the the executable built from the currently opened file
  - You should be able to see `gdb` start running in the integrated terminal
  - In the next step, you will be able to use the graphic debug interface in VS Code
- Go to **Terminal -> Run Task... -> clean** to remove all the object files and executables
- You are almost there! The task definition file can be used for any assembly code files in the same folder!
  - Make sure to open the assembly file you want to build/debug before running the tasks!

## Step 4: Connect gdb with the Graphic Debug Interface in VS Code

- Connect to CSIF in **VS Code** and open the open the folder from the last step (`asm-repo`) if not already
- Install VS Code Extension **C/C++** by **Microsoft**
  - This will install the extension on VS Code Server on CSIF instead of your local machine
  - There is no assembly debugger available, but we will later modify the config of the **C/C++** extension to make it work with assembly
- Go to **Run Menu -> Add Configuration... -> C++ (GDB/LLDB)**
- Replace the content of `launch.json` with the following and save it
  ```
  {
    // Made by HazyFish
    "version": "0.2.0",
    "configurations": [
        {
            "name": "(gdb) Launch",
            "type": "cppdbg",
            "request": "launch",
            "preLaunchTask": "link",
            "program": "${workspaceFolder}/${fileBasenameNoExtension}.out",
            "args": [],
            "stopAtEntry": true,
            "cwd": "${workspaceFolder}",
            "environment": [],
            "externalConsole": false,
            "MIMode": "gdb",
            "setupCommands": [
                {
                    "description": "Enable pretty-printing for gdb",
                    "text": "-enable-pretty-printing",
                    "ignoreFailures": false
                }
            ]
        }
    ]
  }
  ```
- Open the test assembly code file like `hello.s`
- Go to **Run Menu -> Start Debugging** to start debugging the file you opened
- You are all set now!
  - You can add expressions in the **Watch** panel to watch the values, such as `$eax`, or `(long)a`
  - You can add breakpoints in the **Breakpoints** panel

## Step 5: Give me some Feedback
- Give a star to this if you enjoy it!
- Open up an issue or pull request to report typos, problems, or anything that can help me make this better
- Follow me on GitHub! (optional)
