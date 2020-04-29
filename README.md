# VSCode Remote Assembly Debugging on UCDavis CSIF Computers

Debug your assembly code remotely and graphically on CSIF with VS Code **graphic debug interface** on your local machine!

- **NO** local Linux environment (such as WSL or VM) or PuTTY is needed! 
- **NO** makefile is needed for building executables any more! 
- **NO** need to use command-line `gdb` any more!

### What you need:
- [VS Code](https://code.visualstudio.com/)
- VS Code Extension **Remote - SSH**

## 5-min Quick Setup

- Open **VS Code**

- Click the little green button in the bottom-left corner of the window to open **Remote - SSH** extension

- Click **Remote-SSH: Connect to Host...**

- Select **csif** if you configured [Passwordless Login to CSIF](https://github.com/HazyFish/ucdavis-csif-passwordless)
  - If not, enter `username@pcXX.cs.ucdavis.edu` (of course, you need to replace `username` and `XX`) in the textbox prompted, press **enter**, and then type password

- Wait for VS Code to install VS Code Server on CSIF automatically
  - VS Code Server will be installed in `/home/username/.vscode-server` so other users don't have access to it
  - Retry if you get any error

- Install VS Code Extension **C/C++** by **Microsoft**
  - This will install the extension on VS Code Server on CSIF instead of your local machine
  - There is no assembly debugger available, but the config  of the **C/C++** extension will be modified to make it work with assembly

- Open an integrated terminal inside **VS Code** (**Terminal Menu** -> **New Terminal**)
  - You should notice that this terminal is already connected to the CSIF

- Run the following command inside the integrated terminal

  `git clone --depth=1 --branch=master https://github.com/HazyFish/ucdavis-csif-vscode-asm-dbg.git assembly && rm -rf ./assembly/.git`

  - This command transfers the folder with configiration files and a sample assembly code file (written by me) to CSIF

- Run command `code ./assembly` to open the folder in **VS Code**

- You are all almost there! Let's try it out!

## Try it out
- Click `hello.s` on the left to open the sample assembly code file

- Go to **Terminal Menu -> Run Build Task...** to build the executable from the currently opened file
  - You should be able to see the output of assembler and linker in the integrated terminal
  - The executable `hello.out` is built

- Go to **Run Menu -> Start Debugging** to start debugging the file you opened
  - You will see a `segmentation fault` because you haven't set a breakpoint yet
  - You can add breakpoints in the **Breakpoints** panel on the left of the window, such as `_start` and `done`
  - You can add expressions in the **Watch** panel on the left of the window to watch the values, such as `$eax` and `(int)a`

- Go to **Terminal Menu -> Run Task... -> clean all** to remove all the object files and executables inside the folder

- You are all set! You can put any assembly code files in this folder (or subfolder) to debug in this way!
  - Make sure to open the assembly file you want to build/debug before running the tasks or debugging !

- To disconnect VS Code from CSIF, click the little green button on the bottom left and select **Close Remote Connection**

## Give some Feedback
- Give a star to this if you enjoy it!
- Open up an issue or pull request to report typos, problems, or anything that can help make this better
- Follow me on GitHub!
